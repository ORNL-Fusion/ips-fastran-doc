#!/bin/bash -l
#SBATCH -q premium
#SBATCH -N 5 
#SBATCH -t 00:30:00
#SBATCH -J ips_eped 
#SBATCH -e ips.err
#SBATCH -o ips.out
#SBATCH -C cpu 

module load python
source activate /global/common/software/atom/perlmutter/cesol/conda/dev

export OMP_NUM_THREADS=1
export NPROC_EPED=128

# ips.py --simulation=eped.config --platform=$MACHINE_CONFIG --log=ips.log --log=ips.log
ips_dakota_dynamic.py --dakotaconfig=dakota.in --simulation=eped.config --platform=$MACHINE_CONFIG --log=ips_sweep.log
