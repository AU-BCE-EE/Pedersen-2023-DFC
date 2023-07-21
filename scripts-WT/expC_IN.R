########################################################################################
#### READING IN AND ORDERING DATA ######################################################
########################################################################################

# reading in data, ordering and adding elapse.time 
org <- read.table('BLANK', header = TRUE, fill = TRUE) # Data not uploaded to GitHub, can be obtained by contacting Johanna Pedersen

data <- rbind(org)
data$date.time <- paste(data$DATE, data$TIME)
data$date.time<-ymd_hms(data$date.time)
dat <- data

########################################################################################
#### ORDERING AND CROPING DATA #########################################################
########################################################################################

dat$id <- dat$MPVPosition

# taking the last point of each measurent from each valve 
dat <- filter(dat, !(dat$id == lead(dat$id)))

# Selecting points with whole numbers (when the valve change there is a measurement where the valve position
# is in between two valves, these are removed)
dat <- dat[dat$id == '1' | dat$id == '2' | dat$id == '3' | dat$id == '4' | dat$id == '5' | dat$id == '6' | dat$id == '7' | 
             dat$id == '8' | dat$id == '9' | dat$id == '10' , ]

# Making elapsed.time fit with the first measurement of each valve = 0
dat$Vid <- 0
dat$Vid[1:10] <- c('V1', 'V2', 'V3', 'V4', 'V5', 'V6', 'V7', 'V8', 'V9', 'V10')

splitdat <- split(dat, f = dat$id)
new.names <- dat$Vid[1:10]

for (i in 1:10){
  assign(new.names[i], splitdat[[i]])
}

z = list(V1, V2, V3, V4, V5, V6, V7, V8, V9, V10)
new.dat = NULL
for(i in z){
  i$elapsed.time <- difftime(i$date.time, min(i$date.time), units='hour')
  new.dat <- rbind(new.dat,i)
}

dat <- new.dat

dat$elapsed.time <- signif(dat$elapsed.time, digits = 3)

# after the experiment it was found that the connection between tube for valve 9 was disconnected. Therefore it is removed from the data set. 
dat <- dat[! dat$id == '9', ]

# adding a column with treatment names
dat$treat <- dat$id
dat$treat <- mapvalues(dat$treat, from = c('2', '3', '4', '5', '6', '8', '10'), to = c(rep('DFC', 7)))
dat$treat <- mapvalues(dat$treat, from = c('1', '7'), to = c(rep('DFC bg', 2)))

dat$id <- as.character(dat$id)

# background data: 
DFC.bg <- dat[dat$treat == 'DFC bg', ]

# outlet data:
DFC <- dat[dat$treat == 'DFC', ]

# average background values
DFC.bg.summ <- aggregate2(DFC.bg, x = c('NH3_30s'), by = c('elapsed.time'),
                         FUN = list(bg = mean))

# joining average background and outlet data
DFC <- full_join(DFC.bg.summ, DFC, by = 'elapsed.time')

# subtracting background from outlet data
DFC$NH3.corr <- DFC$NH3_30s - DFC$NH3_30s.bg

# check
DFC[! complete.cases(DFC), ]

dat <- DFC

# ambient temperature data
header <- c('date', 'time', 'temp')
weather <- read.table('BLANK', fill = TRUE, col.names = header) # Data not uploaded to GitHub, can be obtained by contacting Johanna Pedersen
weather <- weather[-1, ]
weather$date.time.weather <- paste(weather$date, weather$time)

dat$date.time.weather <- dat$date.time
dat$date.time.weather <- as.character(round_date(dat$date.time.weather, '1 hour'))
dat <- left_join(dat, weather, by = 'date.time.weather')

# constants:
p.con <- 1 # atm
R.con <- 0.082057338 # [L * atm * K^-1 * mol^-1]
M.N <- 14.0067 # g * mol^-1

dat$air.flow <- 50 * 60 # L min^-1
dat$A.frame <- (0.7/2)^2 * 3.14 #m^2

dat$temp <- as.numeric(dat$temp)
dat$air.temp.K <- dat$temp + 273.15

dat <- na.omit(dat)

# calculation of a concentration from ppb to mol * L^-1
dat$n <- p.con / (R.con * dat$air.temp.K) * dat$NH3.corr * 10^-9  # mol * L^-1        
# calculation of flux, from mol * L^-1 to g.NH3 * min^-1 * m^-2
dat$flux <- (dat$n * M.N * dat$air.flow) / dat$A.frame
# From g.NH3 * min^-1 * m^-2 

# rearranging data by tunnel 
dat <- arrange(dat, by = id)

# calculation of total flux over time
# Average ammonia flux in measurement interval
dat$flux.tr <- rollapplyr(dat$flux, 2, mean, fill = NA)
dat$flux.tr[dat$elapsed.time == 0] <- 0
dat$flux.tr[dat$flux.tr < 0 ] <- 0

# calculation of total flux over time, last point * 144 min (time from start to start 8 x 10 min) 
dat$flux.time <- dat$flux.tr * 80

# cumulative emis
dat <- mutate(group_by(dat, id, treat), cum.emis = cumsum(flux.time))

# Table for plotting flux 
dat.summ <- summarise(group_by(dat, treat, elapsed.time), flux.mn = mean(flux), flux.sd = sd(flux),
                      cum.emis.mn = mean(cum.emis), cum.emis.sd = sd(cum.emis))
dat.end <- dat.summ[dat.summ$elapsed.time == 120, ]

dat <- dat[dat$elapsed.time <= 120, ]
dat.end.stat <- dat[dat$elapsed.time == 120, ]
dat.end.statA <- dat[dat$elapsed.time == 120, ]

# write.csv(dat, '../data/expC_IN.csv')



