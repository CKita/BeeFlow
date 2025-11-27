################################################################################
#### Ecological Synthesis Lab (SintECO): https://marcomellolab.wordpress.com

#### Authors: Cristina A. Kita, Isabel Alves-dos-Santos, Michael Hrncir
#### & Marco A. R. Mello

#### See README for further info:
#### https://github.com/CKita/BeeFlow#readme
################################################################################


################################################################################
############################ STUDIES PER COUNTRY ###############################
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

if(!require(dplyr)){
  install.packages("dplyr")
  library(dplyr)
}

if(!require(sf)){
  install.packages("dplyr")
  library(dplyr)
}

if(!require(rnaturalearth)){
  install.packages("rnaturalearth")
  library(rnaturalearth)
}

if(!require(rnaturalearthdata)){
  install.packages("rnaturalearthdata")
  library(rnaturalearthdata)
}

if(!require(ggspatial)){
  install.packages("ggspatial")
  library(ggspatial)
}


# First, let's look at our dataset
df <- read.csv2("../Data/studies and countries.csv", header = TRUE)
class(df)
str(df)
head(df)
tail(df)


# Count the number of studies per country (only Country and RefCode)

count_country <- as.data.frame(table(list(df$Country)))
colnames(count_country) <- c("country", "studies")

# Let's create a base map and check the country names

world <- ne_countries(scale = "medium", returnclass = "sf")

missing_countries <- setdiff(count_country$country, world$name)
print(missing_countries)

# Join data + map

world_data <- left_join(world, count_country, by = c("name" = "country"))

# Map 

g2 <- ggplot(data = world_data) +
  geom_sf(aes(fill = studies), color = "white", linewidth = 0.2) +
  scale_fill_gradient(
    low = "blue", high = "red",
    na.value = "grey80",
    name = "Number of studies"
  ) +
  coord_sf(xlim = c(-180, 180), ylim = c(-58, 90), expand = FALSE) +
  theme_minimal(base_size = 13) +
  theme(
    panel.grid.major = element_blank(),
    panel.grid.minor = element_blank(),
    axis.ticks       = element_line(color = "black", linewidth = 0.3),
    axis.title       = element_text(size = 16),
    axis.text        = element_text(size = 14),
    legend.title     = element_text(face = "bold"),
    plot.title       = element_text(face = "bold", size = 16)
  ) +
  labs(
    title = "Geographical distribution of studies by country",
    x = "Longitude", y = "Latitude"
  ) +
  ggspatial::annotation_north_arrow(
    location = "tr", which_north = "true",
    height = unit(0.8, "cm"),
    width  = unit(0.8, "cm"),
    style  = 
      ggspatial::north_arrow_fancy_orienteering(fill = c("white", "grey30"))
  )

g2


# Export PNG

png("../Figure/studies and countries.png", 
    res = 300, width = 4000, height = 2000)
print(g2)
dev.off()
