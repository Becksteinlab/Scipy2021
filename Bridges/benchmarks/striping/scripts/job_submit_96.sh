#!/bin/bash

mkdir -p /pylon5/mc4sb2p/edisj/Bridges/benchmarks/striping/results/$1/slurm_output
cd /pylon5/mc4sb2p/edisj/Bridges/benchmarks/striping/results/$1/slurm_output

for repeat in 1 2 3
do
    sbatch /pylon5/mc4sb2p/edisj/Bridges/benchmarks/striping/scripts/copy_file_96.sh /pylon5/mc4sb2p/edisj/Bridges/benchmarks/striping/scripts/1node1_96.sh $1 $repeat
    sbatch /pylon5/mc4sb2p/edisj/Bridges/benchmarks/striping/scripts/copy_file_96.sh /pylon5/mc4sb2p/edisj/Bridges/benchmarks/striping/scripts/1node28_96.sh $1 $repeat
    sbatch /pylon5/mc4sb2p/edisj/Bridges/benchmarks/striping/scripts/copy_file_96.sh /pylon5/mc4sb2p/edisj/Bridges/benchmarks/striping/scripts/2node56_96.sh $1 $repeat
    sbatch /pylon5/mc4sb2p/edisj/Bridges/benchmarks/striping/scripts/copy_file_96.sh /pylon5/mc4sb2p/edisj/Bridges/benchmarks/striping/scripts/4node112_96.sh $1 $repeat
done
