################################################################################
#### Ecological Synthesis Lab (SintECO): https://marcomellolab.wordpress.com

#### Authors: Cristina A. Kita, Isabel Alves-dos-Santos, Michael Hrncir, 
#### & Marco A. R. Mello

#### See README for further info:
#### https://github.com/CKita/BeeFlow#readme
################################################################################


################################################################################
###################### FLORAL PLANTINGS AND EFFECTS ############################
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

if(!require(tidyr)){
  install.packages("tidyr")
  library(tidyr)
}

if(!require(vegan)){
  install.packages("vegan")
  library(vegan)
}

if(!require(patchwork)){
  install.packages("patchwork")
  library(patchwork)
}

if(!require(digest)){
  install.packages("digest")
  library(digest)
}


################################################################################
# 1) Load and clean data
################################################################################

df <- read.csv2("../Data/floral planting and effect.csv", header = TRUE)

# Quick check
class(df)
str(df)
head(df)
tail(df)

# Clean whitespace from key columns
df <- df %>%
  mutate(
    RefCode       = trimws(RefCode),
    EffectType    = trimws(EffectType),
    Mix           = trimws(Mix),
    FlowerSpecies = trimws(FlowerSpecies)
  )

################################################################################
# 2) Build community matrix (presence/absence) by UnitID
################################################################################

# Builds a community matrix (presence/absence) from a data frame with
# unit_col + FlowerSpecies
make_comm <- function(x, unit_col = "UnitID") {
  comm <- x %>%
    mutate(presence = 1) %>%
    distinct(.data[[unit_col]], FlowerSpecies, .keep_all = TRUE) %>%
    pivot_wider(
      id_cols      = all_of(unit_col),
      names_from   = FlowerSpecies,
      values_from  = presence,
      values_fill  = 0
    ) %>%
    as.data.frame()
  
  # Ensure numeric and clean
  if (ncol(comm) > 1) {
    comm[, -1] <- lapply(comm[, -1], as.numeric)
    comm[is.na(comm)] <- 0
    comm <- comm[rowSums(comm[, -1]) > 0, , drop = FALSE]
  }
  
  comm
}

################################################################################
# 3) Define UnitID and create comm + meta tables
################################################################################

# Unit = Study–Mix–Effect (RefCode_Mix_EffectType)
df1 <- df %>%
  mutate(UnitID = paste(RefCode, Mix, EffectType, sep = "_"))

# Community matrix
comm1 <- make_comm(df1, unit_col = "UnitID")

# Metadata (EffectType per UnitID)
meta1 <- df1 %>%
  distinct(UnitID, EffectType)

# Align meta to comm order (defensive)
meta1 <- meta1[match(comm1$UnitID, meta1$UnitID), , drop = FALSE]

# Remove units with missing EffectType (defensive)
keep <- !is.na(meta1$EffectType)
comm1 <- comm1[keep, , drop = FALSE]
meta1 <- meta1[keep, , drop = FALSE]

################################################################################
# 4) Compute Jaccard dissimilarity matrix
################################################################################

dist_jac <- vegdist(comm1[, -1], method = "jaccard")
dm <- as.matrix(dist_jac)

################################################################################
# 5) Compute mean dissimilarity for each unit relative to others of same effect
################################################################################

avg_diss <- sapply(1:nrow(dm), function(i) {
  eff_i <- meta1$EffectType[i]
  same_eff <- which(meta1$EffectType == eff_i & seq_len(nrow(dm)) != i)
  
  if (length(same_eff) > 0) {
    mean(dm[i, same_eff])
  } else {
    NA  # if there is only one observation of that effect
  }
})

avg_df <- data.frame(
  EffectType         = meta1$EffectType,
  mean_dissimilarity = avg_diss
) %>%
  filter(!is.na(mean_dissimilarity)) %>%
  mutate(EffectType = 
           fct_relevel(EffectType, "exporter", "neutral", "concentrator"))

################################################################################
# 6) Statistical test among effect types (recommended)
################################################################################

kruskal_res <- kruskal.test(mean_dissimilarity ~ EffectType, data = avg_df)
print(kruskal_res)


kw_label <- paste0(
  "Kruskal–Wallis\n",
  "χ² = ", round(kruskal_res$statistic, 2),
  ", p = ", round(kruskal_res$p.value, 2)
)
################################################################################
# 7) Plot boxplot (Figure 5)
################################################################################


g <- ggplot(avg_df, aes(x = EffectType, y = mean_dissimilarity,
                        fill = EffectType)) +
  
  geom_violin(width = 0.9, alpha = 0.3, color = NA) +
  
  geom_boxplot(width = 0.25, alpha = 0.85, color = "black",
               outlier.shape = NA) +
  
  geom_jitter(width = 0.08, alpha = 0.7, size = 2) +
  
  scale_fill_manual(values = c(
    exporter     = "#8BC34A",
    neutral      = "#B0BEC5",
    concentrator = "#F48FB1"
  )) +
  
  labs(
    x = "Effect type",
    y = "Mean Jaccard dissimilarity\n(within same effect)"
  ) +
  
  theme_classic(base_size = 15) +
  
  theme(
    legend.position = "none",
    axis.text       = element_text(size = 14),
    axis.title.x    = element_text(size = 15, face = "bold",
                                   margin = margin(t = 15)),
    axis.title.y    = element_text(size = 15, face = "bold",
                                   margin = margin(r = 15))
  )

g <- g +
  annotate(
    "label",
    x = 3.6,
    y = 0.77,
    label = kw_label,
    size = 4.8,
    hjust = 1,
    fill = "white",
    color = "black",
    label.size = 0.5
  )

g <- g +
  scale_y_continuous(
    limits = c(0.75, 1.01),
    breaks = seq(0.75, 1.00, by = 0.05),
    expand = c(0, 0)
  )

print(g)

# Export the plot
png(filename = "../Figure/floral plantings and effects.png", 
    res = 300, height = 2500, width = 4000)
par(mfrow = c(1, 1), mar = c(5, 5, 5, 1), bg = "white")

print(g)

dev.off()


############################### THE END ########################################