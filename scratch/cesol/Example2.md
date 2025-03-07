### Description

Traditional iteration
### Files

[Example2](https://github.com/ORNL-Fusion/ips-fastran-doc/tree/main/examples/solps/example2)

b2mn.dat
```
'b2news_no_solve' '0'
'b2mndr_ntim' '1000'
```

### Run

Run on CPU compuatational node

submitjob
```
#!/bin/bash -l
#SBATCH -q regular
#SBATCH -N 1
#SBATCH -t 03:00:00
#SBATCH -J ips_solps
#SBATCH -e ips.err
#SBATCH -o ips.out
#SBATCH -C cpu

module load python
source activate /global/common/software/atom/perlmutter/cesol/conda/latest

ips.py --simulation=solps_iter.config --platform=$MACHINE_CONFIG --log=ips.log
```

set number of MPI cores

solps_iter.conf
```bash
[solps_solver]
       CLASS = solps
       SUB_CLASS =
       NAME = solps_solver
       MODULE = solps_iter.solps_solver
       NPROC = 16
       SCRIPT =
```

### Collect output

Collect output
```
collect_solps.py --rdir=RUN --sdir=summary --iteration
```

### Check plot

```
plot_solps.py --simid=summary --trace 
```

```
plot_solps.py --simid=summary --omp
```