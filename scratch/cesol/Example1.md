### Description

Read restart fie and run without solving any equations. All secondary and dependent data is computed
### Files

[Example1](https://github.com/ORNL-Fusion/ips-fastran-doc/tree/main/examples/solps/example1)

b2mn.dat
```
'b2news_no_solve' '1'
'b2mndr_ntim' '1'
```

### Run

Run on login node for test

submitjob
```
module load python
source activate /global/common/software/atom/perlmutter/cesol/conda/latest

ips.py --simulation=solps_iter.config --platform=$MACHINE_CONFIG_SERIAL --log=ips.log 1> ips.out 2> ips.err &
```

### Collect output

Collect output
```
collect_solps.py --rdir=RUN --sdir=summary --time=-1
```
