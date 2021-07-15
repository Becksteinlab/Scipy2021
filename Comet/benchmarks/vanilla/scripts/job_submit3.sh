#!/bin/bash

mkdir -p /oasis/projects/nsf/azs119/edisj/Comet/benchmarks/3-full_node/results/$1/slurm_output
cd /oasis/projects/nsf/azs119/edisj/Comet/benchmarks/3-full_node/results/$1/slurm_output

for repeat in 1 2 3
do
    #sbatch /oasis/projects/nsf/azs119/edisj/Comet/benchmarks/3-full_node/scripts/copy_file.sh /oasis/projects/nsf/azs119/edisj/Comet/benchmarks/3-full_node/scripts/2node24.sh $1 $repeat
    #sbatch /oasis/projects/nsf/azs119/edisj/Comet/benchmarks/3-full_node/scripts/copy_file.sh /oasis/projects/nsf/azs119/edisj/Comet/benchmarks/3-full_node/scripts/4node72.sh $1 $repeat
    #sbatch /oasis/projects/nsf/azs119/edisj/Comet/benchmarks/3-full_node/scripts/copy_file.sh /oasis/projects/nsf/azs119/edisj/Comet/benchmarks/3-full_node/scripts/6node120.sh $1 $repeat
    sbatch /oasis/projects/nsf/azs119/edisj/Comet/benchmarks/3-full_node/scripts/copy_file.sh /oasis/projects/nsf/azs119/edisj/Comet/benchmarks/3-full_node/scripts/8node168.sh $1 $repeat
    sbatch /oasis/projects/nsf/azs119/edisj/Comet/benchmarks/3-full_node/scripts/copy_file.sh /oasis/projects/nsf/azs119/edisj/Comet/benchmarks/3-full_node/scripts/12node264.sh $1 $repeat
    sbatch /oasis/projects/nsf/azs119/edisj/Comet/benchmarks/3-full_node/scripts/copy_file.sh /oasis/projects/nsf/azs119/edisj/Comet/benchmarks/3-full_node/scripts/16node360.sh $1 $repeat
done
