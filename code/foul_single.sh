#!/bin/bash
# Copy environment, join output and error, medium queue:
#PBS -V
#PBS -j oe
#PBS -q medium
#PBS -l cput=60:00:00
#PBS -m n

# Go to the directory where the job was submitted from
cd $PBS_O_WORKDIR
if [ $node -lt 10 ]; then filename="MAeval0$node"'.txt'; else filename="MAeval$node"'.txt'; fi
echo filename=$filename
sed -i "s/1 MAeval[0-9]*.txt/1 $filename/g" input_nsga_maxSpec
/share/apps/opt/matlab/bin/matlab -nojvm -r "tic; trainingday, toc, exit"

