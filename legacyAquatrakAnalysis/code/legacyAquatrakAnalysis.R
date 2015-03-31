########################################################################
# Author:       Winston Hensley
# Filename:     legacyAquatrakValidation.R
# Description:  Read in legacy Aqutrak data for exploratory data analysis
# 
########################################################################

# Clear the workspace
rm(list=ls())

# Load data from table
log051046 <- read.table("U:/Winston.Hensley/Documents/LabVIEW Data/Aquatrak Data/Legacy Archive/raw/log051046.txt", quote="\"")

range <- log051046["V2"]

range <- range[4:45457,]

longIdx <- which(range > 8)

longRanges <- range[c(longIdx)]

# Generate outlier ranges
#upperLimitIdx <- which(longRanges > median(longRanges) + 0.005)
#lowerLimitIdx <- which(longRanges < median(longRanges) - 0.005)

# Cut data to remove outliers
#cutLongRanges <- longRanges[-c(upperLimitIdx,lowerLimitIdx)]

hist(longRanges, breaks=200, xlim=c(8.94,8.98))

