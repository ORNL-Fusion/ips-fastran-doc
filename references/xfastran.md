## IPS-FASTRAN input files from DIII-D experimental data

### Run environment (XFASTRAN) on OMEGA

```
conda activate /fusion/projects/codes/ips/conda/prerelease
```

First time only:

```
/fusion/projects/codes/ips/miniforge3/bin/conda init
```

### Example 1: GAProfiles

```
xfastran_d3d.py \
--snap \
--shot=153648 \
--efitdir='/fusion/projects/codes/ips/samples/153648/kin06' \
--profdir='/fusion/projects/codes/ips/samples/153648/fit02' \
--time=4250 \
--dtavg=500 \
--rdir='SIMULATION' \
--nb \
--dtbeam_avg=100 \
--ec \
--dtech_avg=100 \
--input
```

### Example 2: QuickFit

```
xfastran_d3d.py \
--snap \
--profile='quickfit' \
--shot=190904 \
--efitdir='/fusion/projects/codes/ips/samples/190904/efit' \
--profdir='/fusion/projects/codes/ips/samples/190904/quickfit' \
--time=4285 \
--dtavg=100 \
--rdir='SIMULATION' \
--nb \
--dtbeam_avg=100 \
--ec \
--dtech_avg=100 \
--input
```

### Output template for IPS-FASTRAN
  ```
  SIMULATION/
  ├── t<shot#>.nc
  ├── fastran_scenario.config
  ├── submitjob
  └── input/
      └── instate innubeam intoray infastran infastran0  intglf
  ```

- **Before submitting**:
  - set `SHOT_NUMBER` and `TIME_ID` in `submitjob` (placeholders `000001` / `00001`);
  - check `PORTS: NAMES` in `fastran_scenario.config`.
