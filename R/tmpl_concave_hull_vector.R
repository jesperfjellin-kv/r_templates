library(sf)           # for handling spatial objects
library(ggplot2)      # for plotting
library(dplyr)        # for data manipulation

# Function to check CRS and reproject if necessary for vector data
reproject_vector_to_match <- function(target_vector, source_vector) {
  if(st_crs(target_vector) != st_crs(source_vector)) {
    message("CRS mismatch! Reprojecting vector data...")
    return(st_transform(target_vector, st_crs(source_vector)))
  }
  return(target_vector)
}

# File paths
basemap_fp <- "C:\\R\\01Data\\Shapefiles\\NE_Admin_countries\\ne_10m_admin_0_countries.shp"
data_fp <- "C:\\R\\01Data\\GML\\Barnehager_Viken.gml"

# Read spatial data
basemap <- st_read(basemap_fp)
basemap <- st_make_valid(basemap)
data <- st_read(data_fp)

# Ensure data and basemap are in the same CRS
data <- reproject_vector_to_match(data, basemap)

# Calculate the convex hull
data_hull <- data %>% 
  st_union() %>% 
  st_convex_hull()

st_write(data_hull, "C:\\R\\02Output\\data_hull.shp", delete_dsn = TRUE)
st_write(data, "C:\\R\\02Output\\data.shp", delete_dsn = TRUE)
