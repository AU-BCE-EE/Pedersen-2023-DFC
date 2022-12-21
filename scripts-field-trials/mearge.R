# with each replicate: 
bb1 <- bb
dd1 <- dd

bb1$treat <- 'bLS'

df1 <- rbind(dd1, bb1)
df1$elapsed.time <- as.numeric(df1$elapsed.time)

# tr = C: bLS results good for 5 days = 120 h
# tr = B: DFC results good for 160 h
df1 <- df1[! c(df1$tk == 'C' & df1$elapsed.time >= 120), ]
df1 <- df1[! c(df1$tk == 'B' & df1$elapsed.time >= 120), ]

# adding slurry data and calculating flux and cum_emis as percentage of TAN
df1 <- right_join(df1, sl.summ, by = 'tk')
df1$flux.perc <- df1$flux / df1$app.rate * 100
df1$cum.emis.perc <- df1$cum.emis / df1$app.rate * 100

# with mean and sd: 
bb2 <- bb

bb2$treat <- 'bLS'
bb2$cum.emis.sd <- 'NA'
bb2$flux.sd <- 'NA'
colnames(bb2)[which(names(bb2) == 'flux')] <- 'flux.mn'
colnames(bb2)[which(names(bb2) == 'cum.emis')] <- 'cum.emis.mn'
bb2 <- bb2[! names(bb2) == c('date.time')]; bb2 <- bb2[! names(bb2) == c('id')]

bb2$elapsed.time <- as.numeric(bb2$elapsed.time)
bb2$cum.emis.sd <- as.numeric(bb2$cum.emis.sd)
bb2$flux.sd <- as.numeric(bb2$flux.sd)

df2 <- rbind(bb2, dd.summ)

# adding slurry data and calculating flux and cum_emis as percentage of TAN
df2 <- right_join(df2, sl.summ, by = 'tk')
df2$flux.mn.perc <- df2$flux.mn / df2$app.rate * 100
df2$flux.sd.perc <- df2$flux.sd / df2$app.rate * 100
df2$cum.emis.mn.perc <- df2$cum.emis.mn / df2$app.rate * 100
df2$cum.emis.sd.perc <- df2$cum.emis.sd / df2$app.rate * 100

# bLS results good for 5 days = 120 h
df2 <- df2[! c(df2$tk == 'C' & df2$elapsed.time >= 120), ]
df2 <- df2[! c(df2$tk == 'B' & df2$elapsed.time >= 120), ]
