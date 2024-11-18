################################################################################
#### Ecological Synthesis Lab (SintECO): https://marcomellolab.wordpress.com

#### Authors: Cristina A. Kita, Isabel Alves-dos-Santos, Michael Hrncir, 
#### Sara D. Leonhardt & Marco A. R. Mello

#### See README for further info:
#### https://github.com/CKita/BeeFlow#readme
################################################################################


################################################################################
######################## AUTHORS - UNIVERSITIES ################################
################################################################################


#Let's get ready for running the code provided here. 

#Set the working directory to the source of this script file.   
setwd(dirname(rstudioapi::getActiveDocumentContext()$path))
getwd()

#Delete all previous objects.
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

# First, let's import and check the data set.
df <- read.csv("../Data/uni.csv", h= T, sep = ";")
class(df)
str(df)
head(df)
tail(df)

# Calculate the number of institutions per country

institutions_by_country <- df %>%
  group_by(UniversityCountry) %>%
  summarise(NumeroDeInstituicoes = n_distinct(AuthorsInstitute))



#Visualize the graph

png("../Figure/institutions.png", res = 300,
    width = 4000, height = 2000, unit = "px")

ggplot(institutions_by_country,
       aes(x = UniversityCountry, y = NumeroDeInstituicoes)) +
  geom_segment(aes(x = UniversityCountry, xend = UniversityCountry,
                   y = 0, yend = NumeroDeInstituicoes), color = "#E04B5E") +
  geom_point(size = 3, color = "#E04B5E") +
  labs(x = "Country", y = "Number of institutions", title = "") +
  scale_y_continuous(limits = c(0, 12), breaks = seq(0, 12, by = 2)) +
  theme_minimal() +
  theme(
    axis.text.x = element_text(size = 16, angle = 45, hjust = 1),
    axis.text.y = element_text(size = 16),
    axis.title.x = element_text(size = 16),
    axis.title.y = element_text(size = 16)
  )

dev.off()

########################### THE END ############################################
