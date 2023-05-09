#####################################################################################################
# UTILITIES                                                                                         #
#####################################################################################################

# Create a copy of the slides as pdf and ppt

printslide <- function(pres) {
  try(xaringanBuilder::build_all(paste(pres, ".Rmd", sep = ""), include = c("pdf","pptx")), silent = TRUE)
  file.rename(from = paste(pres,".pdf", sep = ""), to =  paste("pdf/",pres,".pdf", sep = ""))
  file.rename(from = paste(pres,".pptx", sep = ""), to =  paste("ppt/",pres,".pptx", sep = ""))
}


# Generate map of equally spaced points

library(raster)
library(rgdal)
library(rgeos)
library(sp)

x_coords <- c(10,10,20,20,10)
y_coords <- c(10,20,20,10,10)
poly1 <- sp::Polygon(cbind(x_coords,y_coords))

x_coords <- c(30,30,40,40,30)
y_coords <- c(10,20,20,10,10)
poly2 <- sp::Polygon(cbind(x_coords,y_coords))

x_coords <- c(10,10,20,20,10)
y_coords <- c(-10,0,0,-10,-10)
poly3 <- sp::Polygon(cbind(x_coords,y_coords))

x_coords <- c(30,30,40,40,30)
y_coords <- c(-10,0,0,-10,-10)
poly4 <- sp::Polygon(cbind(x_coords,y_coords))

SpatialPoly <- sp::SpatialPolygons(list(sp::Polygons(list(poly1), ID = "A"),
                                        sp::Polygons(list(poly2), ID = "B"),
                                        sp::Polygons(list(poly3), ID = "C"),
                                        sp::Polygons(list(poly4), ID = "D")
)
)

plot(SpatialPoly)
shapefile(x = SpatialPoly, file = "docs/map1.shp")
SpatialPoly@polygons[[1]]


x <- c(10,10,20,20,10,30,30,40,40,30,10,10,20,20,10,30,30,40,40,30)
y <- c(10,20,20,10,10,10,20,20,10,10,-10,0,0,-10,-10,-10,0,0,-10,-10)

ggplot(POINTS) + aes(x = x, y = y) + 
  geom_point(size = 4, col = "red")

