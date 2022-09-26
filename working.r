#Thomas Kudey

library(ncdf4)
library(dplyr)
library(tidyverse)
nc_fname <- "MTDCA_201904_202003_36km_V4.nc"
nc_ds <- nc_open(nc_fname)

dim_lon <- ncvar_get(nc_ds, "lon")
dim_lat <- ncvar_get(nc_ds, "lat")
dim_time <- ncvar_get(nc_ds, "time")

coords <- as.matrix(expand.grid(dim_lon, dim_lat, dim_time))

VOD <- ncvar_get(nc_ds, "VOD", collapse_degen=FALSE)
soil_moisture <- ncvar_get(nc_ds, "soil_moisture", collapse_degen=FALSE)
timeIndex <- ncvar_get(nc_ds, "timeIndex", collapse_degen=FALSE)

nc_df_nna <- data.frame(na.omit(cbind(coords, VOD, soil_moisture, timeIndex)))

names(nc_df_nna) <- c("lon", "lat", "time", "VOD", "soil_moisture", "timeIndex")

nc_df_nna$time = as.Date(nc_df$time, origin = "1900-01-01", tz = "UTC")

head(nc_df_nna, 10)  # Display some non-NaN values for a visual check
#csv_fname <- "netcdf_filename.csv"

summary(nc_df_nna)


#VOD[VOD$time == "1", ]
plt2 <- filter(nc_df_nna,
               lat >= 68, 
               lat <= 69.2, 
               lon >= 148.7, 
               lon <= 149.9,
               time >= "2019-05-01",
               time <= "2019-08-31")
plt2
summary(plt2)
length(plt$lon)
head(plt2,10)

#plt$time<-as.Date(plt$timeIndex)  
#library("xts")
#gfg_ts <- xts(plt$val, plt$timeIndex)
#gfg_ts

plot(x = plt2$time, y = plt2$VOD, type='l')
plt
print("hi")




write.table(na.omit(nc_df), csv_fname, row.names=FALSE, sep=";")



