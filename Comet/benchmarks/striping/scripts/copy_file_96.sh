#!/bin/bash

#SBATCH --nodes=1  # number of nodes
#SBATCH --ntasks-per-node=1  # number of cores
#SBATCH --partition=compute       # partition
#SBATCH -e %j.err # file to save job's STDERR (%j = JobId)
#SBATCH -o %j.out # file to save job's STDOUT (%j = JobId)
#SBATCH --export=ALL
#SBATCH -t 05:00:00   # time in hh:mm:ss

#echo commands to stdout
set -x

sbatch --dependency=$SLURM_JOB_ID $1 $2 $3

TEST_TOP=/oasis/scratch/comet/edisj/temp_project/benchmarking/datafiles/YiiP_system.pdb
TEST_TRAJ=/oasis/scratch/comet/edisj/temp_project/benchmarking/datafiles/YiiP_system_9ns_center100x.h5md

testdir=/oasis/scratch/comet/edisj/temp_project/stripe96/$SLURM_JOB_ID
mkdir -p $testdir
time cp $TEST_TOP $testdir
time cp $TEST_TRAJ $testdir
