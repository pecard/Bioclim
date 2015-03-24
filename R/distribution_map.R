kpacks <- c('ggplot2', 'rgbif', 'rgdal', 'ggmap')
new.packs <- kpacks[!(kpacks %in% installed.packages()[ ,"Package"])]
if(length(new.packs)) install.packages(new.packs)
lapply(kpacks, require, character.only=T)
remove(kpacks, new.packs)

#' Accessing GBIF Data
myesp <- 'Nesocharis ansorgei'
taxadata <- name_backbone(name = myesp)
spdata <- occ_search(taxonKey=taxadata$speciesKey
                     , maxresults = 1000
                     ,hasCoordinate = T
                     ,return='data')

#' Paper data: kml file
mypath <- 'H:/Programacao/R/mapas'
mdata <- as.data.frame(readOGR(file.path(mypath,'nesocharis.kml'),
                               layer = "nesocharis"))
#' Plot
aoimap <- qmap(location = 'africa', maptype = "roadmap", source = "google",
              extent = 'panel', zoom = 4, darken = c(0.5, "white"))

aoimap + 
  geom_point(aes(decimalLongitude, decimalLatitude), data = spdata)+
  geom_point(aes(coords.x1, coords.x2), data = mdata, colour = 'red')
  
  
  
# sort(unique(map_data("world")$region))
