#!/bin/bash

mkdir -p /pylon5/mc4sb2p/edisj/Bridges/benchmarks/masked_array_1/results/$1/slurm_output
cd /pylon5/mc4sb2p/edisj/Bridges/benchmarks/masked_array_1/results/$1/slurm_output

for repeat in 1 2 3
do
    sbatch /pylon5/mc4sb2p/edisj/Bridges/benchmarks/masked_array_1/scripts/copy_file.sh /pylon5/mc4sb2p/edisj/Bridges/benchmarks/masked_array_1/scripts/2node28.sh $1 $repeat
    sbatch /pylon5/mc4sb2p/edisj/Bridges/benchmarks/masked_array_1/scripts/copy_file.sh /pylon5/mc4sb2p/edisj/Bridges/benchmarks/masked_array_1/scripts/4node84.sh $1 $repeat
    sbatch /pylon5/mc4sb2p/edisj/Bridges/benchmarks/masked_array_1/scripts/copy_file.sh /pylon5/mc4sb2p/edisj/Bridges/benchmarks/masked_array_1/scripts/6node140.sh $1 $repeat
    sbatch /pylon5/mc4sb2p/edisj/Bridges/benchmarks/masked_array_1/scripts/copy_file.sh /pylon5/mc4sb2p/edisj/Bridges/benchmarks/masked_array_1/scripts/8node196.sh $1 $repeat
    sbatch /pylon5/mc4sb2p/edisj/Bridges/benchmarks/masked_array_1/scripts/copy_file.sh /pylon5/mc4sb2p/edisj/Bridges/benchmarks/masked_array_1/scripts/12node308.sh $1 $repeat
    sbatch /pylon5/mc4sb2p/edisj/Bridges/benchmarks/masked_array_1/scripts/copy_file.sh /pylon5/mc4sb2p/edisj/Bridges/benchmarks/masked_array_1/scripts/16node420.sh $1 $repeat
done
