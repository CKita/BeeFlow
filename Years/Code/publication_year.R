################################################################################
#### Ecological Synthesis Lab (SintECO): https://marcomellolab.wordpress.com

#### Authors: Cristina A. Kita, Isabel Alves-dos-Santos, Michael Hrncir, 
#### Sara D. Leonhardt, & Marco A. R. Mello

#### See README for further info:
#### https://github.com/CKita/BeeFlow#readme
################################################################################


################################################################################
########################### PUBLICATION - YEARS ################################
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
articles <- read.csv("../Data/Article.csv", h= T, sep = ",")
class(articles)
str(articles)
head(articles)
tail(articles)

#change the class of Publication column from character to date
articles$Publication <- as.Date(articles$Publication)

# Add a column with publication year
articles <- articles %>%
  mutate(year_publication = format(articles$Publication, "%Y"))

# Count the number of articles per year
article_per_year <- articles %>%
  group_by(year_publication) %>%
  summarise(n_articles = n())


article_per_year <- article_per_year %>%
  arrange(year_publication)

article_per_year$year_publication <- as.integer(article_per_year$
                                                  year_publication)

# Create the point graph with connecting lines
g1 <- ggplot(article_per_year, aes(x = year_publication, y = n_articles)) +
  geom_point(color = "mediumorchid", size = 3) +      
  geom_line(color = "mediumorchid", linewidth = 0.5) + 
  labs(title = "",
       x = "Year of publication",
       y = "Number of studies") +       
theme_minimal() +                                  
  theme(panel.grid.major = element_blank(),        
        panel.grid.minor = element_blank(),        
        axis.title.x = element_text(vjust = -0.5),          
        axis.title.y = element_text(vjust = 1),
        axis.line = element_line(color = "black", size = 0.3),  
        axis.ticks = element_line(color = "black", size = 0.3), 
        axis.title = element_text(size = 16),      
        axis.text = element_text(size = 16)) +      
  
    scale_x_continuous(breaks = seq(min(article_per_year$year_publication), 
                                  max(article_per_year$year_publication), 
                                  by = 1))   
g1

#Export the graph as PNG image.
png("../Figure/publication_year.png", res = 300,
    width = 4000, height = 2000, unit = "px")
g1

dev.off()

########################### THE END ############################################


