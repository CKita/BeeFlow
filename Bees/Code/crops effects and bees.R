################################################################################
#### Ecological Synthesis Lab (SintECO): https://marcomellolab.wordpress.com

#### Authors: Cristina A. Kita, Isabel Alves-dos-Santos, Michael Hrncir, 
#### & Marco A. R. Mello

#### See README for further info:
#### https://github.com/CKita/BeeFlow#readme
################################################################################


################################################################################
######################## BEES, CROPS AND EFFECTS ###############################
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

if(!require(forcats)){
  install.packages("forcats")
  library(forcats)
}

if(!require(scales)){
  install.packages("scales")
  library(scales)
}

# First, let's look at our dataset

df <- read.csv2("../Data/crops effects and bees.csv", header = TRUE)
class(df)
str(df)
head(df)
tail(df)

# Convert columns to factors and set the order
df <- df %>%
  mutate(
    CropType = as.factor(CropType),
    Bees = fct_relevel(as.factor(Bees),
                       "wild bees", "honeybees", "bumble bees", "unidentified"),
    EffectType = fct_relevel(as.factor(EffectType),
                             "concentrator", "exporter", "neutral") 
  )

# Calculate proportions within each crop and bee group 
plot_df <- df %>%
  distinct(RefCode, CropType, Bees, EffectType) %>% 
  count(CropType, Bees, EffectType, name = "n") %>%
  group_by(CropType, Bees) %>%
  mutate(prop = n / sum(n)) %>%
  ungroup()

# Plot 
g <- ggplot(plot_df, aes(x = Bees, y = prop, fill = EffectType)) +
  geom_bar(stat = "identity", 
           position = "fill", color = "white", linewidth = 0.25) +
  facet_wrap(~ CropType, ncol = 4, scales = "free_x") +
  scale_y_continuous(labels = percent_format(accuracy = 1)) +
  scale_fill_manual(values = c(
    "exporter" = "#8BC34A",      # green
    "concentrator" = "#F48FB1",  # pink
    "neutral" = "#C0C0C0"        # grey
  )) +
  labs(
    x = "Bee group",
    y = "Proportion (%)",
    fill = "Effect type"
  ) +
  theme_minimal(base_size = 20) +
  theme(
    legend.position = "top",
    legend.title = element_text(size = 20, face = "bold"),
    legend.text = element_text(size = 20),
    axis.text.x = element_text(size = 20, angle = 30, hjust = 1),
    axis.text.y = element_text(size = 20),
    axis.title.x = element_text(size = 20, 
                                face = "bold", margin = margin(t = 10)),
    axis.title.y = element_text(size = 20, 
                                face = "bold", margin = margin(r = 10)),
    panel.spacing.x = unit(0.8, "lines"), 
    panel.spacing.y = unit(1, "lines"),    
    panel.grid.major.x = element_blank(),
    strip.text = element_text(size = 20) # crop names in panels
  )

# Export the plot
png(filename = "../Figure/crops effects and bees.png", 
    res = 300, height = 7000, width = 6000)
par(mfrow = c(1, 1), mar = c(5, 5, 5, 1), bg = "white")

print(g)

dev.off()

############################## THE END #########################################

