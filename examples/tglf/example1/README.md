# Definition of template instate profiles for L-mode transport model validation 

## 1. Radial grid

| Key | Unit | Meaning |
|-----|------|---------|
| `NRHO` | — | Number of radial grid points (e.g. 101). |
| `RHO` | — | Normalized toroidal-flux radius, 0..1 (`NRHO` values). All profiles below share this grid. |

---

## 2. Kinetic profiles

| Key | Unit | Meaning |
|-----|------|---------|
| `NE` | 10¹⁹ m⁻³ | Electron density. |
| `TE` | keV | Electron temperature. |
| `TI` | keV | Ion temperature. |
| `ZEFF` | — | Effective charge Z_eff. |
| `OMEGA` | rad/s | Toroidal angular rotation frequency. |
| `P_EQ` | Pa | Total equilibrium (MHD) pressure — the equilibrium reference pressure. |

---

## 3. Current-density profiles

| Key | Unit | Meaning |
|-----|------|---------|
| `J_TOT` | MA/m² | Total parallel current density. |
| `J_OH` | MA/m² | Ohmic (inductive) current density. **optional**|
| `J_BS` | MA/m² | Bootstrap current density. **optional**|
| `J_NB` | MA/m² | Neutral-beam-driven current density. **optional**|

## 4. Beam / fast-ion profiles

| Key | Unit | Meaning |
|-----|------|---------|
| `DENSITY_BEAM` | 10¹⁹ m⁻³ | Fast (beam) ion density. |
| `WBEAM` | MJ/m³ | Beam fast-ion stored-energy density. |

## 5. Source profiles

Neutral-beam sources:
| Key | Unit | Meaning |
|-----|------|---------|
| `SE_NB` | 10¹⁹ m⁻³ s⁻¹ | Beam electron particle source. |
| `PE_NB` | MW/m³ | Beam power to electrons. |
| `PI_NB` | MW/m³ | Beam power to ions. |
| `TORQUE_NB` | N·m/m³ | Beam-injected torque density. |

Ionization / atomic sources:
| Key | Unit | Meaning |
|-----|------|---------|
| `SE_IONIZATION` | 10¹⁹ m⁻³ s⁻¹ | Ionization electron particle source. |
| `PE_IONIZATION` | MW/m³ | Ionization power to electrons. |
| `PI_IONIZATION` | MW/m³ | Ionization power to ions. |
| `PI_CX` | MW/m³ | Charge-exchange ion power. |

Ohmic / radiation:
| Key | Unit | Meaning |
|-----|------|---------|
| `P_OHM` | MW/m³ | Ohmic heating power density. |
| `P_RAD` | MW/m³ | Radiated power density (negative = sink). |

---

## 6. Plasma boundary & limiter

| Key | Unit | Meaning |
|-----|------|---------|
| `NBDRY` | — | Number of plasma-boundary (separatrix) points. |
| `RBDRY` | m | Boundary point major-radius coordinates (`NBDRY` values). |
| `ZBDRY` | m | Boundary point vertical coordinates (`NBDRY` values). |
| `NLIM` | — | Number of limiter/first-wall polygon points. |
| `RLIM` | m | Limiter point R coordinates (`NLIM` values). |
| `ZLIM` | m | Limiter point Z coordinates (`NLIM` values). |

---

## 7. Scaling factors

Multipliers applied to the corresponding profile during preprocessing (1.0 = unchanged).

| Key | Scales |
|-----|--------|
| `SCALE_NE` | `NE` |
| `SCALE_NI` | ion density |
| `SCALE_TE` | `TE` |
| `SCALE_TI` | `TI` |
| `SCALE_SE_IONIZATION` | `SE_IONIZATION` |
| `SCALE_SE_NB` | `SE_NB` |

