# Title     : Pac-Man Residual test
# Created by: PharaohCola13
# Created on: 6/2/19

suppressPackageStartupMessages(library(pacviz))
# Generic Pac-Man residual
x <- rnorm(20, mean=0, sd=10)
y <- log(rnorm(20, mean=0, sd=10), base=exp(1))

pdf("./figures/fig1.pdf")
pacman(x,y,'Example 1','N/m', 'Axis Label')

# Pac-Man residual using alternate color, residual standardization, and temperature units
pdf("./figures/fig2.pdf")
pacman(x,y, 'Example 2', 'degC', "Temperature", color1="lightskyblue", standardize=TRUE)

# Pac-Man residual using alternate color, a quadratic model, and a UTF8 character for units
pdf("./figures/fig3.pdf")
pacman(x,y, 'Example 3', "\uc5", "Distance", model=lm(y~poly(x,2)), color1="darksalmon")

# Pac-Man residual using alternate color, with unitless values, and empty axis label
# pdf("./figures/fig4.pdf")
# pacman(x,y, 'Example 4', paste(NULL, " "), " ", color="palegreen")
