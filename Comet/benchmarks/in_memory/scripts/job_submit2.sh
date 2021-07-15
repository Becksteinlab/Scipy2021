#!/bin/bash

mkdir -p /oasis/projects/nsf/azs119/edisj/Comet/benchmarks/in_memory_1/results/$1/slurm_output
cd /oasis/projects/nsf/azs119/edisj/Comet/benchmarks/in_memory_1/results/$1/slurm_output

for repeat in 1 2 3
do
    sbatch /oasis/projects/nsf/azs119/edisj/Comet/benchmarks/in_memory_1/scripts/copy_file.sh /oasis/projects/nsf/azs119/edisj/Comet/benchmarks/in_memory_1/scripts/2node24.sh $1 $repeat
    sbatch /oasis/projects/nsf/azs119/edisj/Comet/benchmarks/in_memory_1/scripts/copy_file.sh /oasis/projects/nsf/azs119/edisj/Comet/benchmarks/in_memory_1/scripts/4node72.sh $1 $repeat
    #sbatch /oasis/projects/nsf/azs119/edisj/Comet/benchmarks/in_memory_1/scripts/copy_file.sh /oasis/projects/nsf/azs119/edisj/Comet/benchmarks/in_memory_1/scripts/6node120.sh $1 $repeat
    #sbatch /oasis/projects/nsf/azs119/edisj/Comet/benchmarks/in_memory_1/scripts/copy_file.sh /oasis/projects/nsf/azs119/edisj/Comet/benchmarks/in_memory_1/scripts/8node168.sh $1 $repeat
    #sbatch /oasis/projects/nsf/azs119/edisj/Comet/benchmarks/in_memory_1/scripts/copy_file.sh /oasis/projects/nsf/azs119/edisj/Comet/benchmarks/in_memory_1/scripts/12node264.sh $1 $repeat
    #sbatch /oasis/projects/nsf/azs119/edisj/Comet/benchmarks/in_memory_1/scripts/copy_file.sh /oasis/projects/nsf/azs119/edisj/Comet/benchmarks/in_memory_1/scripts/16node360.sh $1 $repeat
done
