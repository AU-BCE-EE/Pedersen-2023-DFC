
# DFC
ddA <- dA[, c('elapsed.time', 'date.time', 'id', 'flux', 'cum.emis')]
ddB <- dB[, c('elapsed.time', 'date.time', 'id', 'flux', 'cum.emis')]
ddC_in <- dC_in[, c('elapsed.time', 'date.time', 'id', 'flux', 'cum.emis')]
ddC_th <- dC_th[, c('elapsed.time', 'date.time', 'id', 'flux', 'cum.emis')]

# Add trial keys and names for plots
ddA$tk <- 'A'; ddB$tk <- 'B'; ddC_in$tk <- 'C'; ddC_th$tk <- 'C';

# Add application method
ddA$app.meth <- 'TH'; ddB$app.meth <- 'TH'; ddC_th$app.meth <- 'TH'; ddC_in$app.meth <- 'IN';

# combining
dd <- rbind(ddA, ddB, ddC_in, ddC_th)
dd$meas.meth <- 'DFC'


# bLS
bbB <- bB[, c('st_date', 'st_time', 'emis_NH3_gap', 'airT', 'WS')]
bbC_in <- bC_in[, c('st_date', 'st_time', 'emis_NH3_gap', 'airT', 'WS')]
bbC_th <- bC_th[, c('st_date', 'st_time', 'emis_NH3_gap', 'airT', 'WS')]

# Add trial keys and names for plots
bbB$tk <- 'B'; bbC_in$tk <- 'C'; bbC_th$tk <- 'C';

# Add application method 
bbB$app.meth <- 'TH'; bbC_th$app.meth <- 'TH'; bbC_in$app.meth <- 'IN';

# combining
bb <- rbind(bbB, bbC_in, bbC_th)


# temperature sensors 
# adding exp id

dtA$id <- 'A'; dtB$id <- 'B'; dtC$id <- 'C'; dtD$id <- 'D'

dt <- rbind(dtA, dtB, dtC, dtD)
dt$tk <- '1'
dt$date.time <- paste(dt$date, dt$time)

dt[dt$date.time >= '2022-11-16 09:42:00' & dt$date.time <= '2022-11-21 09:42:00', ]$tk <- 'B'
dt[dt$date.time >= '2022-11-24 11:18:00' & dt$date.time <= '2022-11-29 11:18:00', ]$tk <- 'C'

dt <- dt[! dt$tk == '1', ]
