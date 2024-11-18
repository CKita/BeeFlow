################################################################################
#### Ecological Synthesis Lab (SintECO): https://marcomellolab.wordpress.com

#### Authors: Cristina A. Kita, Isabel Alves-dos-Santos, Michael Hrncir, 
#### Sara D. Leonhardt & Marco A. R. Mello

#### See README for further info:
#### https://github.com/CKita/BeeFlow#readme
################################################################################


################################################################################
###################### EFFECTS OF FLORAL PLANTINGS #############################
################################################################################


#Let's get ready for running the code provided here. 

#Set the working directory to the source of this script file.   
setwd(dirname(rstudioapi::getActiveDocumentContext()$path))
getwd()

#Delete all previous objects.
rm(list= ls())

#Load or install the required packages
if(!require(qcc)){
  install.packages("qcc")
  library(qcc)
}

#list the variables to create the fishbone diagram and export the diagram as PNG
#image

png("../Figure/fishbone.png", res = 300,
    width = 4000, height = 2000, unit = "px")

g1 <-cause.and.effect(cause=list(Bees=c("group 1", "group 2", "group 3", "etc"),
                          Crops=c("type 1", "type 2", "type 3", "etc"),
                          "Floral planting compostion"=c("plant species 1",
                                                           "plant species 2", 
                                                           "plant species 3",
                                                           "etc"),
                          "Study region"=c("region 1", "region 2", 
                                             "region 3", "etc"),
                          "Study design"=c("edge-interior",
                                             "interior-interior"),
                          "Other factors"=c("crop area", "crop management",
                                            "natural vegetation cover","etc")),
         effect=c("exporter or 
         concentrator or
         neutral effect                                   "), 
                 title = "",
                 cex = c(1.2, 1, 1.5),
                 font = c(1, 3, 2))

dev.off()

############################ THE END ###########################################
