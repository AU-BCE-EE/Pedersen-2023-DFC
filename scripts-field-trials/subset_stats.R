
# For LSD analysis:
statA <- df1[df1$tk == 'A' & df1$elapsed.time == 60 & df1$treat == 'DFC', ]
statB <- df1[df1$tk == 'B' & df1$elapsed.time == 118 & df1$treat == 'DFC', ]
statC <- df1[df1$tk == 'C' & df1$elapsed.time == 119 & df1$treat == 'DFC', ]
stat.dat <- rbind(statA, statB, statC)
stat.dat <- stat.dat[, c('tk', 'id', 'cum.emis.perc', 'app.meth')]

write.csv(stat.dat, '../data/statLSD_230413.csv')

# For comparing WT and DFC:
statD <- df1[df1$tk == 'A', ]
statD <- statD[, c('tk', 'id', 'treat', 'elapsed.time', 'flux.perc')]

# adding block info
statD$block <- statD$id
statD$block <- mapvalues(statD$block, from = c('1', '6', '10', '15'), to = rep('1', 4))
statD$block <- mapvalues(statD$block, from = c('3', '7', '12', '16'), to = rep('2', 4))
statD$block <- mapvalues(statD$block, from = c('5', '9', '13', '17'), to = rep('3', 4))

write.csv(statD, '../data/statVar_230413.csv')
