# Caclulate confidence interval for injection emission reduction from DFC measurements

rm(list = ls())

source('packages.R')
source('load.R')
knit('conf_int.Rmd', output = '../logs-inj-red/conf_int.md')
