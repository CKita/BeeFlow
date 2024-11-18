################################################################################
#### Ecological Synthesis Lab (SintECO): https://marcomellolab.wordpress.com

#### Authors: Cristina A. Kita, Isabel Alves-dos-Santos, Michael Hrncir, 
#### Sara D. Leonhardt & Marco A. R. Mello

#### See README for further info:
#### https://github.com/CKita/BeeFlow#readme
################################################################################


################################################################################
############################ AUTHORS - NETWORK #################################
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

if(!require(ggraph)){
  install.packages("ggraph")
  library(ggraph)
}

if(!require(ggforce)){
  install.packages("ggforce")
  library(ggforce)
}

if(!require(ggplot2)){
  install.packages("ggplot2")
  library(ggplot2)
}

if(!require(ggrepel)){
  install.packages("ggrepel")
  library(ggrepel)
}

if(!require(igraph)){
  install.packages("igraph")
  library(igraph)
}

if(!require(randomcoloR)){
  install.packages("randomcoloR")
  library(randomcoloR)
}

if(!require(tibble)){
  install.packages("tibble")
  library(tibble)
}

########### TOP 10 PLANT SPECIES CULTIVATED IN FLORAL PLANTINGS ################

# First, let's check the data set

df <- read.csv("../Data/network_authors.csv", h= T, sep = ";")
class(df)
str(df)
head(df)
tail(df)

# Define the vectors
author <- df$Author
paper <- df$RefCode

#create a coauthor pair list

coauthor_pairs_list <- list()

for (article in unique(paper)) {
  authors_in_article <- author[paper == article]
  if (length(authors_in_article) > 1) {
    pairs <- combn(authors_in_article, 2, simplify = FALSE)
    coauthor_pairs_list <- c(coauthor_pairs_list, pairs)
  }
}

# Convert to matrix
coauthor_pairs <- do.call(rbind, lapply(coauthor_pairs_list, function(x) matrix(x, ncol = 2)))

# Create a graph
g <- graph_from_edgelist(coauthor_pairs, directed = FALSE)

# Check the graph
g

# Detect the modules
modules <- cluster_louvain(g)
membership <- membership(modules)

# Define the color palette
palette <- distinctColorPalette(max(membership))

# Assign colors to the nodes
node_color <- palette[membership]

# Define node size
node_size <- rep(16, vcount(g))

# Choose the network layout
layout <- layout_with_fr(g, niter = 1300)

# Prepare node data 
node_data <- tibble(
  x = layout[, 1],
  y = layout[, 2],
  node = V(g)$name,
  module = membership
)

# Prepare edge data 
edge_data <- as_tibble(as_edgelist(g)) %>%
  rename(from = V1, to = V2) %>%
  left_join(node_data %>% select(node, x, y), by = c("from" = "node")) %>%
  rename(x_from = x, y_from = y) %>%
  left_join(node_data %>% select(node, x, y), by = c("to" = "node")) %>%
  rename(x_to = x, y_to = y)

#Calculate the centroid and radius of each module, adjusting to avoid overlap
circle_data <- node_data %>%
  group_by(module) %>%
  summarise(
    x_center = mean(x),
    y_center = mean(y),
    radius = max(sqrt((x - mean(x))^2 + (y - mean(y))^2)) * 1.2 
  ) %>%
  arrange(desc(radius))

# Check and adjust circle overlap
# If necessary, adjust the multiplier factor for the radius

# Visualize the network

png("../Figure/network_authors.png", res = 300, width = 12000, 
    height = 9000, unit = "px")

ggplot() +
  geom_segment(data = edge_data, 
               aes(x = x_from, y = y_from, xend = x_to, yend = y_to),
               color = "darkgrey", alpha = 0.8, size = 2) +
  geom_circle(data = circle_data, 
              aes(x0 = x_center, y0 = y_center, r = radius, 
                  fill = as.factor(module)), alpha = 0.2, color = NA) +
  geom_point(data = node_data,
             aes(x = x, y = y, color = as.factor(module)), 
             size = 8, alpha = 1) +
  geom_text_repel(data = node_data, 
                  aes(x = x, y = y, label = node), color = "black", size = 12, 
                  box.padding = 0.5, point.padding = 0.5, max.overlaps = Inf) +
  scale_fill_manual(values = palette, name = "Module") +
  scale_color_manual(values = palette, name = "Module") +
  theme_void() +
  theme(
    legend.position = "none",
    plot.title = element_blank()
  )

dev.off()

############################## THE END #########################################
