
# Set application method
wd[, app.mthd := 'TH']
ed[, app.mthd := 'IN']

# Correct for bias
wd[, `:=` (NH3_east_corr = NH3_east - 1.096, NH3_west_corr = NH3_west + 0.551)]
ed[, `:=` (NH3_east_corr = NH3_east - 1.096, NH3_west_corr = NH3_west + 0.551)]

dat <- rbind(wd, ed)

dat[, day := as.numeric(difftime(Time, as.POSIXct('2022-11-24 11:00:00 UTC'), units = 'hours')) %/% 24 + 1]

wd[, ct := as.numeric(difftime(Time, as.POSIXct('2022-11-24 11:00:00 UTC'), units = 'hours'))]
