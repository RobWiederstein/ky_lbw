# Low Birth Weight

The data was furnished courtesy of the Annie E. Casey Kids County initiative. Low birth weight is an excellent indicator of overall maternal and infant health. My home county--Henderson County, Kentucky--has struggled in this area for years. This project was undertaken to learn about leaflet choropleth maps and had the benefit of a working model on the "Kids Count" website. (The website allows for a county choropleth map to be drawn using one of dozens of indicators.)

# Join of Dataframe with Shape file

Efforts to join the dataframe with the shapefile were challenging. When performing the operation, an error message was generated that `row.names` did not match polygon `ID`. Several different methods were attempted including the one below:

```
#crucial insight came from Robin Lovelace
# dplyr::left_join function
lnd@data <- left_join(lnd@data, crime_ag, by = c('name' = 'Borough'))
```

GIS exchange had a question that directly addressed the issue. The author noted that matching rownames with polygon id was a common problem. This GIS exchange [post](https://gis.stackexchange.com/questions/141469/how-to-convert-a-spatialpolygon-to-a-spatialpolygonsdataframe-and-add-a-column-t) gave the background to the problem and most most importantly showed how to get the polygon ID from the polyspatial object. I was finally able to get it to work.

```
#assign polygon id to column variable in
#county line .shp file
cl.01@data$pid <- sapply(slot(cl.01, "polygons"), function(x) slot(x, "ID"))
```

## Acknowledgements

[Annie E. Casey Kids County Initiative](https://www.google.com/url?sa=t&rct=j&q=&esrc=s&source=web&cd=1&cad=rja&uact=8&ved=2ahUKEwi_zc-A9vboAhXUWc0KHYgsD2UQFjAAegQIBRAB&url=https%3A%2F%2Fdatacenter.kidscount.org%2F&usg=AOvVaw3eaRtqU8RiRm96ymZbFmdH).

[Kentucky Open GIS Data Portal](http://kygovmaps-kygeonet.opendata.arcgis.com).

[Robin Lovelace--Creating Maps in R](https://github.com/Robinlovelace/Creating-maps-in-R).

[Robin Lovelace--Geocomputation in R](https://github.com/Robinlovelace/geocompr).

[Kan Nishida--Creating GeoJSON out of Shapefile in R](https://blog.exploratory.io/creating-geojson-out-of-shapefile-in-r-40bc0005857d).

[Cartocolors: Data-driven color schemes](https://carto.com/carto-colors/).
