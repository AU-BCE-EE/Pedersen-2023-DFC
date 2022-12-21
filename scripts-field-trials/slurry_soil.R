
# summarizing slurry data
sl.summ <- summarise(group_by(sl, tk), 
                    amount.mn = mean(amount), 
                    TS.mn = mean(TS), TS.sd = sd(TS),
                    totN.mn = mean(totN), totN.sd = sd(totN), 
                    amN.mn = mean(ammonium.N), amN.sd = sd(ammonium.N),
                    pH.mn = mean(pH), pH.sd = sd(pH))

# g m-2
sl.summ$app.rate <- sl.summ$amount.mn * sl.summ$amN.mn * 10^-1

# summarizing soil data
# dry bulk density and pH
so.summA <- summarise(group_by(so), 
                      bulk.dens.mn = mean(bulk.dens), bulk.dens.sd = sd(bulk.dens), 
                      pH.mn = mean(pH), pH.sd = sd(pH)) 
# grav water content
so.summB <- summarise(group_by(so, tk),
                      gw.mn = mean(W), gw.sd = sd(W))
