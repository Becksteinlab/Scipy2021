#!/bin/bash

#SBATCH --nodes=12  # number of nodes
#SBATCH --ntasks-per-node=24  # number of cores
#SBATCH --partition=compute       # partition
#SBATCH -e 12node288.%j.err # file to save job's STDERR (%j = JobId)
#SBATCH -o 12node288.%j.out # file to save job's STDOUT (%j = JobId)
#SBATCH -t 01:00:00   # time in hh:mm:ss
#SBATCH --mail-type=ALL # Send an e-mail when a job starts, stops, or fails
#SBATCH --mail-user=ejakupov@asu.edu # Mail-to address

#echo commands to stdout
set -x

module unload mvapich2_ib/2.3.2
module load openmpi_ib/3.1.4
module load hdf5/1.10.3
source activate mda8

testdir=/oasis/scratch/comet/edisj/temp_project/benchmarking/$SLURM_JOB_DEPENDENCY

export OMP_NUM_THREADS=1

time ibrun -np 288 python -W ignore /oasis/projects/nsf/azs119/edisj/Comet/benchmarks/in_memory_1/scripts/benchmark.py $testdir/YiiP_system.pdb $testdir/YiiP_system_9ns_center100x.h5md $1/12node_$2

rm -r $testdir
