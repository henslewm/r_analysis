rm(list<-ls())

log051046 <- read.table("U:/Winston.Hensley/Documents/LabVIEW Data/Aquatrak Data/Legacy Archive/raw/log051046.txt", quote="\"")

range <- log051046["V2"]

range <- range[4:45457,]

longIdx <- which(range > 8)

longRanges <- range[c(longIdx)]

upperLimitIdx <- which(longRanges > median(longRanges) + sd(longRanges)*1)

lowerLimitIdx <- which(longRanges < median(longRanges) - sd(longRanges)*1)

cutLongRanges <- longRanges[-c(upperLimitIdx,lowerLimitIdx)]

hist(cutLongRanges)

sd(cutLongRanges)
