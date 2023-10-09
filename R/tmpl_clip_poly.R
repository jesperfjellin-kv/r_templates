library(sf)           # for handling spatial objects
library(rmapshaper)   # for the clipping function

# Set file paths
basemap_fp <- "C:\\R\\01Data\\Shapefiles\\NE_Admin_countries\\ne_10m_admin_0_countries.shp"  # Replace with your file path
data_fp <- "C:\\R\\01Data\\GML\\Barnehager_Viken.gml"  # Replace with your file path

# Read spatial data
basemap <- st_read(basemap_fp)
data <- st_read(data_fp)

# Ensure the CRS (Coordinate Reference System) is the same. Considering 
# switching which dataset gets reporjected based on size and locality. 
if(st_crs(basemap) != st_crs(data)) {
  warning("CRS mismatch! Re-projecting target_data to CRS of basemap...")
  data <- st_transform(data, st_crs(basemap))
}

# Perform clipping
clipped_basemap <- ms_clip(basemap, data)

# Plot to verify the operation
par(mfrow=c(1, 3), mar=c(3,3,3,3))
plot(st_geometry(basemap), main="Base Map", col="lightblue")
plot(st_geometry(data), main="Target Data", col="lightgrey")
plot(st_geometry(clipped_basemap), main="Clipped Base Map", col="lightblue")


