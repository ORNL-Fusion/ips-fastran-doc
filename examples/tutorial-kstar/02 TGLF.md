# TGLF

### TGLF validation

- Start from Example 2 case
- Trun on transport solver (infastran)

```fortran
&infastran

isolver = 1

/
```
- TGLF setup (intglf)

```fortran
! SAT0
&intglf
    tglf_ns_in = 3

    tglf_mass_in(1) = 2.723D-4
    tglf_mass_in(2) = 1.0
    tglf_mass_in(3) = 6.0

    tglf_zs_in(1) = -1.0
    tglf_zs_in(2) = 1.0
    tglf_zs_in(3) = 6.0

    tglf_xnu_model_in = 2
    tglf_alpha_quench_in = 1.0
    tglf_alpha_e_in = 1.0
    tglf_use_bper_in = .true.
    tglf_use_bpar_in = .false.
/
```

```fortran
! SAT2
&intglf
    tglf_ns_in = 3

    tglf_mass_in(1) = 2.723D-4
    tglf_mass_in(2) = 1.0
    tglf_mass_in(3) = 6.0

    tglf_zs_in(1) = -1.0
    tglf_zs_in(2) = 1.0
    tglf_zs_in(3) = 6.0
    
    tglf_sat_rule_in = 2
    tglf_xnu_model_in = 3
    tglf_alpha_quench_in = 0.0
    tglf_alpha_e_in = 1.0
    tglf_alpha_p_in = 1.0
    tglf_alpha_zf_in = 1.0
    tglf_alpha_mach_in = 0.0
    tglf_use_bper_in = .true.
    tglf_use_bpar_in = .false.
/
```

- set number of CPUs 

fastran_scenario.config
```INI
...

[fastran]

  NPROC = 64 # 32
  NPROC_KY = 8 # 8

...
```

submitjob.pbs
```
...

#PBS -l nodes=1:ppn=64

...
```

### TGLF prediction

- Iterate beteen transport, equilibrium, H&CD (fastran_scenario.config)

```INI

...

[ITERATION_LOOP]
    MODE = REGULAR
    NSTEP_PREPROCESS = 1
    NSTEP = 5

...
```




