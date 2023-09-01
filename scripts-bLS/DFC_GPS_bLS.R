####################
## DFC - MAG      ##
## November 2022  ##
## Jesper Kamp    ##
####################

library(rgdal)
library(bLSmodelR)
library(ggplot2)

## Set Wd
PATH_1 = "C:/Users/AU323818/Dropbox/Uni/Dynamic flux chambers/DFC bLS #1/QGIS/Surveying2"
PATH_2 = "C:/Users/AU323818/Dropbox/Uni/Dynamic flux chambers/DFC bLS #2/QGIS/Surveying2"



# ?readOGR
# set

## Load GPS data

#----------------------------------------------------------------------------------------------------------------------------------------#
#    1st trial - November 2022 - start 16-11-2022 - end 23-11-2022                                                                       #
#----------------------------------------------------------------------------------------------------------------------------------------#

Coordinates_Data <- readOGR(paste0(PATH_1,"/Surveying2Points.shp"))
colnames(Coordinates_Data@coords) <- c("x","y") # name the coordinates inside the list - bLS model need the names x and y - no capitals
Coordinates_Data@proj4string
GPS_Data <- Coordinates_Data[c(318:333),]
plot(GPS_Data)

sonic <- GPS_Data[13,]
# write.table(sonic@coords,paste0(PATH_1,"/sonic.txt"),sep="\t",row.names=FALSE)
write.table(sonic,paste0(PATH_1,"/sonic.txt"),sep="\t",row.names=FALSE)

background <- GPS_Data[14,]
# write.table(background@coords,paste0(PATH_1,"/background.txt"),sep="\t",row.names=FALSE)
write.table(background,paste0(PATH_1,"/background.txt"),sep="\t",row.names=FALSE)

downwind <- GPS_Data[15,]
# write.table(downwind@coords,paste0(PATH_1,"/downwind.txt"),sep="\t",row.names=FALSE)
write.table(downwind,paste0(PATH_1,"/downwind.txt"),sep="\t",row.names=FALSE)

plot1 <- GPS_Data[1:12,]
# plot1 <- plot1[order(plot1$id),]
# write.table(plot1@coords,paste0(PATH_1,"/plot1.txt"),sep="\t",row.names=FALSE)
write.table(plot1, paste0(PATH_1,"/plot1.txt"),sep="\t",row.names=FALSE)

#----------------------------------------------------------------------------------------------------------------------------------------#

plot1 <- read.table(paste0(PATH_1,"/plot1.txt"), header = TRUE, stringsAsFactors = FALSE)
Instr_plot <- read.table(paste0(PATH_1,"/downwind.txt"), header = TRUE, stringsAsFactors = FALSE)
Instr_bg <- read.table(paste0(PATH_1,"/background.txt"), header = TRUE, stringsAsFactors = FALSE)

Source <- genSources(Plot = plot1)
plot(Source)

# Sensors
Instr_plot$z <- 1.0 # Provide inlet height
Instr_bg$z <- 1.0


Sensors <- genSensors(CRDS = Instr_plot)
plot(Sensors, Source)


#
##
###
#----------------------------------------------------------------------------------------------------------------------------------------#
# RUN bLS MODEL
#----------------------------------------------------------------------------------------------------------------------------------------#
###
##
#


library(bLSmodelR)
library(ibts)

PATH_1 = "C:/Users/AU323818/Dropbox/Uni/Dynamic flux chambers/DFC bLS #1/QGIS/Surveying2"

PathData <- "C:/Users/AU323818/Dropbox/Uni/Dynamic flux chambers/DFC bLS #1"

PathRSaves <- paste0(PathData,"/RSaves")

Cat.Path <- paste0(PathData,"/bLS data/Catalogs")

#################################

############################
### Preparing Sonic Data ###
############################

Sonic_raw <- read.table(paste0(PathData,"/bLS data/DFC_1_TT_EC.txt"), header = TRUE, sep = "\t")

Sonic_ibts <- as.ibts(Sonic_raw, st="Time", granularity="30mins") # To get the right time as an ibts object.

N_traj_EC <- 1E5

ncores <- 1
MaxFetch <- -50

Sonic <- genInterval(
  cbind(
    setNames(as.data.frame(Sonic_raw)[,c("UST","L","z0","WD","d","sigU","sigV","sigW","z_sonic")]
             ,c("Ustar","L","Zo","WD","d","sUu","sVu","sWu","z_sWu"))
    ,st=st(Sonic_ibts)
    ,et=et(Sonic_ibts)
    ,Sonic_raw="Sonic"
    ,as.data.frame(Sonic_raw)[,!(names(Sonic_raw) %in% 
                                   c("Ustar","L","z0","WD","sd_WD","d","sUu","sVu","sWu","z_sonic"))])
  ,MaxFetch=MaxFetch,N=N_traj_EC)


#####################################
### Preparing sources and sensors ###
#####################################
plot1 <- read.table(paste0(PATH_1,"/plot1.txt"), header = TRUE, stringsAsFactors = FALSE)
Instr_plot <- read.table(paste0(PATH_1,"/downwind.txt"), header = TRUE, stringsAsFactors = FALSE)
Instr_bg <- read.table(paste0(PATH_1,"/background.txt"), header = TRUE, stringsAsFactors = FALSE)

# names(plot1)[3:4] <- c("x", "y")
# names(Instr_plot)[3:4] <- c("x", "y")
# names(Instr_bg)[3:4] <- c("x", "y")

Source <- genSources(Plot = plot1)
plot(Source)

# Sensors
Instr_plot$z <- 1.0 # Provide inlet height
Instr_bg$z <- 1.0


Sensors <- genSensors(CRDS = Instr_plot)
plot(Sensors, Source)

InList <- genInputList(Sensors,Source,Sonic)
InList

####################
### Calculations ###
####################

Results <- runbLS(InList,Cat.Path,ncores = )

# saveRDS(Results,file=paste0(PathRSaves,"/WT_bLS_Result_1E5.rds"))

###
# Results <- readRDS (file = file.path(paste0(PathRSaves,"/MMB_results_1E5.rds")))



# #########################
## SAVE FILES ##
write.table(Results,file=paste0(PathRSaves,"/DFC_1_results_1E5.csv"), sep=";", row.names = FALSE)






#----------------------------------------------------------------------------------------------------------------------------------------#
#    2nd trial - November 2022 - start 24-11-2022 - end 05-12-2022                                                                       #
#----------------------------------------------------------------------------------------------------------------------------------------#

Coordinates_Data <- readOGR(paste0(PATH_2,"/Surveying2Points.shp"))
colnames(Coordinates_Data@coords) <- c("x","y") # name the coordinates inside the list - bLS model need the names x and y - no capitals
Coordinates_Data@proj4string
GPS_Data <- Coordinates_Data[c(341:362),]
plot(GPS_Data)

sonic <- GPS_Data[21,]
# write.table(sonic@coords,paste0(PATH_1,"/sonic.txt"),sep="\t",row.names=FALSE)
write.table(sonic,paste0(PATH_2,"/sonic.txt"),sep="\t",row.names=FALSE)

background <- GPS_Data[22,]
write.table(background,paste0(PATH_2,"/background.txt"),sep="\t",row.names=FALSE)

west_CRDS <- GPS_Data[20,]
write.table(west_CRDS,paste0(PATH_2,"/west_CRDS.txt"),sep="\t",row.names=FALSE)

east_CRDS <- GPS_Data[5,]
write.table(east_CRDS,paste0(PATH_2,"/east_CRDS.txt"),sep="\t",row.names=FALSE)

plot_west <- GPS_Data[11:14,]
# plot1 <- plot1[order(plot1$id),]
write.table(plot_west, paste0(PATH_2,"/plot_west.txt"),sep="\t",row.names=FALSE)

plot_east <- GPS_Data[1:4,]
# plot1 <- plot1[order(plot1$id),]
write.table(plot_east, paste0(PATH_2,"/plot_east.txt"),sep="\t",row.names=FALSE)

#----------------------------------------------------------------------------------------------------------------------------------------#

plot_west <- read.table(paste0(PATH_2,"/plot_west.txt"), header = TRUE, stringsAsFactors = FALSE)
plot_east <- read.table(paste0(PATH_2,"/plot_east.txt"), header = TRUE, stringsAsFactors = FALSE)
Instr_west <- read.table(paste0(PATH_2,"/west_CRDS.txt"), header = TRUE, stringsAsFactors = FALSE)
Instr_east <- read.table(paste0(PATH_2,"/east_CRDS.txt"), header = TRUE, stringsAsFactors = FALSE)
Instr_bg <- read.table(paste0(PATH_2,"/background.txt"), header = TRUE, stringsAsFactors = FALSE)

Source <- genSources(Plot_west = plot_west, Plot_east = plot_east)
plot(Source)

# Sensors
Instr_west$z <- 0.5 # Provide inlet height
Instr_east$z <- 0.5 # Provide inlet height
Instr_bg$z <- 1.0


Sensors <- genSensors(CRDS_w = Instr_west, CRDS_e = Instr_east)
plot(Sensors, Source)



#
##
###
#----------------------------------------------------------------------------------------------------------------------------------------#
# RUN bLS MODEL
#----------------------------------------------------------------------------------------------------------------------------------------#
###
##
#


library(bLSmodelR)
library(ibts)

PATH_2 = "C:/Users/AU323818/Dropbox/Uni/Dynamic flux chambers/DFC bLS #2/QGIS/Surveying2"

PathData <- "C:/Users/AU323818/Dropbox/Uni/Dynamic flux chambers/DFC bLS #2"

PathRSaves <- paste0(PathData,"/RSaves")

Cat.Path <- paste0(PathData,"/bLS data/Catalogs")

#################################

############################
### Preparing Sonic Data ###
############################

Sonic_raw <- read.table(paste0(PathData,"/bLS data/DFC_2_TT_EC.txt"), header = TRUE, sep = "\t")

Sonic_ibts <- as.ibts(Sonic_raw, st="Time", granularity="30mins") # To get the right time as an ibts object.

N_traj_EC <- 1E5

ncores <- 1
MaxFetch <- -50

Sonic <- genInterval(
  cbind(
    setNames(as.data.frame(Sonic_raw)[,c("UST","L","z0","WD","d","sigU","sigV","sigW","z_sonic")]
             ,c("Ustar","L","Zo","WD","d","sUu","sVu","sWu","z_sWu"))
    ,st=st(Sonic_ibts)
    ,et=et(Sonic_ibts)
    ,Sonic_raw="Sonic"
    ,as.data.frame(Sonic_raw)[,!(names(Sonic_raw) %in% 
                                   c("Ustar","L","z0","WD","sd_WD","d","sUu","sVu","sWu","z_sonic"))])
  ,MaxFetch=MaxFetch,N=N_traj_EC)


#####################################
### Preparing sources and sensors ###
#####################################

plot_west <- read.table(paste0(PATH_2,"/plot_west.txt"), header = TRUE, stringsAsFactors = FALSE)
plot_east <- read.table(paste0(PATH_2,"/plot_east.txt"), header = TRUE, stringsAsFactors = FALSE)
Instr_west <- read.table(paste0(PATH_2,"/west_CRDS.txt"), header = TRUE, stringsAsFactors = FALSE)
Instr_east <- read.table(paste0(PATH_2,"/east_CRDS.txt"), header = TRUE, stringsAsFactors = FALSE)
Instr_bg <- read.table(paste0(PATH_2,"/background.txt"), header = TRUE, stringsAsFactors = FALSE)

Source <- genSources(Plot_west = plot_west, Plot_east = plot_east)
plot(Source)

# Sensors
Instr_west$z <- 0.5 # Provide inlet height
Instr_east$z <- 0.5 # Provide inlet height
Instr_bg$z <- 1.0


Sensors <- genSensors(CRDS_w = Instr_west, CRDS_e = Instr_east)
plot(Sensors, Source)

InList <- genInputList(Sensors,Source,Sonic)
InList

####################
### Calculations ###
####################

Results <- runbLS(InList,Cat.Path,ncores = )

# saveRDS(Results,file=paste0(PathRSaves,"/WT_bLS_Result_1E5.rds"))

###
# Results <- readRDS (file = file.path(paste0(PathRSaves,"/MMB_results_1E5.rds")))



# #########################
## SAVE FILES ##
write.table(Results,file=paste0(PathRSaves,"/DFC_2_results_1E5.csv"), sep=";", row.names = FALSE)


