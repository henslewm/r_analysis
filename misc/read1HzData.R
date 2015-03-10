#####################################################
#
# Date: 12/31/2014
#
# Function:    read1HzData(filename)
# Description: Read 1Hz Data from Sutron DCP and
#                output into an R structure
#
# Arguments: filename - full filename for log file C://
#            
# Output: Returns an R dataframe with sequential 
#         data and NA where data was not saved
#         in the timestamped 1Hz interval. Three
#         columns; timestamp,sensor,reading are returned
#
#####################################################

read1HzData <- function(filename)  {

  myData <- read.table(file = filename, header = FALSE, sep = "," 
                       ,col.names = c('Date','Time','Sensor','Value','','Quality'), 
                       skip = 2, strip.white = FALSE, blank.lines.skip = TRUE)
  

 #Generate simple plot 
  plot.ts(myData[, 4], main="Data from Sutron Log", 
          xlab="Time", ylab="(m)") #, xlim=c(startDate,stopDate))
  
 #Add outliers to Dataframe
 
  return(myData)
}


##############################################################
#
# Date: 01/12/2015
#
# Function:    findSigmaOutliers(myData, remove=N, sigma=3)
# Description: Read 1Hz Data from Sutron DCP and
#                output into an R structure
#
# Arguments: myData - Data frame created using read1HzData
#                        function
#            remove - Boolean to replace outliers with NA
#            sigma - Multiplier to establish boundaries for
#                      outlier determination
#            
# Output: Returns the indicies where outliers were found in 
#            the input dataframe.
#
##############################################################
findSigmaOutliers <-function(myData, remove=N, sigma=3){
  
  #Look for those outliers
  idxOut <- 1
  myOutliers <- vector()
  
  #Set up thresholds
  sigmaRange <- sd(mydata[,4], na.rm=FALSE) * sigma
  myDataMean <- mean(myData[,4]) 
  upperLimit <- myDataMean + sigmaRange
  lowerLimit <- myDataMean - sigmaRange
  
  for (idx in 1:length(myData[,4])) {
    if (myData[idx,4] > upperLimit || myData[idx,4] < lowerLimit){
      
      myOutliers[idxOut] <- idx
      idxOut <- idxOut+1
    }      
  }
  
  # Remove Outliers?
  if(remove=='Y'){
    myData[myOutliers, 4] <- NA
  }
  
  return(myOutliers)
}