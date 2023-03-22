

dr$id <- as.character(dr$id)

dr$round <- 0
dr[(1:530), ]$round <- c('Round 1')
dr[(531:1060), ]$round <- c('Round 2')
dr[(1061:1590), ]$round <- c('Round 3')
dr[(1590:2119), ]$round <- c('Round 4')
dr <- dr[- 2120, ]

# removing valve 3 as it was not connected propperly
dr <- subset(dr, id != 3)

# Making elapsed.time fit with the first measurement of each valve = 0
dr$Vid <- 0
dr$Vid[1:20] <- c('V1', 'V2', 'V3', 'V4', 'V5', 'V6', 'V7', 'V8', 'V9', 'V10', 'V11', 'V12', 'V13', 'V14', 'V15', 'V16', 'V17', 'V18', 
                  'V19', 'V20')

splitdat <- split(dr, f = interaction(dr$id, dr$round))
new.names <- dr$Vid[1:20]

for (i in 1:20){
  assign(new.names[i], splitdat[[i]])
}

z = list(V1, V2, V3, V4, V5, V6, V7, V8, V9, V10, V11, V12, V13, V14, V15, V16, V17, V18, V19, V20)
new.dat = NULL
for(i in z){
  i$elapsed.time <- difftime(i$date.time, min(i$date.time), units='mins')
  new.dat <- rbind(new.dat,i)
}

dr <- new.dat

# adding a column with treatment names
dr$treat <- dr$id
dr$treat <- mapvalues(dr$treat, from = c('1', '5'), to = c(rep('AER 15', 2)))
dr$treat <- mapvalues(dr$treat, from = c('2', '4', '6'), to = c(rep('AER 20', 3)))
