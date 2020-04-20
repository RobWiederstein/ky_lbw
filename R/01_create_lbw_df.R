file <- "./data_pure/lbw.csv"
df.00 <- read.csv(file = file, stringsAsFactors = F)
colnames(df.00) <- tolower(colnames(df.00))
#subset to counties
df.01 <- dplyr::filter(df.00, locationtype == "County")
#subset to latest three year period
df.02 <- dplyr::filter(df.01, timeframe == "2015-2017")
#create percent column
df.02$lbw_pct <- as.numeric(df.02$data) * 100
#create septile
df.02$septile <- ggplot2::cut_interval(df.02$lbw_pct, n = 7)
#label factor
levels(df.02$septile) <- 1:7
#omit nas
df.03 <- df.02
#select columns
df.04 <- dplyr::select(df.03, c("location", 
                                "timeframe",
                                "lbw_pct",
                                "septile"
                                )
                       )
df.04 <- dplyr::arrange(df.04, location)
#write out
file <- "./data_tidy/kids_count_ky_lbw_by_county.csv"
write.csv(df.04, file = file, row.names = T)
table(df.04$septile)
