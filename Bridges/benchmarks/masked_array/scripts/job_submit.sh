#!/bin/bash

mkdir -p /pylon5/mc4sb2p/edisj/Bridges/benchmarks/masked_array_1/results/$1/slurm_output
cd /pylon5/mc4sb2p/edisj/Bridges/benchmarks/masked_array_1/results/$1/slurm_output

for repeat in 1 2 3
do
    sbatch /pylon5/mc4sb2p/edisj/Bridges/benchmarks/masked_array_1/scripts/copy_file.sh /pylon5/mc4sb2p/edisj/Bridges/benchmarks/masked_array_1/scripts/1node1.sh $1 $repeat
    sbatch /pylon5/mc4sb2p/edisj/Bridges/benchmarks/masked_array_1/scripts/copy_file.sh /pylon5/mc4sb2p/edisj/Bridges/benchmarks/masked_array_1/scripts/1node28.sh $1 $repeat
    sbatch /pylon5/mc4sb2p/edisj/Bridges/benchmarks/masked_array_1/scripts/copy_file.sh /pylon5/mc4sb2p/edisj/Bridges/benchmarks/masked_array_1/scripts/2node56.sh $1 $repeat
    sbatch /pylon5/mc4sb2p/edisj/Bridges/benchmarks/masked_array_1/scripts/copy_file.sh /pylon5/mc4sb2p/edisj/Bridges/benchmarks/masked_array_1/scripts/4node112.sh $1 $repeat
    #sbatch /pylon5/mc4sb2p/edisj/Bridges/benchmarks/masked_array_1/scripts/copy_file.sh /pylon5/mc4sb2p/edisj/Bridges/benchmarks/masked_array_1/scripts/6node168.sh $1 $repeat
    sbatch /pylon5/mc4sb2p/edisj/Bridges/benchmarks/masked_array_1/scripts/copy_file.sh /pylon5/mc4sb2p/edisj/Bridges/benchmarks/masked_array_1/scripts/8node224.sh $1 $repeat
    #sbatch /pylon5/mc4sb2p/edisj/Bridges/benchmarks/masked_array_1/scripts/copy_file.sh /pylon5/mc4sb2p/edisj/Bridges/benchmarks/masked_array_1/scripts/12node336.sh $1 $repeat
    sbatch /pylon5/mc4sb2p/edisj/Bridges/benchmarks/masked_array_1/scripts/copy_file.sh /pylon5/mc4sb2p/edisj/Bridges/benchmarks/masked_array_1/scripts/16node448.sh $1 $repeat
done
