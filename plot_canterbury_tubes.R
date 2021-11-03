library(data.table)
library(sf)
library(leaflet)

# map projections used, UK national grid, and lat,lon
ukgrid <- "+init=EPSG:27700"
latlong <- "+init=epsg:4326"

# load the tube data
tubes <- fread("data/canterbury_tubes.csv")

# create a simple feature geometry in lat,lon
tubes <- st_as_sf(tubes,coords=c("Easting","Northing"),crs=ukgrid,remove=F)
tubes$geometry <- st_transform(tubes$geometry,crs=latlong)

# create a leaflet with the values and markers
m <- leaflet(data=tubes) %>% addTiles() %>% addMarkers(popup=~as.character(SiteID),label=~as.character(BiasAdjusted),labelOptions = labelOptions(noHide=T))
print(m)