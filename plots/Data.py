import numpy as np
import pandas as pd
from collections import OrderedDict
import os

class Data(object):

    
    def __init__(self, path_to_results, **kwargs):
        
        self.path = path_to_results
        self.repeats = kwargs.get('repeats', self.parse_repeats())
        self.columns = kwargs.get('columns', self.parse_columns())
        self.cores_per_node = kwargs.get('cores_per_node', self.parse_cores_per_node())
    
    def parse_columns(self):
        
        path = self.path
        runs = [os.path.join(path, folder) for folder in os.listdir(path) if folder != 'slurm_output']
        for run in runs:
            for file in os.listdir(run):
                fpath = os.path.join(run, file)
                if fpath.endswith("csv"):
                    columns = list(pd.read_csv(fpath).columns)
                    del columns[0]
                    return columns
                
    def parse_repeats(self):
        
        return len(set([folder[-1] for folder in os.listdir(self.path) if folder != 'slurm_output']))
    
    def parse_nodes(self):
        
        return set([folder[0] for folder in os.listdir(path) if folder != 'slurm_output'])
    
    def parse_cores_per_node(self):
        
        path = self.path
        cores_per_node = OrderedDict({})
        nodes = sorted(set([int(folder.split('n')[0]) for folder in os.listdir(path) if folder != 'slurm_output']))
        for i in nodes:
            cores_per_node[str(i)] = None
        
        for node in nodes:
            for folder in os.listdir(path):
                if folder.split('n')[0] == str(node):
                    fpath = os.path.join(path,folder)
                    files = os.listdir(fpath)
                    cores = list((set([int(file.split('p')[0]) for file in files])))
                    cores_per_node[str(node)] = sorted(cores)
                    break
                    
        return cores_per_node
        
    def get_rmsd_array(self, N, n, trial):
        path = self.path
        
        return np.load(f'{path}/{N}node_{trial}/{n}process_rmsd.npy')
         
    
    def get_raw_data(self, N, n, averaged=False):
        """Gets the raw data from all repeats and displays in a pandas DataFrame.

        If averaged=True, it takes the average and standard deviation across all 
        repeats for all (rank x timing) elements.

        Parameters
        ----------
        n : int
            number of processes used in run
        averaged: bool (optional)

        Returns
        -------
        all data (if averaged=False) : pd.DataFrame
            pandas dataframe of raw data arrays stacked horizontally with no reductions
        means (if averaged=True) : pd.DataFrame
            mean across repeats for each (rank x timing) element
        stds (if averaged=True) : pd.DataFrame 
            standard deviation across repeats for each (rank x timing) element

        """

        path = self.path
        columns = self.columns
        repeats = self.repeats
        cores_per_node = self.cores_per_node
        _sum = sum([len(value) for value in cores_per_node.values()])
        n_columns = len(columns)

        arrays = [np.load(f'{path}/{N}node_{i}/{n}process_times.npy') for i in range(1, repeats+1)]

        if averaged:
            means_buffer = np.zeros(shape=(n, n_columns), dtype=float)
            stds_buffer = np.zeros(shape=(n, n_columns), dtype=float)

            # fills in means and std arrays 1 element at a time
            for i in range(n):
                for j in range(_sum):
                    temp_array = np.empty(repeats, dtype=float) 
                    for trial, k in enumerate(range(len(temp_array)), 1):
                        temp_array[k] = arrays[trial][i, j]
                    means_buffer[i, j] = np.mean(temp_array)
                    stds_buffer[i, j] = np.std(temp_array)

            means = pd.DataFrame(list(means_buffer), columns=columns)
            stds = pd.DataFrame(list(stds_buffer), columns=columns)
            return means, stds

        #arrays = tuple(arrays)
        a = np.hstack((arrays))

        return pd.DataFrame(list(a), columns=3*columns)
    
    def all_process_dataframe(self):
        """Gives DataFrame of averaged timings for all N_process runs.

        Returns
        -------
        times_dframe : pd.DataFrame
            benchmark times with timings first averaged across all ranks, then averaged across repeats
        stds_dframe : pd.DataFrame 
            standard deviation of the timings when averaged across repeats   

        """

        path = self.path
        columns = self.columns
        columns[0] = 'N_Processes'
        repeats = self.repeats
        nodes = self.cores_per_node
        _sum = sum([len(value) for value in nodes.values()])
        n_columns = len(columns)


        data_buffer = np.empty(shape=(_sum, n_columns), dtype=float)
        stds_buffer = np.empty(shape=(_sum, n_columns), dtype=float)

        count = -1
        for N in nodes.keys():
            for i, cores in enumerate(nodes[f'{N}'], count+1):
                count = i
                means, stds = self.reduce_to_means(N, cores)
                for j in range(n_columns):
                    data_buffer[i, j] = means[j]
                    stds_buffer[i, j] = stds[j]


        times_dframe = pd.DataFrame(list(data_buffer), columns=columns).set_index('N_Processes')
        stds_dframe = pd.DataFrame(list(stds_buffer), columns=columns).set_index('N_Processes')

        return times_dframe, stds_dframe
    
    def reduce_to_means(self, N, n):
        """Helper function to reduce data from numpy arrays.

        First it takes the mean across all ranks for each timing,
        then it takes the mean and standard deviation across the repeats.

        Parameters
        ----------
        n : int
            number of processes used in run

        Returns
        -------
        means : list
            mean across number of repeats for each timing
        stds : list
            standard deviation across repeats for each timing

        """

        path = self.path
        columns = self.columns
        repeats = self.repeats
        cores_per_node = self.cores_per_node
        _sum = sum([len(value) for value in cores_per_node.values()])

        raw_data = self.get_raw_data(N, n)

        times = OrderedDict({})

        for name in columns:
            mean_across_ranks = []
            for i in range(repeats):
                if repeats == 1:
                    mean_across_ranks.append(np.mean(np.array(raw_data.loc[:, name])[:]))
                else:
                    mean_across_ranks.append(np.mean(np.array(raw_data.loc[:, name])[:, i]))

            times[name] = mean_across_ranks

        means = [np.mean(value) for value in list(times.values())]
        stds = [np.std(value) for value in list(times.values())]
        means[0], stds[0] = n, n

        return means, stds
    
    def scaling(self):
        
        times, errs = self.all_process_dataframe()
        
        t1 = np.array(times.loc[1, :])
        t1_errs = np.array(errs.loc[1, :])
        
        tN = np.array(times.loc[:,:])
        tN_errs = np.array(errs.loc[:,:])
        
        s = t1/tN
        err = np.sqrt( (t1_errs/t1)**2 + (tN_errs/tN)**2 ) * s
        
        scaling = times.copy()
        scaling.loc[:,:] = s
        propagated_err = errs.copy()
        propagated_err.loc[:,:] = err
        propagated_err.loc[1,:] = 0
        
        return scaling, propagated_err
    
    def efficiency(self):
        
        scaling, scaling_errs = self.scaling()
        efficiency = scaling.copy()
        propagated_err = scaling_errs.copy()
        
        s = np.array(scaling)
        s_err = np.array(scaling_errs)
        
        n = efficiency.index.to_numpy()
        
        e = np.array(efficiency)
        
        for i, n_proc in enumerate(n):
            e[i] = e[i] / n_proc
        err = (s_err/s)*e
        
        efficiency.loc[:,:] = e
        propagated_err.loc[:,:] = err
        
        return efficiency, propagated_err