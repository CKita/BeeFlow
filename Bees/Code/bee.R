################################################################################
#### Ecological Synthesis Lab (SintECO): https://marcomellolab.wordpress.com

#### Authors: Cristina A. Kita, Isabel Alves-dos-Santos, Michael Hrncir, 
#### & Marco A. R. Mello

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

if(!require(vcd)){
  install.packages("vcd")
  library(vcd)
}


# First, let's import and check our data set.
WithApis <- read.csv("../Data/withApis.csv", h= T, sep = ";")
class(WithApis)
str(WithApis)
head(WithApis)
tail(WithApis)


# Count the bee species

beeSpecies <- WithApis$BeeSpecies
beeSpecies <- as.data.frame(beeSpecies)
speciesCount <- table(beeSpecies)
print(speciesCount)

# Convert the table to a data frame 
df_speciesCount <- as.data.frame(speciesCount)
colnames(df_speciesCount) <- c("Species", "Frequency")
print(df_speciesCount)

# Plot the pie chart
g1 <- ggplot(df_speciesCount, aes(x = "", y = Frequency, fill = Species)) +
  geom_bar(stat = "identity", width = 1) +
  coord_polar("y", start = 0) +
  theme_void() + 
  labs(fill = "Bee species") +
  ggtitle("") +
  scale_fill_brewer(palette = "Set1") +
  theme(
    plot.title = element_text(size = 20, face = "bold",hjust = 0.5),     
    legend.title = element_text(size = 16),                  
    legend.text = element_text(size = 16, face = "italic")                    
  )

g1

#Export the pie chart as PNG image.
png("../Figure/withApis.png", res = 300,
    width = 4000, height = 2000, unit = "px")
g1

dev.off()

########################### THE END ############################################

