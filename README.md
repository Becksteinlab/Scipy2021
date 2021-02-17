# Scipy2021


Short Summary
-------------

MDAnalysis is a widely used Python library for the analysis of molecular dynamics simulations. As the size of the data files from these simulations is now commonly on the order of terabytes, file I/O has become a bottleneck in the workflow of analyzing simulation trajectories. We have implemented an HDF5-based file format trajectory reader into MDAnalysis that can perform parallel MPI I/O and benchmarked it on various national HPC environments. Although speed-ups on the order of 20x for 48 cores are attainable, scaling up to achieve higher parallel data ingestion rates remains challenging, even with parallel hdf5. We developed several algorithmic optimizations in our analysis workflows that lead to fixed in IO times of up to 10x on up to 112 cores.


Abstract
--------

MDAnalysis is a widely used Python library that streamlines the analysis of MD trajectories in that it can read and write over 20 popular MD file formats, but provides the same user-friendly interface no matter the file format [Gowers2016]. As HPC resources continue to increase, the size of molecular dynamics (MD) simulation files are now commonly on the order of terabytes. Serial analysis of these trajectory files is becoming impractical, as it can take up to a week to perform a single analysis, making parallel analysis a necessity for the efficient use of both HPC resources and a scientist’s time. Previous work has focused on developing a task-based approach to parallel analysis using the Dask library, however IO-bound tasks such as an RMSD calculation did not scale well in an HPC environment due to a file IO bottleneck [Fan2019].
Our previous feasibility study suggested that parallel reading via MPI-IO and HDF5 can lead to good scaling although it only used a reduced size custom HDF5 trajectory and did not provide a usable implementation of a true MD trajectory reader [Khoshlessan2020].
The study also found that, in some benchmark runs, some processes were “stragglers”, in that they lagged far behind the other processes and delayed the analysis time. We have implemented a parallel MPI-IO capable HDF5-based file format trajectory reader into MDAnalysis, H5MDReader, that adheres to H5MD (HDF5 for Molecular Dynamics) specifications [Buyl2013]. We benchmarked our reader on three HPC clusters: ASU Agave, SDSC Comet, and PSC Bridges. The benchmark consisted of a simple split-apply-combine scheme that split a 90k frame (113GB) trajectory into n chunks for n processes, where each process individually performed an RMSD calculation on their chunk of data, and then gathered the results back to the root process. This task represents an IO bound task in which the file IO is the limiting factor on total scaling. On Agave, we found IO speedups of up to 20x on 2 full nodes with 48 cores, which decreased to 8x at 4 nodes and 112 cores. On Bridges and Comet, we found no improvements to IO speedup beyond 2 full nodes, as the IO speedup was consistently between 4-5x up to 4 full nodes (112 and 96 cores, respectively). On the other hand, the computation time of the RMSD calculation scaled strongly on all three HPC resources, with a maximum speedup on Comet of 373x on 384 cores. Therefore, for a compute bound task, our implementation would likely scale very well, however the file IO still seems to impose a bottleneck on the total analysis scaling for an IO bound task. This could be due to MPI ranks competing for file access as the number of processes increases, or the filesystem bandwidth issues that a large scale, multi-user HPC environment faces. In an attempt to alleviate MPI rank competition, we investigated how an increased stripe count on Bridge’s and Comet’s Lustre filesystem affected the IO scaling. We found marginal fixed improvements of up to 1.2x on up to 4 full nodes. To investigate how file size impacts IO scaling, we performed the same benchmark on a smaller trajectory file that only included the necessary position coordinates for the RMSD calculation which resulted in speedups on Agave of up to 95x on 6 nodes and 140 cores, which indicates that IO speedup is greatly impacted by file size. Considering this result, we implemented a feature into the H5MDReader using NumPy masked arrays, where only the necessary coordinates for the computation task are read from the file, which resulted in a fixed improvement of approximately 5x on all three HPCs. Furthermore, we investigated how frontloading all the file IO directly with the h5py library by loading the trajectory into memory prior to the computation, rather than iterating through each timestep, affected the IO performance. This resulted in a fixed improvement on Agave of up to 10x on up to 112 cores. In addition, loading the trajectory into memory seemingly eliminated the “straggler” problem, in that all processes performed their block analysis is approximately the same time. The addition of the HDF5 reader provides a foundation for the development of parallel trajectory analysis with MPI and the MDAnalysis package.


Keywords
--------
HDF5, H5MD, MPI I/O, MDAnalysis, High Performance Computing


References
----------


.. [Gowers2016] R. J. Gowers, M. Linke, J. Barnoud, T. J. E. Reddy, M. N. Melo, S. L. Seyler, D. L. Dotson, J. Doman ́ski, S. Buchoux, I. M. Kenney, and O. Beckstein, “MDAnalysis: A Python package for the rapid analysis of molecular dynamics simulations,” in Proceedings of the 15th Python in Science Conference (S. Benthall and S. Rostrup, eds.), (Austin, TX), pp. 98–105, SciPy, 2016.

.. [Khoshlessan2017] M. Khoshlessan, I. Paraskevakos, S. Jha, and O. Beckstein, “Parallel analysis in MDAnalysis using the Dask parallel computing library,” in Proceedings of the 16th Python in Science Conference (Katy Huff, David Lippa, Dillon Niederhut, and M. Pacer, eds.), (Austin, TX), pp. 64–72, SciPy, 2017.

.. [Paraskevakos2018] I. Paraskevakos, A. Luckow, M. Khoshlessan, G. Chantzialexiou, T. E. Cheatham, O. Beckstein, G. Fox, and S. Jha, “Task-parallel analysis of molecular dynamics trajectories,” in ICPP 2018: 47th International Conference on Parallel Processing, August 13–16, 2018, Eugene, OR, USA, (New York, NY, USA), p. Article No. 49, Association for Computing Machinery, ACM, August 13–16 2018.

.. [Fan2019] S. Fan, M. Linke, I. Paraskevakos, R. J. Gowers, M. Gecht, and O. Beckstein, “PMDA - Parallel Molecular Dynamics Analysis,” in Proceedings of the 18th Python in Science Confer- ence (Chris Calloway, David Lippa, Dillon Niederhut, and David Shupe, eds.), (Austin, TX), pp. 134 – 142, SciPy, 2019.

.. [Khoshlessan2020] M. Khoshlessan, I. Paraskevakos, G. C. Fox, S. Jha, and O. Beckstein, “Parallel performance of molecular dynamics trajectory analysis,” Concurrency and Computation: Practice and Experience, vol. 32, p. e5789, 2020.

.. [Buyl2013] P. Buyl, P. Colberg, and Felix H ̈ofling. "H5MD: A structured, efficient, and portable file format for molecular data," Computer Physics Communications, 185, 2013 10.1016/j.cpc.2014.01.018.
