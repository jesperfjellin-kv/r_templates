library(sf)
library(raster)
library(osmdata)
library(ggplot2)

# Set file paths
basemap_fp <- "C:\\R\\01Data\\TIF\\NE1_HR_LC_SR_W.tif"  # Replace with your raster file path
line_data_fp <- "C:\\R\\01Data\\Shapefiles\\Test\\linegeometry.shp"

# Read spatial line data
line_data <- st_read(line_data_fp)

# Ensure line data is in CRS:4326 (latitude/longitude)
line_data <- st_transform(line_data, 4326)

# Get the bounding box of your line data
bb_line <- st_bbox(line_data)

# Create a buffered bounding box around the line data
buffer <- 0.02  # Approx. 2km buffer in degrees - adapt as per your requirement
bb_buffered <- c(xmin = bb_line$xmin - buffer,
                 xmax = bb_line$xmax + buffer,
                 ymin = bb_line$ymin - buffer,
                 ymax = bb_line$ymax + buffer)

# Define query to get OSM data
q <- opq(bbox = bb_buffered)

# Add features you want to extract
q <- add_osm_feature(q, key = 'building')

# Extract data as sf object
osm_data <- osmdata_sf(q)

# Read raster data
basemap_raster <- raster(basemap_fp)

# (Optional) Plotting
# Note: To plot raster and sf data together, make sure that they are in the same CRS.
# Transform osm_data to match the CRS of the raster if needed.

osm_data_transformed <- st_transform(osm_data$osm_polygons, crs = projection(basemap_raster))

# Plot raster and OSM polygons together
plot(basemap_raster, main="OSM Buildings Overlay on Basemap")
plot(st_geometry(osm_data_transformed), add = TRUE, col = "lightblue", border = "darkblue")
