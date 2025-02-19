# Pedersen-2023-DFC
Data and analysis on dynamic flux chamber (DFC), wind tunnel (WT) and backward Lagrangian Stochastic model (bLS) measurement of ammonia volatilation from field-applied slurry, associated with a research paper.

# Maintainer
Johanna Pedersen.
Contact information here: <https://www.researchgate.net/profile/Johanna-Pedersen>.

# Published paper
The work is associated with the following paper: 
Pedersen, J., Hafner, S. D., Pacholski, A., Karlsson, V. I., Rong, L., Labouriau, R., Kamp, J. N. Evaluation of optimized flux chamber design for measurement af ammonia emission after field application of slurry with full-scale farm machinery. Atmos. Meas. Tech., 17, 4493-4505. 2024. https://doi.org/10.5194/amt-17-4493-2024

# Overview
This repo contains (nearly) all the emission data and data processing scripts needed to produce the emission results presented in the paper listed above.
The scripts run in R (<https://www.r-project.org/>) and require several add-on packages.
These packages are listed in multiple `packages.R` in `script-*` directories.
Versions of R and packages can be found in two `logs/R-versions-*.txt` files.

Scripts for calculation of emission data from raw bLS, wind tunnel, and dynamic flux chamber measurements are included, but data files are too large and are not included. 
However all resulting emission measurements can be found in data.
These bLS data processing files include some MATLAB scripts.

# Directory structure

Note that all scripts run in the R environment unless noted (bLS calculations were done in Matlab).

## `data`
Emission flux data from all three trial for DFC, WT, and bLS measurements.
Emission flux data for air exchange rate (AER) test. 
Slurry and soil properties for field and slurry used in the three trials. 
Temperature data. 
Data used for plot of model of variation for WT and DFC. 

## `functions`
Functions used by various scripts.

## `logs-bLS-uncert`
R package version log (txt file) and bLS uncertainty calculation results from `scripts-bLS-uncert` (md file).

## `logs-inj-red`
R package version log (txt file) and confidence intervals for injection reduction efficiency (md file) from `scripts-inj-red`.

## `plots-AER-test`
Plots produced by scripts in `scripts-AER-test`.

## `plots-field-trials`
Plots of measured emission and weather, produced by scripts in `scripts-field-trials`.

## `plots-variance`
Plots variance for WT and DFC produced by scripts in `scripts-variance`.

## `scripts-AER-test`
Scripts on AER test.
The script `main.R` calls all others.

## `scripts-bLS`
Matlab scripts for processing bLS data.

## `scripts-bLS-uncert`
R scripts for bLS uncertainty calculation.
The calculations can be repeated by running `main.R` in R.

## `scripts-inj-red`
R scripts for confidence interval calculation on injection efficiency.
The calculations can be repeated by running `main.R` in R.

## `scripts-field-trials`
Scripts for working with emission measurements and producing plots.
The script `main.R` calls all others.

## `scripts-variance`
Scripts for producing the plot in 'plots-variance'. 
The script 'main.R' calls all others. 

## `scripts-WT`
R scripts for processing WT data to calculate measured ammonia emission. 
Data files are too large to include but scripts are still included here for partial reproducibility.
The script `main.R` calls all others. 

# Links to published paper
This section give the sources of tables, figures, and some statistical results presented in the paper.

| Paper component          |  Repo source                             |  Repo scripts             |
|-----------------         |-----------------                         |---------------            |
|    Figure 4              | `plots-field-trials/flux_weather1.pdf`       | `scripts-field-trials/plot.R` |
|    Table 4               |           | `scripts-field_trials/DFC_dataframe.R` and `scripts-field_trials/bLS_dataframe.R`      |
|    Figure 5              | `plots-variance/variance.pdf`      | `scripts-variance/plot.R`   |
| Figure S14               | `plots-AER-test/AER_test.pdf`                       | `scripts-AER-test/plot.R`|
| Figure S15               | `plots-AER-test/AER_test_rec.pdf`                    | `scripts-AER-test/plot.R` |
| Section 3.3.2 bLS uncertainty   | `logs-bLS-uncert/bLS_uncert.md`            | `scripts-bLS-uncert/bLS_uncert.Rmd` |
| Section 3.3.2 conf. int.        | `logs-inj-red/conf_int.md`            | `scripts-inj-red/conf_int.Rmd` |
