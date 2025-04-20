################################################################################
#### Ecological Synthesis Lab (SintECO): https://marcomellolab.wordpress.com

#### Authors: Cristina A. Kita, Isabel Alves-dos-Santos, Michael Hrncir, 
#### Sara D. Leonhardt & Marco A. R. Mello

#### See README for further info:
#### https://github.com/CKita/BeeFlow#readme
################################################################################


################################################################################
############################# STUDY SITES ######################################
################################################################################


#Let's get ready for running the code provided here. 

#Set the working directory to the source of this script file.   
setwd(dirname(rstudioapi::getActiveDocumentContext()$path))
getwd()

#Delete all previous objects.
rm(list= ls())

#Load or install the required packages
if(!require(ggplot2)){
  install.packages("ggplot2")
  library(ggplot2)
}

if(!require(ggspatial)){
  install.packages("ggspatial")
  library(ggspatial)
}

if(!require(maps)){
  install.packages("maps")
  library(maps)
}

if(!require(rnaturalearth)){
  install.packages("rnaturalearth")
  library(rnaturalearth)
}

if(!require(rnaturalearthdata)){
  install.packages("rnaturalearthdata")
  library(rnaturalearthdata)
}

if(!require(sf)){
  install.packages("sf")
  library(sf)
}

if(!require(dplyr)){
  install.packages("dplyr")
  library(dplyr)
}

# First, let's import and check our data set
sites <- read.csv("../Data/sites.csv", h= T, sep = ",")
class(sites)
str(sites)
head(sites)
tail(sites)

#Now, select the columns with the coordinates and study type.

sites_short <- sites %>% 
  dplyr::select(Latitude, Longitude, RefCode)

#Check the data
head(sites_short)

# Get a base map
world_map <- st_as_sf(map("world", plot = FALSE, fill = TRUE))

# Create sample points

sample_points <- sites_short

# Convert sample points to simple features
sample_points_sf <- st_as_sf(sample_points, coords = c("Longitude", "Latitude"),
                             crs = 4326)


#Plot the base map.

g1 <- ggplot(data = world_map) +
  geom_sf(colour = "white", fill = "lightgrey") +
  coord_sf(xlim = c(-180, 180), ylim = c(-58,90), expand = FALSE) +
  theme_bw() +
  theme(
    panel.grid.major = element_blank(),  # Remove major grid lines
    panel.grid.minor = element_blank(),   # Remove minor grid lines
    axis.ticks = element_line(color = "black", element_line(0.3)),  #add tick marks
    axis.title = element_text(size = 16),      # Tamanho do título dos eixos
    axis.text = element_text(size = 16)) +

#Plot the sites
  geom_point(data = sites_short, aes(x = Longitude, y = Latitude,
                                     colour = "red"), 
             alpha = 0.5, size = 2) +
 
  #Add a scale bar
  ggspatial::annotation_scale(
    location = "bl", width_hint = 0.3,
    bar_cols = c("grey30", "white")) +
  
  # Add a north arrow
  ggspatial::annotation_north_arrow(
    location = "tr", which_north = "true",
    height = unit(0.8, "cm"), 
    width = unit(0.8, "cm"),
    style = ggspatial::north_arrow_fancy_orienteering(
      fill = c("white","grey30")))

#Check the map.
g1

#Export the map as PNG image.
png("../Figure/sites.png", res = 300,
    width = 4000, height = 2000, unit = "px")
g1

dev.off()

### another option 

#check the country table

table(list(sites$Country))

#Change the class to a data frame
count_country <- as.data.frame(table(list(sites$Country)))

# Prepare your data
study_data <- data.frame(
  country = count_country$Var1,
  studies = count_country$Freq
)

# Get a base world map
world <- ne_countries(scale = "medium", returnclass = "sf")

#check the names 
missing_countries <- setdiff(study_data$country, world$name)
print(missing_countries)

# Merge your data with the world map
world_data <- left_join(world, study_data, by = c("name" = "country"))

# Plot the map
g2 <- ggplot(data = world_data) +
  geom_sf(aes(fill = studies), color = "white") +
  scale_fill_gradient(low = "blue", high = "red", 
                      na.value = "grey80", name = "Number of studies") +
  coord_sf(xlim = c(-180, 180), ylim = c(-58, 90), expand = FALSE) +
  theme_minimal() +
  theme(
    panel.grid.major = element_blank(),
    panel.grid.minor = element_blank(),
    axis.ticks = element_line(color = "black", linewidth =  0.3),
    axis.title = element_text(size = 16),   
    axis.text = element_text(size = 16)) +
  
  labs(title = ,
       x = "Longitude", y = "Latitude") +
  
  #Add a scale bar
  ggspatial::annotation_scale(
    location = "bl", width_hint = 0.3,
    bar_cols = c("grey30", "white")) +
  
  # Add a north arrow
  ggspatial::annotation_north_arrow(
    location = "tr", which_north = "true",
    height = unit(0.8, "cm"), 
    width = unit(0.8, "cm"),
    style = ggspatial::north_arrow_fancy_orienteering(
      fill = c("white","grey30")))

g2

#Export the map as PNG image.
png("../Figure/sites2.png", res = 300,
    width = 4000, height = 2000, unit = "px")
g2

dev.off()

########################### THE END ############################################