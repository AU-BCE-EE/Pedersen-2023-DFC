# test of recovery of NH3 from NH4Cl solution. 

rm(list = ls())

dirname(rstudioapi::getActiveDocumentContext()$path)
setwd(dirname(rstudioapi::getActiveDocumentContext()$path))

source('functions.R')
source('packages.R')
source('load.R')
source('subset_and_clean.R')
source('slurry_soil.R')
source('bLS_dataframe.R')
source('DFC_dataframe.R')
source('temp_sensors_dataframe.R')
source('subset_weather.R')
source('mearge.R')
source('plot.R')

