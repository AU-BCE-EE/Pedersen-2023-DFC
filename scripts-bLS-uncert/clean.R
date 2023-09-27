
wd[, app.mthd := 'TH']
ed[, app.mthd := 'IN']
dat <- rbind(wd, ed)

dat[, day := as.numeric(difftime(Time, as.POSIXct('2022-11-24 11:00:00 UTC'), units = 'hours')) %/% 24 + 1]
