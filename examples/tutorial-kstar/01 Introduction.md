# Introduction

### IPS-FASTRAN
- Built upon the IPS integrated modeling framework
	- Component/framework architecture, state file, HPC, ...
- Extended 1.5D integrated modeling - backbone integrated modeling for Whole Facility Modeling
  - Steady-state and time-dependent modeling
  - From core to wall
	- Coupling to engineering modeling
- Being actively developed under DOE projects
	- C2W, FREDA SciDAC, Pulse Simulator, Base theory

### Features
- Flexible
- Multi-fidelity
- Ensemble simulation with HPC
- Data generation, build surrogate model, AIML acceleration
- UQ with DAKOTA

# Run environment

### Conda

Conda @ Nkstar

```bash
conda activate /UKSTAR_HOME/ips-fastran/cesol/dev
```

### Test

```bash
> python

Python 3.8.20 | packaged by conda-forge | (default, Sep 30 2024, 17:52:49)
[GCC 13.3.0] on linux
Type "help", "copyright", "credits" or "license" for more information.

>>> import fastran
>>> import fastran.plasmastate.plasmastate
>>> import eped
>>> 	
```

```bash
ips.py --version

ips.py 0.8.1
```

# Installation location

```
/UKSTAR_HOME/ips-fastran
├── binaries
├── cesol
├── data
└── examples
```

# Example 1 - Snapshot analysis

### Problem definition

- Given experimental profile
- Calculate HCD, bootstrap current, power balance chie/chii, energy confinement time, etc
- Reconstruct equilibrium, connet kinetic EFIT

### Working directory structure

```
examples/example1
├── fastran_scenario.config
├── input
│   ├── infastran
│   ├── innubeam
│   ├── instate
│   ├── intglf
│   └── intoray
├── post
│   └── plot.json
├── submitjob.pbs
└── submitjob.sh
```

- `fastran_scenario.confing`: define workflow
- `input/in*`: input file for each component, for example, innubeam = input file for NUBEAM
- `post/`: setup files for post process, optional
- submitjob.sh: bash script for execution ips-fastran workflow (for test at login node)
- submitjjob.pbs: PBS job submission script. submitjob.sh + PBS setup

### How to run

Login node
- `bash submitjob.sh`

PBS
- job submission: `qsub submitjob.pbs`
- check your job: `qstab`

Check your run on IPS Portal
- [IPS Portal](https://lb.ipsportal.production.svc.spin.nersc.org)

### Output files
```
.
├── fastran_scenario.config
├── input
│   ├── infastran
│   ├── innubeam
│   ├── instate
│   ├── intglf
│   └── intoray
├── ips.err
├── ips.log
├── ips.out
├── post
│   └── plot.json
├── RUN
│   ├── fastran_scenario.config
│   ├── nkstar.conf
│   ├── resource_usage
│   ├── RESULT
│   ├── simulation_log
│   ├── simulation_results
│   ├── simulation_setup
│   └── work
├── run.log
├── submitjob.sh
└── SUMMARY
    ├── a000001.00001
    ├── f000001.00001
    ├── g000001.00001
    └── i000001.00001
```

- mian output in `SUMMARY/`
- `g*.*`: EFIT GEQDSK file
- `a*.*`: EFIT AEQDSK file
- `f*.*`: FASTRAN netcdf file - incudes profiles, global parameters, ...

### Quickplot

```
plot_fastran.py -n SUMMARY/f000001.00001 --show
```

```
  -c, --command: 'check'(default) or 'scan'
  -n, --ncfile: f-file name
  -i, --input: plot setup (default = 'input/plot.json')
  -p, --pdf: pdf output file name ('default = fastran.nc')
  -x, --size_x: pdf x size (default = 14.5)
  -y, --size_y: pdf y size (default = 8.5)
  -s, --show: show at screen
```

# Example 2: Generate input files from KSTAR experiment

```
examples/example2
├── 40848_2800
└── xfastran.sh
```

```

xfastran_kstar.py --shot=40848 --time=2800 --profdir=40848_2800 --nb --ec

```

```
--shot: shot number
--time: time in msec
--profdir: GFIT profile directory
--nb: write NUBEAM input
--ec: write TORAY input
```

# Example 3: Snapshot analysis exercise 

### Match total stored energy
- anomalous fast ion diffusion (innubeam)
```fortran

...
&NBI_MODEL
  DIFB_0 = 1.0
  DIFB_A = 1.0
  ...
/
...
```

### Current profile to steady-state or Kinetic-EFIT equivalent

- Turn on current profile evolution (infastran)

```fortran
&infastran

...

relax_j = 1

...
/
```

- Iterate beteen transport, equilibrium, H&CD (fastran_scenario.config)

```INI

...

[ITERATION_LOOP]
    MODE = REGULAR
    NSTEP_PREPROCESS = 1
    NSTEP = 3

...
```
### Heating and current drive
- EC aiming
- NB power scan


