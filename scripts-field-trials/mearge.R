# with each replicate: 
bb1 <- bb
dd1 <- dd

df1 <- rbind(dd1, bb1)
df1$elapsed.time <- as.numeric(df1$elapsed.time)

# tr = C: bLS results good for 5 days = 120 h
# tr = B: DFC results good for 160 h
df1 <- df1[! c(df1$tk == 'C' & df1$elapsed.time >= 120), ]
df1 <- df1[! c(df1$tk == 'B' & df1$elapsed.time >= 120), ]


# with mean and sd: 
bb2 <- bb

bb2$cum.emis.sd <- 'NA'
bb2$flux.sd <- 'NA'
colnames(bb2)[which(names(bb2) == 'flux')] <- 'flux.mn'
colnames(bb2)[which(names(bb2) == 'cum.emis')] <- 'cum.emis.mn'
bb2 <- bb2[! names(bb2) == c('date.time')]; bb2 <- bb2[! names(bb2) == c('id')]

bb2$elapsed.time <- as.numeric(bb2$elapsed.time)
bb2$cum.emis.sd <- as.numeric(bb2$cum.emis.sd)
bb2$flux.sd <- as.numeric(bb2$flux.sd)

df2 <- rbind(bb2, dd.summ)

# bLS results good for 5 days = 120 h
df2 <- df2[! c(df2$tk == 'C' & df2$elapsed.time >= 120), ]
df2 <- df2[! c(df2$tk == 'B' & df2$elapsed.time >= 120), ]
