#!/bin/bash -l
#SBATCH -q debug
#SBATCH -N 1 
#SBATCH -t 00:30:00
#SBATCH -J ips_eped 
#SBATCH -e ips.err
#SBATCH -o ips.out
#SBATCH -C cpu 

module load python
source activate /global/common/software/atom/perlmutter/cesol/conda/dev

export OMP_NUM_THREADS=1
export NPROC_EPED=128

#export RUN_PARALLEL_BIN_PATH=/global/common/software/atom/perlmutter/binaries/run_parallel/beta

ips.py --simulation=eped.config --platform=$MACHINE_CONFIG --log=ips.log --log=ips.log
