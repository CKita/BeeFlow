################################################################################
#### Ecological Synthesis Lab (SintECO): https://marcomellolab.wordpress.com

#### Authors: Cristina A. Kita, Isabel Alves-dos-Santos, Michael Hrncir, 
#### Sara D. Leonhardt & Marco A. R. Mello

#### See README for further info:
#### https://github.com/CKita/BeeFlow#readme
################################################################################


################################################################################
############################# JOURNALS #########################################
################################################################################


#Let's get ready for running the code provided here. 

#Set the working directory to the source of this script file  
setwd(dirname(rstudioapi::getActiveDocumentContext()$path))
getwd()

#Delete all previous objects
rm(list= ls())

#Load or install the required packages
if(!require(dplyr)){
  install.packages("dplyr")
  library(dplyr)
}

if(!require(ggplot2)){
  install.packages("ggplot2")
  library(ggplot2)
}

if(!require(stringr)){
  install.packages("stringr")
  library(stringr)
}

# First, let's import and check our data set
articles <- read.csv("../Data/Article.csv", h= T, sep = ",")
class(articles)
str(articles)
head(articles)
tail(articles)

# Count the journals
journal_freq <- articles %>%
  count(Journal) %>%
  arrange(desc(n)) %>%
  rename(Frequency = n)

#Choose the colors of the bar graph 

color <- "#f4a4b7" 

# Plot the bar graph
g1 <- ggplot(journal_freq, aes(x = str_wrap(Journal, width = 20),
                               y = Frequency)) +
  geom_bar(stat = "identity", fill = color) +
  labs(title = "",
       x = "Journal",
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

png("../Figure/journals.png", res = 300,
    width = 5000, height = 2000, unit = "px")

g1

dev.off()

########################### THE END ############################################
