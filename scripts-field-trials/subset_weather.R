

w1 <- data.frame(elapsed.time = dA[, c('elapsed.time')], airT = dA[, c('temp')], WS = '', tk = 'A')

bw2 <- bbw[bbw$tk == 'B', ]
w2 <- data.frame(elapsed.time = bw2[, c('elapsed.time')], airT = bw2[, c('airT')], WS = bw2[, c('WS')], tk = 'B')

bw3 <- bbw[bbw$tk == 'C', ]
w3 <- data.frame(elapsed.time = bw3[, c('elapsed.time')], airT = bw3[, c('airT')], WS = bw3[, c('WS')], tk = 'C')

weather <- rbind(w1, w2, w3)

weather$airT <- as.numeric(weather$airT)
weather$WS <- as.numeric(weather$WS)

weather <- pivot_longer(weather, 2:3, names_to = 'what', values_to = 'num')


??pivot_longer
