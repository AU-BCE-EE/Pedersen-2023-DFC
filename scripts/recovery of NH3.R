########################################################################################
#### READING IN AND ORDERING DATA ######################################################
########################################################################################

# recovery test done on DC prototype (MAG project) on the 14th of Oct 2022

rm(list = ls())

dirname(rstudioapi::getActiveDocumentContext()$path)
setwd(dirname(rstudioapi::getActiveDocumentContext()$path))

source('packages.R')

# reading in data, ordering and adding elapse.time 
dat <- read.table('../data/recovery of NH3.txt', header = TRUE, fill = TRUE)

dat$date.time <- paste(dat$DATE, dat$TIME)
dat$date.time<-ymd_hms(dat$date.time)
dat$date.time <- dat$date.time
dat$elapsed.time <- difftime(dat$date.time, min(dat$date.time), units = 'mins')

# first view:
ggplot(dat, aes(elapsed.time, NH3)) + geom_point() # all three replicates

ggplot(dat, aes(elapsed.time, NH3)) + geom_point() + xlim(2.5, 4) + ylim(0, 50) # background
ggplot(dat, aes(elapsed.time, NH3)) + geom_point() + xlim(4, 44.5) # test #1
ggplot(dat, aes(elapsed.time, NH3)) + geom_point() + xlim(47, 73) # test #2
ggplot(dat, aes(elapsed.time, NH3)) + geom_point() + xlim(78.7, 99.5) # test #3

# constants:
p.con <- 1 # atm
R.con <- 0.082057338 # L * atm * K^-1 * mol^-1
M.N <- 14.006 # g * mol^-1
air.flow <- 50 * 60 # L min^-1
temp <- 18 + 273.15 # K
bg <- mean(dat[dat$elapsed.time >= 2.5 & dat$elapsed.time <= 4, ]$NH3)

# calculation of a concentration from ppb to mol * L^-1
dat$n <- p.con / (R.con * temp) * (dat$NH3 - bg) * 10^-9  # mol * L^-1 

# calculation of flux, from mol * L^-1 to g.N * min^-1
dat$flux <- (dat$n * M.N * air.flow) 

# assigning test #
dat$exp <- 'A'
dat$inlet <- 'A'
dat[dat$elapsed.time > 4 & dat$elapsed.time < 44.5, ]$exp <- 1    
dat[dat$elapsed.time > 47 & dat$elapsed.time < 73, ]$exp <- 2   
dat[dat$elapsed.time > 78.7 & dat$elapsed.time < 99.5, ]$exp <- 3  

# removing data not used
dat <- dat[! dat$exp == 'A', ]

# Making elapsed.time fit with the first measurement of each valve = 0
dat$Vid <- 0; dat$Vid[1:3] <- c('V1', 'V2', 'V3'); new.names <- dat$Vid[1:3]

splitdat <- split(dat, f = dat$exp)

for (i in 1:3){
  assign(new.names[i], splitdat[[i]])
}

z = list(V1, V2, V3)
new.dat = NULL
for(i in z){
  i$elapsed.time <- difftime(i$date.time, min(i$date.time), units='mins')
  new.dat <- rbind(new.dat,i)
}

dat <- new.dat

# Calculating the emissions in the chamber with the trapezoid rule: 
# Average ammonia flux in measurement interval
dat$flux.tr <- rollapplyr(dat$flux, 2, mean, fill = NA)
dat$flux.tr[dat$elapsed.time == 0] <- 0

dat$elapsed.time.cal <- rollapplyr(dat$elapsed.time, 2, diff, fill = NA) # time between measuring points
dat[is.na(dat)] = 0 # fixing that the first 'elapsed.time.cal' is NA which will screw up later cal

dat$flux.time <- dat$flux.tr * dat$elapsed.time.cal  # g.N

dat <- mutate(group_by(dat, exp), cum.emis = cumsum(flux.time))

dat$cum.emis.Picarro <- 100
dat[dat$exp == 1, ]$cum.emis.Picarro <- tail(dat[dat$exp == 1, ]$cum.emis, n = 1)
dat[dat$exp == 2, ]$cum.emis.Picarro <- tail(dat[dat$exp == 2, ]$cum.emis, n = 1)
dat[dat$exp == 3, ]$cum.emis.Picarro <- tail(dat[dat$exp == 3, ]$cum.emis, n = 1)

# analysis of the sample, dilution factor (FF in DK) = 100
# analysis gives mg/L, we diluted 100 times for the analysis and convert from mg/L to g/L
# values are from analysis by HG send on email to JP the 17th of Oct 2022
# calculation of how much N is lost from the solution:

dat$conc.end <- 100
dat[dat$exp == 1, ]$conc.end <- mean(c(14, 15, 15)) / 10 # original label: B samples
dat[dat$exp == 2, ]$conc.end <- mean(c(19, 20, 20)) / 10 # original label: C samples
dat[dat$exp == 3, ]$conc.end <- mean(c(21, 21, 21)) / 10 # original label: D samples

dat$conc.start <- mean(c(36, 36, 35)) / 10 # original label: A samples

# Difference (starting volume was 51.5 mL of each solution (50 mL NA4Cl + 1 mL NaOH + 0.5 mL H2SO4))
dat$cum.emis.sample <- dat$conc.start * 0.0515 - dat$conc.end * 0.0515

# COMPARISON OF NUMBERS: 
dat$recovery <- dat$cum.emis.Picarro / dat$cum.emis.sample * 100


