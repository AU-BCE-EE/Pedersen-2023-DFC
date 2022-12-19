

dt$fac <- paste(dt$tk, dt$id)

dt$Vid <- 0
dt$Vid[1:8] <- c('V1', 'V2', 'v3', 'v4', 'v5', 'v6', 'v7', 'v8')
splitdt <- split(dt, f = dt$fac)
new.names <- dt$Vid[1:8]
for (i in 1:8){
  assign(new.names[i], splitdt[[i]])
}
z = list(V1, V2, v3, v4, v5, v6, v7, v8)
new.dt = NULL
for(i in z){
  i$elapsed.time <- difftime(i$date.time, min(i$date.time), units='hour')
  new.dt <- rbind(new.dt,i)
}
dt <- new.dt

dt <- dt[dt$elapsed.time <= 120, ]
