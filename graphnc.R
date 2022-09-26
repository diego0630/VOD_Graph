#Thomas Kudey

library(ncdf4)
library(dplyr)
library(tidyverse)
nc_fname <- "MTDCA_201904_202003_36km_V4.nc"
nc_ds <- nc_open(nc_fname)

dim_lon <- ncvar_get(nc_ds, "lon")
dim_lat <- ncvar_get(nc_ds, "lat")
dim_time <- ncvar_get(nc_ds, "time")
dim_time = as.Date(dim_time, origin = "1900-01-01", tz = "UTC")

coords <- as.matrix(expand.grid(dim_lon, dim_lat, dim_time))

VOD <- ncvar_get(nc_ds, "VOD", collapse_degen=FALSE)
soil_moisture <- ncvar_get(nc_ds, "soil_moisture", collapse_degen=FALSE)
timeIndex <- ncvar_get(nc_ds, "timeIndex", collapse_degen=FALSE)
#timeIndex = as.Date(timeIndex, origin = "1900-01-01", tz = "UTC")

nc_df <- data.frame(cbind(coords, VOD, soil_moisture, timeIndex))
nc_df_nna <- data.frame(na.omit(cbind(coords, VOD, soil_moisture, timeIndex)))

names(nc_df) <- c("lon", "lat", "time", "VOD", "soil_moisture", "timeIndex")
names(nc_df_nna) <- c("lon", "lat", "time", "VOD", "soil_moisture", "timeIndex")

nc_df$time = as.Date(nc_df$time, origin = "1900-01-01", tz = "UTC")

head(na.omit(nc_df), 10)  # Display some non-NaN values for a visual check
head(nc_df_nna, 10)  # Display some non-NaN values for a visual check
#csv_fname <- "netcdf_filename.csv"
print(na.omit(nc_df))

summary(nc_df_nna)


#VOD[VOD$time == "1", ]
data[nc_df_nna$VOD == 0.2090773]
subset(nc_df_nna, VOD == "0.2090773")
summary(filter(nc_df_nna, timeIndex == 20190701))

filter(filter(nc_df_nna, lat >= 68), lat <= 69)
filter(nc_df_nna,
       lat >= 68.5, 
       lat <= 68.7, 
       lon >= 149.1, 
       lon <= 149.3,
       timeIndex >= 20190501,
       timeIndex <= 20190831)

filter(nc_df_nna,
       lat >= 67, 
       lat <= 69, 
       lon >= 148, 
       lon <= 150,
       timeIndex >= 20190501,
       timeIndex <= 20190831)

summary(filter(nc_df_nna,
               lat >= 67, 
               lat <= 69, 
               lon >= 148, 
               lon <= 150,
               timeIndex >= 20190501,
               timeIndex <= 20190831))
plt <- filter(nc_df_nna,
              lat >= 68, 
              lat <= 69.2, 
              lon >= 148.7, 
              lon <= 149.9,
              timeIndex >= 20190501,
              timeIndex <= 20190831)
plt2 <- filter(na.omit(nc_df),
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

plt$timeIndex = as.Date(plt$timeIndex, origin = "1900-01-01", tz = "UTC")
#plt$time<-as.Date(plt$timeIndex)  
#library("xts")
#gfg_ts <- xts(plt$val, plt$timeIndex)
#gfg_ts

plot(x = plt2$time, y = plt2$VOD, type='l')
plt
print("hi")


library(ggplot2)
library(ggthemes)

myColors = c('#538f56')

plt2 %>%
  ggplot(aes(x = time, y = VOD, color = 'Arctic Shrub Data 36km')) +
  geom_line() +
  geom_point() +
  labs(title = "VOD vs Time in Arctic Shrub site",
       x = "Date",
       y = "Vegitation Optical Depth",
       col = "Key") +
  
  theme_fivethirtyeight() +
  theme(axis.title = element_text()) +
  scale_color_manual(values = myColors)










