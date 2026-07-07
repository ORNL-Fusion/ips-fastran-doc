# `infastran` Variable Reference

Description of `&infastran` namelist key read by fastran.  
The effective configuration is dumped to `infastran.used` (rank 0) by `write_config` after a run — check for the values actually used.

**Legend**
- **Default** — the value used when the key is absent from `&infastran`.
- **[LEGACY]** — old-fastran key that fastran does **not** read anymore.
- Array channels use the order **n, e, i, v** (namelist suffixes `_N/_E/_I/_V`).

---

## 1. Time integration / iteration (solver control)

| Key | Type | Default | Meaning |
|-----|------|---------|---------|
| `DT` | double | 1e30 | Time step [s]. `1e30` → steady state (backward-Euler old-time weight ≈ 0). |
| `MAXITER_RELAX` | int | 25 | Max Picard / flux-match iterations per time step (shared by both solvers). |
| `ISOLVER` | int | 1 | `1` = transport solve on, `-1` = diagnostics only (no solve). |
| `MINITER_RELAX` | int | 4 | Min Picard iterations before the convergence test is applied. |
| `INITIAL_RELAX` | int | 1 | First N iterations use a small `dt` to anchor the initial profile. |
| `DTMAX_IITER` | double | 1e-3 | `dt` cap used during the `INITIAL_RELAX` iterations. |
| `NSTEP` | int | 1 | Number of time steps. |

---

## 2. Grid

| Key | Type | Default | Meaning |
|-----|------|---------|---------|
| `NRHO` | int | 100 | Full radial grid points (nodes 0..NRHO). |
| `NRHO_TRANSPORT` | int | 20 | Reduced (transport-solve) grid points. **`NRHO` must be an integer multiple** so the stride `NRHO/NRHO_TRANSPORT` is exact. |

---

## 3. Boundary conditions

| Key | Type | Default | Meaning |
|-----|------|---------|---------|
| `RHO_BDRY` | double | 0.82 | Transport-solve outer boundary (Dirichlet pivot), normalized rho (0..1). |
| `NRHO_BDRY` | int | — | Integer node form of the boundary (`rho_bdry = NRHO_BDRY / NRHO_TRANSPORT`). **`RHO_BDRY` takes precedence** when present. |
| `NRHO_BDRY_AXIS` | int | 0 | Near-axis extrapolation BC node count (old `bc_axis`): over the inner N nodes, rebuild `z=-T'/T` linear in rho (→ 0 at the axis). `0` = off. |
| `NRHO_BDRY_AXIS_NE/TE/TI/RV` | int | -1 | Per-channel override; `<0` inherits the global `NRHO_BDRY_AXIS`. |

---

## 4. Nonlinear iteration / convergence

| Key | Type | Default | Meaning |
|-----|------|---------|---------|
| `IRELAX` | string | `picard` | Solver method: `picard` (chi-diffusion) / `secant` / `flux_match` (simple flux-matching relaxation). |
| `ALPHA_CHI` | double | 0.1 | chi under-relaxation factor: `chi_k = α·chi + (1-α)·chi_k` (damps the stiff TGLF response). |
| `ERROR_E` | double | 1e-4 | Electron-heat (te) channel residual tolerance. |
| `ERROR_I` | double | 1e-4 | Ion-heat (ti) channel tolerance. |
| `ERROR_V` | double | 1e-3 | Rotation (rv) channel tolerance. |
| `ERROR_N` | double | 1e-3 | Density (ne) channel tolerance. |
| `CHI_INIT` | int | 1 | First-iteration `chi_k` seed: `0` = chi, `1` = chi_exp (power-balance under-relaxation, default). |
| `ALPHA_E/I/V/N` | double | 1.0 | [LEGACY] Per-channel profile under-relaxation `T=α·T_new+(1-α)·T_prev` (1.0=off). |
| `RELAX_DZ` | double | 0.1 | Relaxation gain: `dz/z = -RELAX_DZ·(Qtot-Qtar)/denom`. |
| `RELAX_DZ_MAX` | double | 0.05 | Per-step `|dz/z|` clip. |
| `UNDER_RELAX` | double | 1.0 | dz under-relaxation (EMA): `dz_eff=(1-u)·dz_prev+u·dz_cur` (1.0 = off, <1 damps oscillation). |
| `RES_NORM` | int | 1 | Channel residual norm over the flux mismatch: `0` = Linf (max relative `\|Qtot-Qtar\|/\|Qtar\|`), `1` = L2 (normalized `Σ(Qtot-Qtar)² / ΣQtar²`. |

---

## 5. Equations to solve (`SOLVE_*`, 1 = on)

| Key | Default | Channel |
|-----|---------|---------|
| `SOLVE_NE` | 0 | Electron density (continuity). |
| `SOLVE_TE` | 0 | Electron temperature. |
| `SOLVE_TI` | 0 | Ion temperature. |
| `SOLVE_V` | 0 | Toroidal rotation (omega). |
| `SOLVE_J` | 0 | Current diffusion (poloidal flux). |
| `SOLVE_MHD` | — | [LEGACY] Equilibrium/MHD solve flag; not read (fastranpp uses the input equilibrium). |

---

## 6. Physics model selection

| Key | Type | Default | Meaning |
|-----|------|---------|---------|
| `MODEL_CHI` | string | `tglf` | Turbulent transport model: `tglf`·`exp` (implemented) · `tglfnn`·`gftm`·`glf23`·`cdbm`·`mmm`·`coppi`. (old fastran) |
| `MODEL_NEOCLASS` | string | `nclass` | Neoclassical model: `nclass` / `chang_hinton` / `hirshman`. |
| `MODEL_BOOTSTRAP` | string | `sauter` | Bootstrap model: `sauter` / `hirshman`. |
| `INCLUDE_FUSION` | int(bool) | 0 | Fusion alpha heating source (1 = on). |
| `INCLUDE_NHE` | int(bool) | 0 | He-ash accumulation (1 = on). |
| `INCLUDE_RAD` | int(bool) | 0 | Bremstrahlung radiated-power sink (1 = on). |
| `MODEL_DENSITY` | int | 0 | Ion-density model: `0` = quasineutral ni/niz from ne/zeff, `1` = fixed impurity fraction `fimp` → ni + recomputed zeff. |
| `TAUP` | double | 0.0 | He-ash confinement: `tau_he = TAUP>0 ? TAUP : -TAUP·tau_energy`. |
| `TGLF_PMHD_INPUT` | int | 0 | TGLF pressure input: `0` = inmetric `pmhd_exp`, else compute (thermal+fast). |
| `TGLF_Q_INPUT` | int | 0 | TGLF q input: `0` = inmetric `q_exp`, else computed q. |

> See `intglf` for TGLF control keys.

---

## 7. chi combination (channel order n, e, i, v)

`chi = min(MULTI_CHI·chi_turb, MAX_CHI) + MULTI_NEO·chi_neo + CONST_CHI`, then clamped by `LIMIT_CHI`.

| Key | Type | Default | Meaning |
|-----|------|---------|---------|
| `MULTI_CHI_N/E/I/V` | double | 1.0 | Turbulent-chi multiplier per channel. |
| `MULTI_NEO_N/E/I/V` | double | 1.0 | Neoclassical-chi multiplier per channel. |
| `CONST_CHI_N/E/I/V` | double | 0.01 / 0.1 / 0.1 / 0.1 | Constant floor chi [m²/s] per channel. |
| `MAX_CHI_N/E/I/V` | double | 10.0 | Turbulent-chi upper cap [m²/s] per channel. |
| `LIMIT_CHI_N/E/I/V` | int | 1 | Turbulent-chi limiter: `0` = clamp `chi≥0`, `1` = clamp `chi ≤ 2·|chi_exp|`. `2` = no limiter|
| `ICHI_V` | int | 0 | Momentum-chi source: `-1` = use ion-heat chi (chi_i) for rotation, else model chi_v. |

---

## 8. Current-diffusion (J) relaxation

| Key | Type | Default | Meaning |
|-----|------|---------|---------|
| `RELAX_J` | int | 1 | Relax the current to steady state on load (1 = on). |
| `DT_RELAX_J` | double | 100.0 | Total current-relaxation time [s]. |
| `DT_STEP_RELAX_J` | double | 0.01 | Current-relaxation step [s]. |

---

## 9. Raw turbulent-chi radial smoothing

`SMOOTH_METHOD=0` (off) preserves the golden result.

| Key | Type | Default | Meaning |
|-----|------|---------|---------|
| `SMOOTH_METHOD` | int | 0 | `0` = off, `1` = binomial (3-point), `2` = tension spline (uses `SMOOTH_ALFA`). |
| `SMOOTH_NITER` | int | 1 | Binomial passes (method=1). |
| `SMOOTH_ALFA` | double | 0.01 | Spline tension strength (method=2). |
| `SMOOTH_CHI_E/I/N/V` | bool | .FALSE. | Channels to smooth. **This flag must be `.TRUE.` for the channel to actually be smoothed** — if all are off, `SMOOTH_METHOD/NITER` have no effect. |

---

## 10. Diagnostics / I/O

| Key | Type | Default | Meaning |
|-----|------|---------|---------|
| `WRITE_TGLF_IO` | bool | .FALSE. | Dump per-node TGLF inputs/outputs to `tglf_io.dat`. |
| `TGLF_DUMP_GLOBAL` | int | — | [LEGACY] |
| `TGLF_DUMP_LOCAL` | int | — | [LEGACY] |

