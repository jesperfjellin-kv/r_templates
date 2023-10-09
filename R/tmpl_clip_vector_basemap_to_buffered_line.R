library(sf)          # for handling spatial objects
library(rmapshaper)  # for the clipping function

# Set file paths
basemap_fp <- "C:\\R\\01Data\\Shapefiles\\NE_Admin_countries\\ne_10m_admin_0_countries.shp"
line_data_fp <- "C:\\R\\01Data\\Shapefiles\\Test\\linegeometry.shp"

# Read spatial data
basemap <- st_read(basemap_fp)
line_data <- st_read(line_data_fp)

# Ensure the CRS (Coordinate Reference System) is the same
if(st_crs(basemap) != st_crs(line_data)) {
  warning("CRS mismatch! Reprojecting line data to CRS of basemap...")
  line_data <- st_transform(line_data, st_crs(basemap))
}

# Create buffer around line data
buffer_distance <- 2000  # adjust value as per your requirement
buffered_line_data <- st_buffer(line_data, dist = buffer_distance)

# Clip basemap with buffered line data
clipped_basemap <- ms_clip(basemap, buffered_line_data)

# EXPORT:
st_write(line_data, "C:\\R\\02Output\\out1.shp")
st_write(clipped_basemap, "C:\\R\\02Output\\out2.shp")

# Plot
#par(mfrow=c(1, 3), mar=c(3,3,3,3))
#plot(st_geometry(basemap), main="Original Basemap", col="lightblue")
#plot(st_geometry(line_data), main="Original Line Data", col="blue")
#plot(st_geometry(clipped_basemap), main="Clipped Basemap", col="lightblue")
#lines(st_coordinates(line_data), col = "blue")  # Add the original line_data on top
