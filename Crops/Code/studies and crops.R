################################################################################
#### Ecological Synthesis Lab (SintECO): https://marcomellolab.wordpress.com

#### Authors: Cristina A. Kita, Isabel Alves-dos-Santos, Michael Hrncir
#### & Marco A. R. Mello

#### See README for further info:
#### https://github.com/CKita/BeeFlow#readme
################################################################################


################################################################################
####################### NUMBER OF STUDIES PER CROP #############################
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

if(!require(showtext)){
  install.packages("showtext")
  library(showtext)
}

if(!require(sysfonts)){
  install.packages("sysfonts")
  library(sysfonts)
}


# First, let's look at our dataset
df <- read.csv2("../Data/studies and crops.csv", header = TRUE)
class(df)
str(df)
head(df)
tail(df)

# Load a font that contains the symbols ✿ ❀ ❁
font_add_google("Noto Sans Symbols 2", "notoSymbols2")
showtext_auto()  # activates rendering via showtext

# Summarize number of studies per crop
studies_by_crop <- df %>%
  count(CropType) %>%
  arrange(CropType) %>%  # <-- alphabetical order
  mutate(CropType = factor(CropType, levels = CropType))

g <- ggplot(studies_by_crop, aes(x = CropType, y = n)) +
  geom_segment(aes(x = CropType, xend = CropType, y = 0, yend = n),
               linewidth = 0.5, color = "#4E9F3D") +
  geom_text(aes(label = "\u2740"),              
            family = "notoSymbols2",
            color  = "#9D00ff", size = 10) +   
  labs(x = "Crop type", y = "Number of studies") +
  theme_minimal(base_size = 14) +
  theme(
    panel.grid = element_blank(),
    axis.line  = element_line(color = "black", linewidth = 0.5),
    axis.ticks = element_line(color = "black", linewidth = 0.5),
    axis.ticks.length = unit(3, "pt"),
    axis.text.x = element_text(angle = 45, hjust = 1, size = 14),
    axis.text.y = element_text(hjust = 1, size = 14),
    plot.title  = element_text(hjust = 0.3),
    axis.title.x = element_text(face = "bold", size = 14, 
                                margin = margin(t = 15)),
    axis.title.y = element_text(face = "bold", size = 14, 
                                margin = margin(r = 15))
  )

g


# Export the plot
png(filename = "../Figure/studies and crops.png", 
    res = 300, height = 4500, width = 9500)
par(mfrow = c(1, 1), mar = c(5, 5, 5, 1), bg = "white")

print(g)

dev.off()


############################## THE END #########################################
