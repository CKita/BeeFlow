################################################################################
#### Ecological Synthesis Lab (SintECO): https://marcomellolab.wordpress.com

#### Authors: Cristina A. Kita, Isabel Alves-dos-Santos, Michael Hrncir, 
#### Sara D. Leonhardt & Marco A. R. Mello

#### See README for further info:
#### https://github.com/CKita/BeeFlow#readme
################################################################################


################################################################################
################### PLANT SPECIES IN THE FLORAL PLANTINGS ######################
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

########### TOP 10 PLANT SPECIES CULTIVATED IN THE FLORAL PLANTINGS ############

# First, let's see our data set

df <- read.csv("../Data/flowerStrip_per_diff_floral_plantings.csv", 
               h= T, sep = ";")
class(df)
str(df)
head(df)
tail(df)

# Calculate the frequencies of each plant species and select the top 10 species
#cultivated in the floral plantings

top10_especies <- df %>%
  group_by(FlowerSpecies) %>%
  summarise(Frequencia = n()) %>%
  arrange(desc(Frequencia)) %>%
  slice_head(n = 10)  # select the top 10 plant species

# Calculate the percentages of the top 10 plant species 
top10_especies <- top10_especies %>%
  mutate(Percentual = Frequencia / sum(Frequencia) * 100)

#Choose 10 colors for the graph 

colors <-  c("#FF6F61", "#6B5B95", "#88B04B", "#F5B041", "#9B59B6",
            "#A2D9CE", "#E6B0AA", "#F9E79F", "#B3CDE3", "#F2B6D1")

# Finally, let's plot a donut chart and export it as a PNG image.

png("../Figure/floral_plantings.png", res = 300,
    width = 4000, height = 2000, unit = "px")

ggplot(top10_especies, aes(x = 2, y = Percentual, fill = FlowerSpecies)) +
  geom_bar(stat = "identity", color = "black", width = 1) +
  coord_polar(theta = "y") +
  xlim(0.5, 2.5) +  
  theme_void() +  
  theme(legend.position = "right",  
        legend.text = element_text(size = 16, face = "italic"), 
        legend.title = element_text(size = 16)) +
  labs(fill = "Top 10 plant species",
       title = "") +
  geom_text(aes(label = Frequencia), 
            position = position_stack(vjust = 0.5), size = 6, color = "black") +  
  scale_fill_manual(values =colors)  

dev.off()

############################# THE END ##########################################
