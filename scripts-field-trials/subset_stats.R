
# For CI calculations, trial C:
CI.C <- df1[df1$tk == 'C' & df1$elapsed.time == 119 & df1$treat == 'DFC', ]
CI.C <- CI.C[, c('tk', 'id', 'cum.emis.perc', 'app.meth')]

write.csv(CI.C, '../data/CI.C.csv')

# For comparing WT and DFC:
statD <- df1[df1$tk == 'A', ]
statD <- statD[, c('tk', 'id', 'treat', 'elapsed.time', 'flux.perc')]

# adding block info
statD$block <- statD$id
statD$block <- mapvalues(statD$block, from = c('1', '6', '10', '15'), to = rep('1', 4))
statD$block <- mapvalues(statD$block, from = c('3', '7', '12', '16'), to = rep('2', 4))
statD$block <- mapvalues(statD$block, from = c('5', '9', '13', '17'), to = rep('3', 4))

write.csv(statD, '../data/statVar_230413.csv')
