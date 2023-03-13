
dd$conc <- dd$NH3_30s

dd.summ<- summarise(group_by(dd, treat, elapsed.time), conc.mn = mean(conc), conc.sd = sd(conc))

