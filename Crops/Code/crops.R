################################################################################
#### Ecological Synthesis Lab (SintECO): https://marcomellolab.wordpress.com

#### Authors: Cristina A. Kita, Isabel Alves-dos-Santos, Michael Hrncir, 
#### Sara D. Leonhardt, & Marco A. R. Mello

#### See README for further info:
#### https://github.com/CKita/BeeFlow#readme
################################################################################


################################################################################
############################# CROP TYPES #######################################
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

# First, let's import and check our data set.
crop <- read.csv("../Data/crop_type.csv", h= T, sep = ";")
class(crop)
str(crop)
head(crop)
tail(crop)

# Count the type of crops
crop_freq <- crop %>%
  count(CropType) %>%
  arrange(desc(n)) %>%
  rename(Frequency = n)

#Choose the colors of the bar graph 

play_dough_colors <- c("#f5a623", "#f44d4d", "#f7d94b", "#6bc6e0",
                       "#9d7d6f", "#b1d93b", "#e08f8f", "#a46c9e",
                       "#f0a6c8", "#c6e1a5", "#f4a4b7", "#b9d8f2",
                       "#f8e05a", "#a3d9a3", "#f1b6b6", "#c0c6e2")

# Plot the bar graph
g1 <- ggplot(crop_freq, aes(x = CropType, y = Frequency)) +
  geom_bar(stat = "identity", fill = play_dough_colors) +
  labs(title = "",
       x = "Crop",
       y = "Number of studies") +
  theme_minimal() +
  theme(panel.grid.major = element_blank(),        
        panel.grid.minor = element_blank(),        
        axis.title.x = element_text(vjust = -0.5),         
        axis.title.y = element_text(vjust = 1),
        axis.text.x = element_text(angle = 45, hjust = 1),
        axis.line = element_line(color = "black", size = 0.3), 
        axis.ticks = element_line(color = "black", size = 0.3),  
        axis.title = element_text(size = 16),      
        axis.text = element_text(size = 16))
g1

#Export the bar graph as PNG image.

png("../Figure/crops.png", res = 300,
    width = 4000, height = 2000, unit = "px")

g1

dev.off()

########################### THE END ############################################
