#!/bin/bash

#The name of the job is test_job
#SBATCH -J rnnlm1_job

#The job requires 1 compute node
#SBATCH -N 1

#The job requires 1 task per node
#SBATCH --ntasks-per-node=1

#The maximum walltime of the job is a 8 days
#SBATCH -t 192:00:00

#SBATCH --mem=50G

#Leave this here if you need a GPU for your job
#SBATCH --partition=gpu

#SBATCH --gres=gpu:tesla:1

#The module with all the NMT / deep learning packages
module load python-2.7.13

# PEOPLE HI, YOUR COMMANDS GO HERE
# This script have mot been executed yet
python translate.py -model /gpfs/hpchome/komisare/project/models/demo-model_acc_78.30_ppl_2.86_e13.pt -src /gpfs/hpchome/komisare/project/data/raw-all/bpe.tc-tok-test.et -output /gpfs/hpchome/komisare/project/data/raw-all/hyps.en -gpu 0