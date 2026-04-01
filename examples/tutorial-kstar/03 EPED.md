# EPED

### Working directory structure

```
.
├── eped.config
├── input
│   └── ineped
└── submitjob.pbs
```

- `eped.confing`: define workflow
- `ineped`: EPED input file
- `post/`: setup files for post process, optional
- submitjjob.pbs: PBS job submission script. submitjob.sh + PBS setup

### EPED input variables

- ineped

```fortran
&EPED_INPUT
...

  IP = 0.6
  BT = 1.8
  R = 1.8
  A = 0.45
  KAPPA = 1.9
  DELTA = 0.6
  ZETA = 0.0
  NEPED = 2.0
  BETAN = 2.5
  ZEFFPED = 2.0
  M = 2
  Z = 1
  MI = 12
  ZI = 6

...
/

```

### EPED input variables

- SUMMARY/e*.*: EPED state file, NetCDF format

### Quick check

```bash
plot_eped.py -c solution -n SUMMARY/e000000.00000 -p eped_check.pdf
```

### Generate input file from geqdsk

```bash
geqdsk_to_eped.py --geqdsk=g036082.012190_kin_2 --zeff=2.0 --neped=2.1 --betan=2.5
```
