# load geospatial libraries
x <- c("ggmap", "rgdal", "rgeos", "maptools", "dplyr", "tidyr", "tmap", "sf")
# install.packages(x)
lapply(x, library, character.only = TRUE)
# load data
file <- "./data_tidy/kids_count_ky_lbw_by_county.csv"
df.00 <- read.csv(file = file, stringsAsFactors = F)
# add polygons
cl.00 <- rgdal::readOGR(dsn = "Ky_County_Lines", layer = "Ky_County_Lines", stringsAsFactors = F)
# keep county name
keep.col <- c(1, 3, 5)
cl.01 <- cl.00[, keep.col]
colnames(cl.01@data) <- tolower(colnames(cl.01@data))
colnames(cl.01@data)[3] <- "location"
# This is extremely dangerous method--be careful!!
cl.01@data$pid <- sapply(slot(cl.01, "polygons"), function(x) slot(x, "ID"))
xx.df <- cl.01@data
xx.df <- xx.df[, c(3, 4)]
df.01 <- merge(df.00, xx.df)
row.names(df.01) <- df.01$pid
cl.01@data <- merge(cl.01@data, df.01)
row.names(cl.01@data) <- cl.01$pid

# convert to geojson
library(geojsonio)
county_json <- geojson_json(cl.01)
# simplify the data
library(rmapshaper)
county_json_simplified <- ms_simplify(county_json)
# write it out
file = "./data_tidy/kids_count_ky_lbw_by_county.geojson"
geojson_write(county_json_simplified, file = file)
