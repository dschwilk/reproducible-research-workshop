## clean-bnames.r
## -------------------
## 2015-04-22
## Dylan Schwilk

## This script downloads and cleans up morphological data from Galapagos
## finches, which is available from BIRDD: Beagle Investigation Return with
## Darwinian Data at http://bioquest.org/birdd/morph.php

library(ggplot2)

### Clean up data:
##################
birdd <- read.csv("http://bioquest.org/birdd/Morph_for_Sato.txt",
                  sep="\t", stringsAsFactors=FALSE)

names(birdd) <- tolower(names(birdd)) # make columns names lowercase
birdd <- subset(birdd, islandid == "Flor_Chrl") # take only one island
# only keep these columns:
birdd <- birdd[,c("islandid", "taxonorig", "sex", "wingl", "beakh", "ubeakl")]
names(birdd)[1:2] <- c("island", "taxon")
birdd <- data.frame(na.omit(birdd)) # remove all rows with any NAs
birdd$sex <- factor(birdd$sex) # remove extra remaining factor levels
row.names(birdd) <- NULL # tidy up the row names

# Quick look at wingl:
ggplot(birdd, aes(taxon, wingl)) + geom_boxplot() + coord_flip()

# hm, anything wrong?
