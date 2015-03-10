##########################################################################
#
# Date: 01/14/2015
#
# Filename:    Temperature gradient analysis
# Description: This code will analyze errors induced in the range
#                output from an Aquatrak acoustic range sensor
#                in the presence of a thermal gradient. 
#                
#
#########################################################################

T = 17

tubeLength <- 8.965 #meters (range not subtracting offset)

thermistorSeparation <- tubeLength / 12

gradient <- 0.01 #in degC/m

# Finds the time of flight at constant t
# Take into account return path
ToF <- 2 * tubeLength / speedOfSound(20) 


# Finds the difference in ToF if there is a thermal gradient
gradientToF <- vector()
for(n in 1:10){
  
  gradientToF[n] <- 2 * thermistorSeparation / speedOfSound(T)
  T <- T + gradient
}

differenceTOF <- ToF - sum(gradientToF)
# Finds the difference in d traveled













#Just for shits and giggles
speedOfSound <-function(T) {
  
  T <- T + 273.15
  speedOfSound <- 20.05 * sqrt(T)
  
  return(speedOfSound)
}