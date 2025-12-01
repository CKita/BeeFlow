################################################################################
#### Ecological Synthesis Lab (SintECO): https://marcomellolab.wordpress.com

#### Authors: Cristina A. Kita, Isabel Alves-dos-Santos, Michael Hrncir, 
#### & Marco A. R. Mello

#### See README for further info:
#### https://github.com/CKita/BeeFlow#readme
################################################################################


################################################################################
##################### SYSTEMATIC REVIEW - LITSEARCHR ########################### 
################################################################################

#Let's get ready for running the code. 

#Set the working directory to the source of this script file.  
setwd(dirname(rstudioapi::getActiveDocumentContext()$path))
getwd()

#Delete all previous objects.
rm(list= ls())

#Load or install the required packages.

if(!require(devtools)){
  install.packages("devtools")
  library(devtools)
}

if(!require(dplyr)){
  install.packages("dplyr")
  library(dplyr)
}

if(!require(ggplot2)){
  install.packages("ggplot2")
  library(ggplot2)
}

if(!require(ggraph)){
  install.packages("ggraph")
  library(ggraph)
}

if(!require(igraph)){
  install.packages("igraph")
  library(igraph)
}

if(!require(litsearchr)){
  remotes::install_github("elizagrames/litsearchr", ref="main")
  library(litsearchr)
}

if(!require(readr)){
  install.packages("readr")
  library(readr)
}

if(!require(remotes)){
  install.packages("remotes")
  library(remotes)
}

if(!require(revtools)){
  install.packages("revtools")
  library(revtools)
}

if(!require(stringi)){
  install.packages("stringi")
  library(stringi)
}

if(!require(stringr)){
  install.packages("stringr")
  library(stringr)
}

############################ DATABASES #########################################
#First, let's import and check the data.

#records from Scopus exported as "CSV"
scopus <- read.csv("../Data/scopus.csv", header = T, sep = ",")

#select the columns "Authors", "Title", and "Abstract"
scopus <- subset(scopus, select = c(Authors, Title, Abstract))
str(scopus)
write.csv(scopus, "scopus_checked.csv")

#records from Web of Science
wos <- read.csv("../Data/wos.csv", header = T, sep = ",")
write.csv(wos, "records_wos.csv")

#select the columns "Authors", "Title", and "Abstract"
wos <- subset(wos, select = c(Authors, Article.Title, Abstract))
colnames(wos) <- c("Authors", "Title", "Abstract")
str(wos)
write.csv(wos, "wos_checked.csv")

#records from Scielo 
scielo <- read.csv("../Data/scielo.csv", header = T, sep = ",")

#select the columns "AU", "TI", and "AB"
scielo <- subset(scielo, select = c(AU, TI, AB))
colnames(scielo) <- c("Authors", "Title", "Abstract")
write.csv(scielo, "scielo_checked.csv")

#let's merge them using litsearchr package 

records1 <- litsearchr::import_results(file = c("scopus_checked.csv"))
records2 <- litsearchr::import_results(file = c("wos_checked.csv"))
records3 <- litsearchr::import_results(file = c("scielo_checked.csv"))

records123 <- litsearchr::import_results(file = c("scopus_checked.csv",
                                                  "wos_checked.csv", 
                                                  "scielo_checked.csv"))

#Finally, remove the duplicates

dedupli<- litsearchr::remove_duplicates(records123, 
                                        field= "title",
                                        method="exact")

write.csv(dedupli, "../Data/duplicate_records_removed.csv") #it's also important 
                                                    #to check them manually


################################# THE END ######################################
