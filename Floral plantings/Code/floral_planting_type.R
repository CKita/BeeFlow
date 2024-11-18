################################################################################
#### Ecological Synthesis Lab (SintECO): https://marcomellolab.wordpress.com

#### Authors: Cristina A. Kita, Isabel Alves-dos-Santos, Michael Hrncir, 
#### Sara D. Leonhardt & Marco A. R. Mello

#### See README for further info:
#### https://github.com/CKita/BeeFlow#readme
################################################################################


################################################################################
########################### BEES - ABUNDANCE ###################################
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
fst <- read.csv("../Data/floral_planting_type.csv", h= T, sep = ";")
class(fst)
str(fst)
head(fst)
tail(fst)

# Count the type of floral plantings
fst_freq <- fst %>%
  count(FloralPlantingType) %>%
  arrange(desc(n)) %>%
  rename(Frequency = n)

#Choose the colors of the bar graph
colors <- c("#c6e1a5", "#f4a4b7","#b9d8f2" )


#plot the bar graph
g1 <- ggplot(fst_freq, aes(x = FloralPlantingType, y = Frequency)) +
  geom_bar(stat = "identity", fill = colors) +
  labs(title = "",
       x = "Floral planting type",
       y = "Number of studies") +
  theme_minimal() +
  theme(panel.grid.major = element_blank(),        # Remove background lines
        panel.grid.minor = element_blank(),        # Remove background lines
        axis.title.x = element_text(vjust = -0.5),          # adjust the angle of labes
        axis.title.y = element_text(vjust = 1),
        axis.text.x = element_text(angle = 0),
        axis.line = element_line(color = "black", size = 0.3),  # Add axis line
        axis.ticks = element_line(color = "black", size = 0.3),  #add tick marks
        axis.title = element_text(size = 16),      # Tamanho do título dos eixos
        axis.text = element_text(size = 16))

g1

#Export the bar graph as PNG image.
png("../Figure/floral_planting_types.png", res = 300,
    width = 4000, height = 2000, unit = "px")

g1

dev.off()

########################### THE END ############################################
