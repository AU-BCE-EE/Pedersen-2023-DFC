
# adding elapsed time:
bb$date.time <- paste(bb$st_date, bb$st_time)
bb$date.time<-ymd_hms(bb$date.time)

bb$fac <- paste(bb$tk, bb$app.meth)

bb$Vid <- 0
bb$Vid[1:3] <- c('V1', 'V2', 'v3')
splitbb <- split(bb, f = bb$fac)
new.names <- bb$Vid[1:3]
for (i in 1:3){
  assign(new.names[i], splitbb[[i]])
}
z = list(V1, V2, v3)
new.bb = NULL
for(i in z){
  i$elapsed.time <- difftime(i$date.time, min(i$date.time), units='hour')
  new.bb <- rbind(new.bb,i)
}
bb <- new.bb

# fitting dataframe to dd (DFC dataframe)
bb$id <- '1'
bb$treat <- 'bLS'

# from myg * s^-1* m^-2 to g * min^-1* m^-2
bb$flux <- as.numeric(bb$emis_NH3_gap) * 10^-6 * 60

# from gNH3 to gN
bb$flux <- bb$flux * 14.0067 / 17.031

# calculation of total flux over time
# last point * 30 min (time meas interval) 
bb$flux.time <- bb$flux * 30

bb <- mutate(group_by(bb, tk, app.meth), cum.emis = cumsum(flux.time))

bb$id <- 'NA'

bbw <- bb

# subsetting: 
bb <- bb[, c('elapsed.time', 'date.time', 'id', 'flux', 'cum.emis', 'tk', 'app.meth', 'treat')]

