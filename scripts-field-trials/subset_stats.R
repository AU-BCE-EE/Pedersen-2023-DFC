
# tk = A 

statA <- df1[df1$tk == 'A' & df1$elapsed.time == 60 & df1$treat == 'DFC', ]

statB <- df1[df1$tk == 'B' & df1$elapsed.time == 118 & df1$treat == 'DFC', ]

statC <- df1[df1$tk == 'C' & df1$elapsed.time == 119 & df1$treat == 'DFC' & df1$app.meth == 'TH', ]

stat.dat <- rbind(statA, statB, statC)

stat.dat <- stat.dat[, c('tk', 'id', 'cum.emis', 'cum.emis.perc')]


write.csv(stat.dat, '../data/stat_230102.csv')
