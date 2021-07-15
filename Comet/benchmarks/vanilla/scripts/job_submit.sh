#!/bin/bash

mkdir -p /oasis/projects/nsf/azs119/edisj/Comet/benchmarks/3-full_node/results/$1/slurm_output
cd /oasis/projects/nsf/azs119/edisj/Comet/benchmarks/3-full_node/results/$1/slurm_output

for repeat in 1 2 3
do
    sbatch /oasis/projects/nsf/azs119/edisj/Comet/benchmarks/3-full_node/scripts/copy_file.sh /oasis/projects/nsf/azs119/edisj/Comet/benchmarks/3-full_node/scripts/1node1.sh $1 $repeat
    sbatch /oasis/projects/nsf/azs119/edisj/Comet/benchmarks/3-full_node/scripts/copy_file.sh /oasis/projects/nsf/azs119/edisj/Comet/benchmarks/3-full_node/scripts/1node24.sh $1 $repeat
    sbatch /oasis/projects/nsf/azs119/edisj/Comet/benchmarks/3-full_node/scripts/copy_file.sh /oasis/projects/nsf/azs119/edisj/Comet/benchmarks/3-full_node/scripts/2node48.sh $1 $repeat
    sbatch /oasis/projects/nsf/azs119/edisj/Comet/benchmarks/3-full_node/scripts/copy_file.sh /oasis/projects/nsf/azs119/edisj/Comet/benchmarks/3-full_node/scripts/4node96.sh $1 $repeat
    sbatch /oasis/projects/nsf/azs119/edisj/Comet/benchmarks/3-full_node/scripts/copy_file.sh /oasis/projects/nsf/azs119/edisj/Comet/benchmarks/3-full_node/scripts/6node144.sh $1 $repeat
    sbatch /oasis/projects/nsf/azs119/edisj/Comet/benchmarks/3-full_node/scripts/copy_file.sh /oasis/projects/nsf/azs119/edisj/Comet/benchmarks/3-full_node/scripts/8node192.sh $1 $repeat
    sbatch /oasis/projects/nsf/azs119/edisj/Comet/benchmarks/3-full_node/scripts/copy_file.sh /oasis/projects/nsf/azs119/edisj/Comet/benchmarks/3-full_node/scripts/12node288.sh $1 $repeat
    sbatch /oasis/projects/nsf/azs119/edisj/Comet/benchmarks/3-full_node/scripts/copy_file.sh /oasis/projects/nsf/azs119/edisj/Comet/benchmarks/3-full_node/scripts/16node384.sh $1 $repeat
done
