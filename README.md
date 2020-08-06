# pacres
<img src='https://upload.wikimedia.org/wikipedia/commons/thumb/4/49/Pacman.svg/972px-Pacman.svg.png' width='100'/>
Pac-Man Residual Plot Package for R

## Description
This function will create a Pac-Man residual plot for for regression analysis. The data will run through a linear regression and plot the resulting factors of standard deviation against an arbitrary angular measurement.
## Parameters
- x: Domain of the data
- y: Range of the data
- title: title of the plot.
- color1: Inner-most alternating color.
- color2: Alternate alternating color.

## Examples
```
# Produces the Pac-Man Residual using the Yellow-White color scheme
pacres(rnorm(20, mean=0, sd=1),exp(rnorm(20, mean=0, sd=1)),"Package_Test", "Yellow", "White")
```
<img src="https://i.ibb.co/f47qPyj/Rplots-1.png" width='500' style='display: block; margin-left: auto; margin-right: auto;'/>
