

dd.summ<- summarise(group_by(dd, tk, app.meth, treat, elapsed.time), flux.mn = mean(flux), flux.sd = sd(flux),
                      cum.emis.mn = mean(cum.emis), cum.emis.sd = sd(cum.emis))

