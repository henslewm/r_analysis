#-----------------------------------------------------------------------
# Description: This file is the motherload. It's purpose is to house
#   all the custrom functions which I have written in a way that can 
#   be easily imported in R and utilized to solve other problems. 
# 
# How To: Use the 'source('winstonsFunctions.R') function to import
#   all of these sweet ass functions into the workspace. Please leave
#   a short example at the top of this file and include a more detailed
#   explanation of each function directly prior to including it in the
#   file.
#-----------------------------------------------------------------------


## Speed of sound in a real gas ##
# SoSCramerJASA(t = 20,Rh = 60, p = 101325, Xc = 0.000314, plot = FALSE) 




#-----------------------------------------------------------------------#
# Function: nextFunction
# This is the template for adding functions to this list. 

nextFunction = function(input=something)
{
  
}
#-----------------------------------------------------------------------#

#-----------------------------------------------------------------------#
# Function: SoSCramerJASA
# This function returns a sound speed in meters per second based on 
# parameters of a real gas, including temperature, humidity, barometric
# pressure and the CO2 concentration in the air.

SoSCramerJASA = function(
  t  = 20,          # Temperature in Celsius
  Rh = 60,          # Relative Humidity in percent
  p  = 101325,      # Atmospheric pressure in Pa
  Xc = 0.000314,    # CO2 mole fraction
  plot = FALSE
) {
  
  
  if ( min( t ) < 0 || max( t ) > 30 ) {
    stop( 'Valid temperature range is 0-30 C' )
  }
  if ( min( p ) < 75000 || max( p ) > 102000 ) {
    stop( 'Valid pressure range is 60000 - 110000 Pa' )
  }
  if ( Xc > 0.01 ) {
    stop( 'Valid CO2 mole fraction is less than 0.01' )
  }
  
  h    = Rh / 100   # Relative Humidity as fraction
  T    = t + 273.15 # Thermodynamic temperature
  tSqr = t^2
  
  # Coefficients TABLE III
  a0  =  331.5024
  a1  =  0.603055
  a2  = -0.000528
  a3  =  51.471935
  a4  =  0.1495874
  a5  = -0.000782
  a6  = -1.82E-7
  a7  =  3.73E-8
  a8  = -2.93E-10
  a9  = -85.20931
  a10 = -0.228525
  a11 =  5.91E-5
  a12 = -2.835149
  a13 = -2.15E-13
  a14 =  29.179762
  a15 =  0.000486
  
  # Xw : water vapor mole fraction from APPENDIX (Giacamo 1981)
  f = 1.00062 + 3.14E-8 * p + 5.6E-7 * tSqr
  
  psvArg = 1.2811805E-5 * T * T - 1.9509874E-2 * T +
    34.04926034 - 6.3536311E3 / T
  
  Psv = exp( psvArg )
  
  Xw = h * f * Psv / p
  
  if ( max( Xw ) > 0.06 ) {
    stop( 'Water vapor mole fraction too high' )
  }
  
  c =  a0 + a1  * t + a2  * tSqr       +
    (a3 + a4  * t + a5  * tSqr) * Xw +
    (a6 + a7  * t + a8  * tSqr) * p  +
    (a9 + a10 * t + a11 * tSqr) * Xc +
    a12 * Xw^2    +  a13 * p^2  +
    a15 * Xw * p * Xc
  
  
  if ( plot ) {
    if ( length( t ) > 1 ) {
      xVar = t
      xLabel = 'Temperature (C)'
    }
    else if ( length( Rh ) > 1 ) {
      xVar = Rh
      xLabel = 'Relative Humidity'
    }
    else {
      stop( 'Need t or Rh vector to plot' )
    }
    
    par ( mar = c( 3.8, 3.8, 1, 1 ) )
    par ( mgp = c( 2.5, 1, 0 ) )
    plot( x = xVar, y = c, type = 'l', lwd = 2,
          xlab = xLabel, ylab = 'Sound Speed (m/s)',
          cex.axis = 1.2, cex.lab = 1.2 )
    
    # Add the approximate dry air curve if t is a vector
    if ( length( t ) > 1 ) {
      legend( 'top', c('Cramer', 'Dry Air Approx', 'Dry Air Taylor Series'),
              lwd = 6, col = c('black','red','blue'), cex=1.2, bty = 'n' )
      mtext( paste('  Relative Humidity ', Rh, '%', sep=''), line=-2, adj=0 )
    }
  }
  
  invisible( data.frame( t, c ) )
}
#-----------------------------------------------------------------------#