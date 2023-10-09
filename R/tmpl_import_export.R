library(sf)

#---------------------------
# 1. Importing Spatial Data
#---------------------------

# Define file path for input data
input_path <- "C:\\R\\01Data\\GPKG\\Kontur_popdensity\\Norway\\Norway_popdensity.gpkg"

# Read the spatial data
spatial_data <- st_read(input_path)

#--------------------------------
# 2. Explore Imported Spatial Data
#--------------------------------

# View first few rows of the data
print(head(spatial_data))

# Basic plot of the spatial object
plot(st_geometry(spatial_data))
title("Your Spatial Data")