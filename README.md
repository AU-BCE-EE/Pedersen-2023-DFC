# Pedersen-2023-DFC
Data and analysis on dynamic flux chamber (DFC), wind tunnel (WT) and backward Lagrangian Stochastic model (bLS) measurement of ammonia volatilation from field-applied slurry, associated with research paper currently in progress.

# In progress
This is a work in progress.
The paper has not yet been published.

# Maintainer
Johanna Pedersen.
Contact information here: <https://www.researchgate.net/profile/Johanna-Pedersen>.

# Published paper
The contents of this repo are presented in the following paper:

...


# Overview
This repo contains (nearly) all the iemission data and data processing scripts needed to produce the emission results presented in the paper listed above.
The scripts run in R (<https://www.r-project.org/>) and require several add-on packages.
These packages are listed in multiple `packages.R` in `script-*` directories.
Versions of R and packages can be found in two `logs/R-versions-*.txt` files.

Scripts for calculation of emission data from raw bLS, wind tunnel, and dynamic flux chamber measurements are included, but data files are too large and are not included. 
However all resulting emission measurements can be found in data.
These bLS data processing files include some MATLAB scripts.

# Directory structure

## `data`
Emission flux data from all three trial for DFC, WT, and bLS measurements.
Emission flux data for air exchange rate (AER) test. 
Slurry and soil properties for field and slurry used in the three trials. 
Temperature data. 
Data used for plot of model of variation for WT and DFC. 

## `functions`
Functions used by various scripts.

## `plots-AER-test`
Plots produced by scripts in `scripts-AER-test`.

## `plots-field-trials`
Plots of measured emission and weather, produced by scripts in `scripts-field-trials`.

## `plots-variance`
Plots variance for WT and DFC produced by scripts in `scripts-variance`.

## `scripts-AER-test`
Scripts on AER test.
The script `main.R` calls all others.

## `scripts-field-trials`
Scripts for working with emission measurements and producing plots.
The script `main.R` calls all others.

## 'scripts-variance'
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
|    Figure FFF              | `plots-field-trials/flux_weather1.pdf`       | `scripts-field-trials/plot.R` |
|    Table FDF             |           | `scripts-field_trials/DFC_dataframe.R` and `scripts-field_trials/bLS_dataframe.R`      |
|    Figure GGG              | `plots-variance/variance.pdf`      | `scripts-variance/plot.R`   |
| Fgiure SAER | `plots-AER-test/AER_test.pdf`                       | `scripts-AER-test/plot.R`|
| Figure SAER2  | `plots-AER-test/AER_test_rec.pdf`                    | `scripts-AER-test/plot.R` |
