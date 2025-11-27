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


# First, let's look at our dataset
df <- read.csv2("../Data/floral planting and effect.csv", header = TRUE)
class(df)
str(df)
head(df)
tail(df)

# Clean whitespace from all key text columns
df <- df %>%
  mutate(
    RefCode = trimws(RefCode),
    EffectType = trimws(EffectType),
    Mix = trimws(Mix),
    FlowerSpecies = trimws(FlowerSpecies)
  )

# Builds a community matrix (presence/absence) from a data frame with 
# UnitID + FlowerSpecies

make_comm <- function(x, unit_col = "UnitID") {
  comm <- x %>%
    mutate(presence = 1) %>%
    distinct(.data[[unit_col]], FlowerSpecies, .keep_all = TRUE) %>%
    pivot_wider(
      id_cols    = all_of(unit_col),
      names_from = FlowerSpecies,
      values_from = presence,
      values_fill = 0
    ) %>%
    as.data.frame()
  # ensure numeric and clean
  if (ncol(comm) > 1) {
    comm[ , -1] <- lapply(comm[ , -1], function(z) as.numeric(as.character(z)))
    comm[is.na(comm)] <- 0
    comm <- comm[rowSums(comm[ , -1]) > 0, , drop = FALSE]
  }
  comm
}

# From comm + meta(EffectType), compute within/between pairs and return 
#data.frame for violin plot

make_pairs_within_between <- function(comm, meta, unit_col = "UnitID") {
  # align meta to the order of comm
  meta <- meta[match(comm[[unit_col]], meta[[unit_col]]), , drop = FALSE]
  stopifnot(nrow(meta) == nrow(comm))
  # dissimilarity
  dist_jac <- vegdist(comm[ , -1], method = "jaccard")
  dm <- as.matrix(dist_jac)
  n <- nrow(dm)
  pairs_df <- do.call(rbind, lapply(1:(n-1), function(i) {
    j <- (i+1):n
    data.frame(
      dissimilarity = dm[i, j],
      eff_i = meta$EffectType[i],
      eff_j = meta$EffectType[j]
    )
  })) %>%
    mutate(pair_type = ifelse(eff_i == eff_j, "within", "between")) %>%
    filter(is.finite(dissimilarity)) %>%
    mutate(pair_type = fct_relevel(pair_type, "within", "between"))
  pairs_df
}

# Build a standardized violin plot and returns the ggplot object
plot_violin <- function(pairs_df, subtitle = NULL) {
  means_df <- pairs_df %>%
    group_by(pair_type) %>%
    summarise(m = mean(dissimilarity), .groups = "drop")
  
  ggplot(pairs_df, aes(x = pair_type, y = dissimilarity, fill = pair_type)) +
    geom_violin(trim = FALSE, alpha = 0.85, color = "gray50", adjust = 1.2) +
    geom_boxplot(width = 0.18, outlier.shape = NA, 
                 alpha = 0.75, color = "gray40") +
    stat_summary(fun = mean, geom = "point", size = 3.8, color = "white") +
    scale_fill_manual(values = c(within = "#7B68EE", between = "#FFD166")) +
    labs(x = NULL, y = "Jaccard dissimilarity", subtitle = subtitle) +
    theme_minimal(base_size = 12) +
    theme(
      legend.position   = "none",
      panel.grid.minor  = element_blank(),
      axis.text.x       = element_text(size = 12),
      axis.text.y       = element_text(size = 12),
      axis.title.y      = element_text(size = 14, face = "bold",
                                       margin = margin(r = 10))
    ) +
    # label of the mean next to the point
    geom_text(
      data = means_df,
      aes(x = as.numeric(pair_type) + 0.04, y = m,
          label = sprintf("mean = %.2f", m)),
      inherit.aes = FALSE, size = 3.5, hjust = 0
    ) +
    coord_cartesian(ylim = c(0, 1), clip = "off")
}

# BASELINE: unit = Study–Mix–Effect (RefCode_Mix_EffectType) ===
df1 <- df %>%
  mutate(UnitID = paste(RefCode, Mix, EffectType, sep = "_"))

comm1 <- make_comm(df1, "UnitID")
meta1 <- df1 %>%
  distinct(UnitID, EffectType)

# remove units without EffectType (rare) and align (defensive)
meta1 <- meta1[match(comm1$UnitID, meta1$UnitID), , drop = FALSE]
keep <- !is.na(meta1$EffectType)
comm1 <- comm1[keep, , drop = FALSE]
meta1 <- meta1[keep, , drop = FALSE]

pairs1 <- make_pairs_within_between(comm1, meta1, "UnitID")
p1 <- plot_violin(pairs1, subtitle = "Baseline: Study–Mix–Effect")

p1

# (1) Reuse the matrices from the previous analysis ---
# comm1 = presence/absence matrix by UnitID (Study–Mix–Effect)
# meta1 = table with UnitID and EffectType
# If you have closed R, just reload your spreadsheet and redo the steps up to 
# comm1/meta1

# Compute the dissimilarity matrix (Jaccard)
dist_jac <- vegdist(comm1[ , -1], method = "jaccard")
dm <- as.matrix(dist_jac)

# (2) Compute mean dissimilarity for each unit relative to others of the 
# same effect
avg_diss <- sapply(1:nrow(dm), function(i) {
  eff_i <- meta1$EffectType[i]
  same_eff <- which(meta1$EffectType == eff_i & 1:nrow(dm) != i)
  if (length(same_eff) > 0) {
    mean(dm[i, same_eff])
  } else {
    NA  # if there is only one observation of that effect
  }
})

# Create final dataframe for the plot
avg_df <- data.frame(
  EffectType         = meta1$EffectType,
  mean_dissimilarity = avg_diss
) %>%
  filter(!is.na(mean_dissimilarity)) %>%
  mutate(EffectType = 
           fct_relevel(EffectType, "exporter", "neutral", "concentrator"))

# --- (3) Plot boxplot ---
g <- ggplot(avg_df, aes(x = EffectType, y = mean_dissimilarity, 
                        fill = EffectType)) +
  geom_boxplot(width = 0.5, alpha = 0.8, color = "gray40") +
  geom_jitter(width = 0.1, alpha = 0.6, size = 2) +
  scale_fill_manual(values = c(
    exporter     = "#8BC34A",
    neutral      = "#B0BEC5",
    concentrator = "#F48FB1"
  )) +
  labs(
    x = "Effect type",
    y = "Mean Jaccard dissimilarity\n(within same effect)"
  ) +
  theme_minimal(base_size = 14) +
  theme(
    legend.position = "none",
    axis.text       = element_text(size = 14),
    axis.title.x    = element_text(size = 14, face = "bold", 
                                   margin = margin(t = 20)),
    axis.title.y    = element_text(size = 14, face = "bold",
                                   margin = margin(r = 20))
  )

g

# Export the plot
png(filename = "../Figure/floral plantings and effects.png", 
    res = 300, height = 2500, width = 4000)
par(mfrow = c(1, 1), mar = c(5, 5, 5, 1), bg = "white")

print(g)

dev.off()

############################### THE END ########################################


