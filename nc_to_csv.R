#Thomas Kudey

library(ncdf4)
nc_fname <- "MTDCA_201904_202003_36km_V4.nc"
nc_ds <- nc_open(nc_fname)

dim_lon <- ncvar_get(nc_ds, "lon")
dim_lat <- ncvar_get(nc_ds, "lat")
dim_time <- ncvar_get(nc_ds, "time")
coords <- as.matrix(expand.grid(dim_lon, dim_lat, dim_time))

VOD <- ncvar_get(nc_ds, "VOD", collapse_degen=FALSE)
soil_moisture <- ncvar_get(nc_ds, "soil_moisture", collapse_degen=FALSE)
timeIndex <- ncvar_get(nc_ds, "timeIndex", collapse_degen=FALSE)

nc_df <- data.frame(cbind(coords, VOD, soil_moisture, timeIndex))
names(nc_df) <- c("lon", "lat", "time", "VOD", "soil_moisture", "timeIndex")
head(na.omit(nc_df), 10)  # Display some non-NaN values for a visual check
csv_fname <- "netcdf_filename.csv"
print(na.omit(nc_df))


write.table(na.omit(nc_df), csv_fname, row.names=FALSE, sep=";")



