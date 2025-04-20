################################################################################
#### Ecological Synthesis Lab (SintECO): https://marcomellolab.wordpress.com

#### Authors: Cristina A. Kita, Isabel Alves-dos-Santos, Michael Hrncir, 
#### Sara D. Leonhardt, & Marco A. R. Mello

#### See README for further info:
#### https://github.com/CKita/BeeFlow#readme
################################################################################


################################################################################
######################### KEYWORDS - WORD CLOUD ################################
################################################################################


#Let's get ready for running the code provided here. 

#Set the working directory to the source of this script file.   
setwd(dirname(rstudioapi::getActiveDocumentContext()$path))
getwd()

#Delete all previous objects.
rm(list= ls())

#Load or install the required packages
if(!require(wordcloud)){
  install.packages("wordcloud")
  library(wordcloud)
}

if(!require(dplyr)){
  install.packages("dplyr")
  library(dplyr)
}

if(!require(readr)){
  install.packages("readr")
  library(readr)
}

if(!require(RColorBrewer)){
  install.packages("RColorBrewer")
  library(RColorBrewer)
}

# First, let's import and check our data set.
words <- read.csv("../Data/keywords.csv", stringsAsFactors = FALSE)
class(words)
str(words)
head(words)
tail(words)

# Calculate the frequency of keywords
word_freq <- words %>%
  count(Keywords) %>%
  rename(word = Keywords, freq = n)


# Adjust the image size and create the word cloud
png("../Figure/wordcloud.png", res = 300,
    width = 4000, height = 2000, unit = "px")


# Criar a nuvem de palavras usando a paleta básica
wordcloud(words = word_freq$word, 
          freq = word_freq$freq, 
          min.freq = 1,               
          scale = c(4, 0.5),          
          colors = brewer.pal(8, "Accent"))

dev.off()

########################### THE END ############################################