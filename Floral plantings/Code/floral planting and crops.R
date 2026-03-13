################################################################################
#### Ecological Synthesis Lab (SintECO): https://marcomellolab.wordpress.com

#### Authors: Cristina A. Kita, Isabel Alves-dos-Santos, Michael Hrncir, 
#### & Marco A. R. Mello

#### See README for further info:
#### https://github.com/CKita/BeeFlow#readme
################################################################################


################################################################################
###################### FLORAL PLANTINGS AND CROPS ##############################
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

# -------------------------
# 1) Read and clean the data
# -------------------------
# IMPORTANT: If you had UTF-8 issues, try fileEncoding = "latin1" or 
# "Windows-1252"
dfc <- read.csv2("../Data/floral planting and crops.csv",
                 header = TRUE,
                 fileEncoding = "latin1")

# Basic checks
class(dfc)
str(dfc)
head(dfc)
tail(dfc)

# Trim whitespace in key text columns
dfc <- dfc %>%
  mutate(
    RefCode       = trimws(RefCode),
    CropType      = trimws(CropType),
    Mix           = trimws(Mix),
    FlowerSpecies = trimws(FlowerSpecies)
  )

# ---------------------------------------------
# 2) Build community matrix (presence/absence)
# ---------------------------------------------
# Creates a community matrix (UnitID x FlowerSpecies) with 0/1 values
make_comm <- function(x, unit_col = "UnitID") {
  comm <- x %>%
    mutate(presence = 1) %>%
    distinct(.data[[unit_col]], FlowerSpecies, .keep_all = TRUE) %>%
    pivot_wider(
      id_cols     = all_of(unit_col),
      names_from  = FlowerSpecies,
      values_from = presence,
      values_fill = 0
    ) %>%
    as.data.frame()
  
  # Ensure numeric and remove empty rows
  if (ncol(comm) > 1) {
    comm[, -1] <- lapply(comm[, -1], function(z) as.numeric(as.character(z)))
    comm[is.na(comm)] <- 0
    comm <- comm[rowSums(comm[, -1]) > 0, , drop = FALSE]
  }
  comm
}

# ---------------------------------------------------------
# 3) Compute within/between pairs based on CROP TYPE
# --------------------------------------------------------
make_pairs_within_between_crop <- function(comm, meta, unit_col = "UnitID") {
  
  # Align meta to comm order
  meta <- meta[match(comm[[unit_col]], meta[[unit_col]]), , drop = FALSE]
  stopifnot(nrow(meta) == nrow(comm))
  
  # Jaccard dissimilarity
  dist_jac <- vegdist(comm[, -1], method = "jaccard")
  dm <- as.matrix(dist_jac)
  n <- nrow(dm)
  
  # Build pairwise dataframe
  pairs_df <- do.call(rbind, lapply(1:(n - 1), function(i) {
    j <- (i + 1):n
    data.frame(
      dissimilarity = dm[i, j],
      crop_i = meta$CropType[i],
      crop_j = meta$CropType[j]
    )
  })) %>%
    mutate(pair_type = ifelse(crop_i == crop_j, "within", "between")) %>%
    filter(is.finite(dissimilarity)) %>%
    mutate(pair_type = fct_relevel(pair_type, "within", "between"))
  
  pairs_df
}

# -------------------------
# 4) Violin plot function
# -------------------------
plot_violin <- function(pairs_df, subtitle = NULL, pval = NULL) {
  
  means_df <- pairs_df %>%
    group_by(pair_type) %>%
    summarise(m = mean(dissimilarity), .groups = "drop")
  
  # Position for bracket and text
  y_max <- max(pairs_df$dissimilarity, na.rm = TRUE)
  y_bracket <- y_max + 0.03
  y_text    <- y_max + 0.05
  y_top     <- y_text + 0.02
  
  # p-value 
  p_txt <- NULL
  if (!is.null(pval)) {
    if (pval < 0.001) {
      p_txt <- "p < 0.001"
    } else {
      p_txt <- paste0("p = ", formatC(pval, digits = 3, format = "f"))
    }
  }
  
  p <- ggplot(pairs_df, aes(x = pair_type, y = dissimilarity,
                            fill = pair_type)) +
    geom_violin(trim = FALSE, alpha = 0.85, color = "gray50",
                scale = "width", adjust = 0.9) +
    geom_boxplot(width = 0.18, outlier.shape = NA, alpha = 0.75, 
                 color = "gray40") +
    stat_summary(fun = mean, geom = "point", size = 3.8, color = "white") +
    scale_fill_manual(values = c(within = "#7B68EE", between = "#FFD166")) +
    labs(x = NULL, y = "Jaccard dissimilarity", subtitle = subtitle) +
    theme_minimal(base_size = 16) +
    theme(
      legend.position  = "none",
      panel.grid.minor = element_blank(),
      axis.text.x      = element_text(size = 16),
      axis.text.y      = element_text(size = 16),
      axis.title.y     = element_text(size = 16, face = "bold", 
                                      margin = margin(r = 10))
    ) +
    geom_text(
      data = means_df,
      aes(x = as.numeric(pair_type) + 0.04, y = m, 
          label = sprintf("mean = %.2f", m)),
      inherit.aes = FALSE, size = 4.8, hjust = 0
    ) +
    coord_cartesian(ylim = c(0, y_top), clip = "off")
  
  # Add bracket + p-value
   if (!is.null(p_txt)) {
    p <- p +
      annotate("segment", x = 1, xend = 2, y = y_bracket, yend = y_bracket,
               linewidth = 0.6) +
      annotate("segment", x = 1, xend = 1, y = y_bracket, 
               yend = y_bracket - 0.02, linewidth = 0.6) +
      annotate("segment", x = 2, xend = 2, y = y_bracket,
               yend = y_bracket - 0.02, linewidth = 0.6) +
      annotate("text", x = 1.5, y = y_text, label = p_txt, size = 5)
  }
  
  return(p)
}

# ------------------------------------------------------------
# 5) Define the sampling unit and run the analysis
# ------------------------------------------------------------
# Use Study–Mix as the sampling unit (UnitID)
df1 <- dfc %>%
  mutate(UnitID = paste(RefCode, Mix, sep = "_"))

# Community matrix
comm1 <- make_comm(df1, "UnitID")

# Metadata: UnitID + CropType
meta1 <- df1 %>%
  distinct(UnitID, CropType)

# Align and remove missing CropType (defensive)
meta1 <- meta1[match(comm1$UnitID, meta1$UnitID), , drop = FALSE]
keep <- !is.na(meta1$CropType)
comm1 <- comm1[keep, , drop = FALSE]
meta1 <- meta1[keep, , drop = FALSE]

# Pairwise dissimilarities within vs between crop types
pairs1 <- make_pairs_within_between_crop(comm1, meta1, "UnitID")

# ------------------------------------------------------------
# 6) Statistical test: within vs between crop types
# ------------------------------------------------------------
wilcox_res <- wilcox.test(dissimilarity ~ pair_type, data = pairs1, 
                          exact = FALSE)
wilcox_res

# Optional: store p-value
pval <- wilcox_res$p.value
pval

# ------------------------------------------------------------
# 7) Plot
# ------------------------------------------------------------
p1 <- plot_violin(pairs1,  pval = pval)
p1

# Export the plot
png(filename = "../Figure/floral plantings and crops.png", 
    res = 300, height = 2500, width = 4000)
par(mfrow = c(1, 1), mar = c(5, 5, 5, 1), bg = "white")

print(p1)

dev.off()
