#!/bin/bash

#SBATCH --nodes=1  # number of nodes
#SBATCH --ntasks-per-node=1  # number of cores
#SBATCH --partition=compute       # partition
#SBATCH -e slurm.%j.err # file to save job's STDERR (%j = JobId)
#SBATCH -o slurm.%j.out # file to save job's STDOUT (%j = JobId)
#SBATCH -t 02:00:00   # time in hh:mm:ss

module unload mvapich2_ib/2.3.2
module load openmpi_ib/3.1.4
module load hdf5/1.10.3
source activate mda8

python YiiP_chunked.py
