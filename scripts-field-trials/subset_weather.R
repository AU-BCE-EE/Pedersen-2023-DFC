

w1 <- data.frame(elapsed.time = dA[, c('elapsed.time')], airT = dA[, c('temp')], WS = '', tk = 'A')

w2 <- data.frame(elapsed.time = bbw[, c('elapsed.time')], airT = bbw[, c('airT')], WS = bbw[, c('WS')], tk = bbw[, c('tk')])

weather <- rbind(w1, w2)

weather$airT <- as.numeric(weather$airT)
weather$WS <- as.numeric(weather$WS)

weather <- pivot_longer(weather, 2:3, names_to = 'what', values_to = 'num')

weather <- rbind(weather, pre)



