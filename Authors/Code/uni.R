################################################################################
#### Ecological Synthesis Lab (SintECO): https://marcomellolab.wordpress.com

#### Authors: Cristina A. Kita, Isabel Alves-dos-Santos, Michael Hrncir
#### & Marco A. R. Mello

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
if(!require(ggplot2)){
  install.packages("ggplot2")
  library(ggplot2)
}

if(!require(dplyr)){
  install.packages("dplyr")
  library(dplyr)
}


# First, let's import and check our data set.
df <- read.csv("../Data/uni.csv", h= T, sep = ";")
class(df)
str(df)
head(df)
tail(df)

# Calculate the number of institutions per country

numero_instituicoes_por_pais <- df %>%
  group_by(UniversityCountry) %>%
  summarise(NumeroDeInstituicoes = n_distinct(AuthorsInstitute))



#Visualize the graph

png("../Figure/institutions.png", res = 300,
    width = 4000, height = 2000, unit = "px")

ggplot(numero_instituicoes_por_pais,
       aes(x = UniversityCountry, y = NumeroDeInstituicoes)) +
  geom_bar(stat = "identity", fill = "#E04B5E") +
  labs(x = "Country", y = "Number of institutions", title = "") +
  scale_y_continuous(limits = c(0, 12), breaks = seq(0, 12, by = 2)) +
  theme_minimal() +
  theme(
    panel.grid.major = element_blank(),   # Remove as grades principais
    panel.grid.minor = element_blank(),   # Remove as grades menores
    axis.line = element_line(color = "black", linewidth = 0.3),  # Adiciona as linhas dos eixos
    axis.ticks = element_line(color = "black", linewidth = 0.3), # Adiciona os ticks dos eixos
    axis.text.x = element_text(size = 16, angle = 45, hjust = 1),
    axis.text.y = element_text(size = 16),
    axis.title.x = element_text(size = 16),
    axis.title.y = element_text(size = 16)
  )

dev.off()

########################### THE END ############################################