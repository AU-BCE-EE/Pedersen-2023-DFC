

### DFC data
dA <- read.csv('../data/expA.csv', sep = ';')
dB <- read.csv('../data/expB.csv', sep = ';')
dC_in <- read.csv('../data/expC_IN.csv')
dC_th <- read.csv('../data/expC_TH.csv')

### bLS data
bB <- read.table('../data/DFC_1_results_16_12_2022.txt', header = TRUE, fill = TRUE)
bC_in <- read.table('../data/DFC_2_east_results_20_03_2023_JP.txt', header = TRUE, fill = TRUE)
bC_th <- read.table('../data/DFC_2_west_results_20_03_2023_JP.txt', header = TRUE, fill = TRUE)

### soil and slurry data
sl <- read.xlsx('../data/slurry_soil.xlsx', sheet = 1)
so <- read.xlsx('../data/slurry_soil.xlsx', sheet = 2)

# precipitation data
pre <- read.table('../data/temp.txt', header = TRUE)

### temperature sensor data
dtA <- read.csv('../data/temp_log_A.csv', sep = ';')
dtB <- read.csv('../data/temp_log_B.csv', sep = ';')
dtC <- read.csv('../data/temp_log_C.csv', sep = ';')
dtD <- read.csv('../data/temp_log_D.csv', sep = ';')

