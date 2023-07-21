########################################################################################
#### READING IN AND ORDERING DATA ######################################################
########################################################################################

# reading in data, ordering and adding elapse.time 
org <- read.table('BLANK', header = TRUE, fill = TRUE) # Data not uploaded to GitHub, can be obtained by contacting Johanna Pedersen

data <- rbind(org)
data$date.time <- paste(data$DATE, data$TIME)
data$date.time<-ymd_hms(data$date.time)
dat <- data

dat <- dat[-c(0:205), ]

########################################################################################
#### ORDERING AND CROPING DATA #########################################################
########################################################################################

dat$id <- dat$MPVPosition

# taking the last point of each measurent from each valve 
dat <- filter(dat, !(dat$id == lead(dat$id)))

# Selecting points with whole numbers (when the valve change there is a measurement where the valve position
# is in between two valves, these are removed)
dat <- dat[dat$id == '1' | dat$id == '2' | dat$id == '3' | dat$id == '4' | dat$id == '5' | dat$id == '6' | dat$id == '7' | 
             dat$id == '8' | dat$id == '9' | dat$id == '10' | dat$id == '11' | dat$id == '12' | dat$id == '13' | dat$id == '14' |
             dat$id == '15' | dat$id == '16' | dat$id == '17' | dat$id == '18', ]

# Making elapsed.time fit with the first measurement of each valve = 0
dat$Vid <- 0
dat$Vid[1:18] <- c('V1', 'V2', 'V3', 'V4', 'V5', 'V6', 'V7', 'V8', 'V9', 'V10', 'V11', 'V12', 'V13', 'v14', 'v15', 'v16', 'v17', 'v18')

splitdat <- split(dat, f = dat$id)
new.names <- dat$Vid[1:18]

for (i in 1:18){
  assign(new.names[i], splitdat[[i]])
}

z = list(V1, V2, V3, V4, V5, V6, V7, V8, V9, V10, V11, V12, V13, v14, v15, v16, v17, v18)
new.dat = NULL
for(i in z){
  i$elapsed.time <- difftime(i$date.time, min(i$date.time), units='hour')
  new.dat <- rbind(new.dat,i)
}

dat <- new.dat

dat$elapsed.time <- signif(dat$elapsed.time, digits = 3)

# adding a column with treatment names
dat$treat <- dat$id
dat$treat <- mapvalues(dat$treat, from = c('3', '5', '6', '9', '10', '12', '15', '16', '17'), to = c(rep('DFC', 9)))
dat$treat <- mapvalues(dat$treat, from = c('1', '7', '13'), to = c(rep('WT', 3)))

dat$treat <- mapvalues(dat$treat, from = c('4', '11', '18'), to = c(rep('DFC bg', 3)))
dat$treat <- mapvalues(dat$treat, from = c('2', '8', '14'), to = c(rep('WT bg', 3)))

# fixing a time bug
dat$elapsed.time[dat$elapsed.time == 9.60] <- 9.59

# background data: 
WT.bg <- dat[dat$treat == 'WT bg', ]
DFC.bg <- dat[dat$treat == 'DFC bg', ]

# outlet data:
WT <- dat[dat$treat == 'WT', ]
DFC <- dat[dat$treat == 'DFC', ]

# average background values
WT.bg.summ <- aggregate2(WT.bg, x = c('NH3_30s'), by = c('elapsed.time'),
                         FUN = list(bg = mean))
DFC.bg.summ <- aggregate2(DFC.bg, x = c('NH3_30s'), by = c('elapsed.time'),
                         FUN = list(bg = mean))

# joining average background and outlet data
WT <- full_join(WT.bg.summ, WT, by = 'elapsed.time')
DFC <- full_join(DFC.bg.summ, DFC, by = 'elapsed.time')

# subtracting background from outlet data
WT$NH3.corr <- WT$NH3_30s - WT$NH3_30s.bg
DFC$NH3.corr <- DFC$NH3_30s - DFC$NH3_30s.bg

# check
WT[! complete.cases(WT), ]
DFC[! complete.cases(DFC), ]

# combining
dat <- rbind(WT, DFC)

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

dat$air.flow <- 1
dat[dat$treat == 'WT', ]$air.flow <- 33.2 * 60 # L min^-1
dat[dat$treat == 'DFC', ]$air.flow <- 49 * 60 # L min^-1 

dat$A.frame <- 1
dat[dat$treat == 'WT', ]$A.frame <- 0.293 * 0.674 #m^2
dat[dat$treat == 'DFC', ]$A.frame <- (0.7/2)^2 * 3.14 #m^2

dat$temp <- as.numeric(dat$temp)
dat$air.temp.K <- dat$temp + 273.15

mean(dat$temp[1:3])
mean(dat$temp)
min(dat$temp)
max(dat$temp)

weather.expA <- dat[, c(1, 36)]
weather.expA$experiment <- 'Experiment A'

# calculation of a concentration from ppb to mol * L^-1
dat$n <- p.con / (R.con * dat$air.temp.K) * dat$NH3.corr * 10^-9  # mol * L^-1        
# calculation of flux, from mol * L^-1 to g.NH3 * min^-1 * m^-2
dat$flux <- (dat$n * M.N * dat$air.flow) / dat$A.frame
# From g.N * min^-1 * m^-2 

# rearranging data by tunnel 
dat <- arrange(dat, by = id)

# calculation of total flux over time
# Average ammonia flux in measurement interval
dat$flux.tr <- rollapplyr(dat$flux, 2, mean, fill = NA)
dat$flux.tr[dat$elapsed.time == 0] <- 0
dat$flux.tr[dat$flux.tr < 0 ] <- 0

# calculation of total flux over time, last point * 144 min (time from start to start 18 x 8 min) 
dat$flux.time <- dat$flux.tr * 144

# cumulative emis
dat <- mutate(group_by(dat, id, treat), cum.emis = cumsum(flux.time))

# Table for plotting flux 
dat.summ <- summarise(group_by(dat, treat, elapsed.time), flux.mn = mean(flux), flux.sd = sd(flux),
                      cum.emis.mn = mean(cum.emis), cum.emis.sd = sd(cum.emis))
dat.end <- dat.summ[dat.summ$elapsed.time == 60, ]

dat <- dat[dat$elapsed.time <= 60, ]
dat.end.stat <- dat[dat$elapsed.time == 60, ]

# write.csv(dat, '../data/expA.csv')

