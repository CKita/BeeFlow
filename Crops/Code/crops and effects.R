################################################################################
#### Ecological Synthesis Lab (SintECO): https://marcomellolab.wordpress.com

#### Authors: Cristina A. Kita, Isabel Alves-dos-Santos, Michael Hrncir, 
#### & Marco A. R. Mello

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

##Delete all previous objects.
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

if(!require(scales)){
  install.packages("scales")
  library(scales)
}

# First, let's import and check our data set.

df <- read.csv2("../Data/crops and effects.csv", header = TRUE)

# Check that the data loaded correctly
class(df)
str(df)
head(df)
tail(df)


# Convert both columns to factors
df$CropType <- as.factor(df$CropType)
df$EffectType <- as.factor(df$EffectType)

# Inspect the levels (categories)
levels(df$CropType)
levels(df$EffectType)


# Create the stacked bar plot (showing proportions)
g <- ggplot(df, aes(x = CropType, fill = EffectType)) +
  geom_bar(position = "fill", color = "white", linewidth = 0.3) +
  scale_y_continuous(labels = percent_format(accuracy = 1)) +
  scale_fill_manual(values = c(
    "exporter" = "#8BC34A",      
    "concentrator" = "#F48FB1",  
    "neutral" = "#B0BEC5"     
    )) +
  labs(
    x = "Crop type",
    y = "Proportion (%)",
    fill = "effect of floral planting"
  ) +
  theme_minimal(base_size = 20) +
  theme(
    panel.grid.major.x = element_blank(),
    axis.text.x = element_text(size = 20, angle = 45, hjust = 1),  
    axis.text.y = element_text(size = 20),                         
    axis.title.x = element_text(size = 20, 
                                face = "bold", margin = margin(t = 10)),  
    axis.title.y = element_text(size = 20, 
                                face = "bold", margin = margin(r = 15)),  
    legend.position = "top",
    legend.title = element_text(size = 20, face = "bold"),
    legend.text = element_text(size = 20)

  )

g

# Export the plot
png(filename = "../Figure/crops and effects.png", 
    res = 300, height = 3000, width = 5000)

par(mfrow = c(1, 1), mar = c(5, 5, 5, 1), bg = "white")

print(g)

dev.off()


############################## THE END #########################################

