#!/bin/bash

#SBATCH --nodes=1  # number of nodes
#SBATCH --ntasks-per-node=1  # number of cores
#SBATCH --partition=compute       # partition
#SBATCH -e slurm.%j.err # file to save job's STDERR (%j = JobId)
#SBATCH -o slurm.%j.out # file to save job's STDOUT (%j = JobId)
#SBATCH --export=ALL
#SBATCH -t 48:00:00   # time in hh:mm:ss
#SBATCH --mail-type=ALL # Send an e-mail when a job starts, stops, or fails
#SBATCH --mail-user=ejakupov@asu.edu # Mail-to address

module unload mvapich2_ib/2.3.2
module load openmpi_ib/3.1.4
module load hdf5/1.10.3
source activate mda8

python small_to_large_traj.py
