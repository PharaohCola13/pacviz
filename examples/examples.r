# Title     : Pac-Man Residual test
# Created by: PharaohCola13
# Created on: 6/2/19

suppressPackageStartupMessages(library(pacviz))
data("cars")

# Generic Pac-Man residual
pdf("examples/figures/fig1.pdf")
pacman(cars$dist,cars$speed,
            'Example 1',
            'm/s',
            'Axis Label')

# Pac-Man residual using alternate color, residual standardization, and temperature units
pdf("examples/figures/fig2.pdf")
pacman(cars$dist,cars$speed, 'Example 2',
            'degC',
            "Temperature",
            color1="lightblue",
            standardize=TRUE)
# Pac-Man residual using alternate color, a quadratic model, and a UTF8 character for units
pdf("examples/figures/fig3.pdf")
pacviz::pacman(cars$dist,cars$speed, 'Example 3',
            "\uc5",
            "Distance",
            model=lm(cars$speed~poly(cars$dist,2)),
            color1="darksalmon")
# Pac-Man residual using alternate color, with unitless values, and empty axis label
# pdf("./figures/fig4.pdf")
# pacman(x,y, 'Example 4', paste(NULL, " "), " ", color="palegreen")
