#!/bin/bash

mkdir -p /pylon5/mc4sb2p/edisj/Bridges/benchmarks/2-full_IO/results/$1/slurm_output
cd /pylon5/mc4sb2p/edisj/Bridges/benchmarks/2-full_IO/results/$1/slurm_output

for repeat in 1 2 3
do
    sbatch /pylon5/mc4sb2p/edisj/Bridges/benchmarks/2-full_IO/scripts/copy_file.sh /pylon5/mc4sb2p/edisj/Bridges/benchmarks/2-full_IO/scripts/1node1.sh $1 $repeat
    sbatch /pylon5/mc4sb2p/edisj/Bridges/benchmarks/2-full_IO/scripts/copy_file.sh /pylon5/mc4sb2p/edisj/Bridges/benchmarks/2-full_IO/scripts/1node28.sh $1 $repeat
    sbatch /pylon5/mc4sb2p/edisj/Bridges/benchmarks/2-full_IO/scripts/copy_file.sh /pylon5/mc4sb2p/edisj/Bridges/benchmarks/2-full_IO/scripts/2node28.sh $1 $repeat
    sbatch /pylon5/mc4sb2p/edisj/Bridges/benchmarks/2-full_IO/scripts/copy_file.sh /pylon5/mc4sb2p/edisj/Bridges/benchmarks/2-full_IO/scripts/2node56.sh $1 $repeat
    sbatch /pylon5/mc4sb2p/edisj/Bridges/benchmarks/2-full_IO/scripts/copy_file.sh /pylon5/mc4sb2p/edisj/Bridges/benchmarks/2-full_IO/scripts/4node84.sh $1 $repeat
    sbatch /pylon5/mc4sb2p/edisj/Bridges/benchmarks/2-full_IO/scripts/copy_file.sh /pylon5/mc4sb2p/edisj/Bridges/benchmarks/2-full_IO/scripts/4node112.sh $1 $repeat
    sbatch /pylon5/mc4sb2p/edisj/Bridges/benchmarks/2-full_IO/scripts/copy_file.sh /pylon5/mc4sb2p/edisj/Bridges/benchmarks/2-full_IO/scripts/6node140.sh $1 $repeat
    sbatch /pylon5/mc4sb2p/edisj/Bridges/benchmarks/2-full_IO/scripts/copy_file.sh /pylon5/mc4sb2p/edisj/Bridges/benchmarks/2-full_IO/scripts/6node168.sh $1 $repeat
    sbatch /pylon5/mc4sb2p/edisj/Bridges/benchmarks/2-full_IO/scripts/copy_file.sh /pylon5/mc4sb2p/edisj/Bridges/benchmarks/2-full_IO/scripts/8node196.sh $1 $repeat
    sbatch /pylon5/mc4sb2p/edisj/Bridges/benchmarks/2-full_IO/scripts/copy_file.sh /pylon5/mc4sb2p/edisj/Bridges/benchmarks/2-full_IO/scripts/8node224.sh $1 $repeat
    sbatch /pylon5/mc4sb2p/edisj/Bridges/benchmarks/2-full_IO/scripts/copy_file.sh /pylon5/mc4sb2p/edisj/Bridges/benchmarks/2-full_IO/scripts/12node308.sh $1 $repeat
    sbatch /pylon5/mc4sb2p/edisj/Bridges/benchmarks/2-full_IO/scripts/copy_file.sh /pylon5/mc4sb2p/edisj/Bridges/benchmarks/2-full_IO/scripts/12node336.sh $1 $repeat
    sbatch /pylon5/mc4sb2p/edisj/Bridges/benchmarks/2-full_IO/scripts/copy_file.sh /pylon5/mc4sb2p/edisj/Bridges/benchmarks/2-full_IO/scripts/16node420.sh $1 $repeat
    sbatch /pylon5/mc4sb2p/edisj/Bridges/benchmarks/2-full_IO/scripts/copy_file.sh /pylon5/mc4sb2p/edisj/Bridges/benchmarks/2-full_IO/scripts/16node448.sh $1 $repeat
done
