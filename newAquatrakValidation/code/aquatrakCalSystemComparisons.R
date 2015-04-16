###################################################################################
# Filename: aquatrakCalSystemComparison.R
# Author: Winston Hensley
# Date:   03/30/2015
#
# Description: To aid in the comparison of the new Aquatrak calibration system in
#     Chesapeake, VA multiple tests are included in this file, generating summary
#     statistics and plots outlining differences and distributions.
###################################################################################

# Preliminary data as of 03/30/2015. Should work until the full data set is available
# offset data is the differences between new-legacy offset values. By showing the
# distributions of the 
# offsetData <- c(-0.0011,-0.0001,-0.0021,-0.0031,-0.0017,-0.0017,
#                 -0.0024,-0.0006,-0.0002)
offsetData <- read.csv("U:/Winston.Hensley/Documents/Aquatrak/Aquatrak Cal Hardware/Validation/NewValidationData.csv")

# # Show histogram of demeaned offset values in mm for all 14 trials.
# hist(chesOffsets_Res_demeaned,breaks=7,main="Sensor 1117-3384 Offset Values",
#      xlab="Demeaned Offsets(mm)")

hist(offsetData$Offset.Difference, main="Calibrated Offset Difference (m)",
     xlab="New Offset Minus Legacy Offset")










# OLD
# chesapeakeOffsets_Res is a single sensor's offsets when calibrated by the
# legacy Chesapeake cal system 15 times sequentially. 
# chesOffsets_Res <- c(-0.1025, -0.1003, -0.1035, -0.1017, -0.1013,
#                            -0.1030, -0.1038, -0.1028, -0.1030, -0.1028,
#                            -0.1018, -0.1017, -0.1013, -0.1011)
# 
# chesOffsets_Res_demeaned <- 1000*(chesOffsets_Res - mean(chesOffsets_Res))
