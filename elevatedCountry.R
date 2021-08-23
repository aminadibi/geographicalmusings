library(rayshader)
library(elevatr)
library(raster)
library(magick)

readRDS(url("https://biogeo.ucdavis.edu/data/gadm3.6/Rsf/gadm36_IRN_0_sf.rds")) -> iran

elevatr::get_elev_raster(iran, z=6) -> dem

raster::mask(dem, iran) -> iran_dem

rayshader::raster_to_matrix(iran_dem) -> iran_mat

rayshader::resize_matrix(iran_mat, 0.5) -> iran_mat_reduced

iran_mat_reduced %>%
  sphere_shade(texture = "imhof3") %>%
#  add_water(detect_water(iran_mat_reduced),color="imhof3") %>%
  plot_3d(iran_mat_reduced, windowsize = c(1200, 1200), zscale = 20,
          zoom= 0.75, phi = 89, theta =0, fov = 0, background = "white")


render_camera(zoom = 0.6, phi = 89, theta = 0, fov = 0)

render_highquality(filename = "iran.png", sample = 10, width = 6000, height = 6000 )



