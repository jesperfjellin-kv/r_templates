import rioxarray
from datashader.transfer_functions import shade
from datashader.colors import Elevation
from xrspatial import hillshade
from datashader.transfer_functions import stack

# Step 1: Load and visualize the DEM data
dem = rioxarray.open_rasterio('output_SRTMGL1.tif', masked=True).squeeze().drop("band")
dem.plot();

# Step 2: Apply shading to visualize different elevations
shade_dem = shade(dem, cmap=Elevation, how='linear')
shade_dem.plot() # Adjusted 'da' to 'dem' and added the plot function

# Step 3: Create a hillshade to visualize the terrain in 3D
illumination = hillshade(dem)
hillshade_gray = shade(illumination, alpha=255, how='linear')
hillshade_gray.plot() # Added the plot function

# Step 4: Stack the terrain and hillshade for a vivid 3D elevation map
terrain_elevation = shade(dem, cmap=Elevation, alpha=128, how='linear')
stacked = stack(hillshade_gray, terrain_elevation)
stacked.plot() # Added the plot function
