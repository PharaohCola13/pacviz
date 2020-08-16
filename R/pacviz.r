#' Pac-Man Residual Function
#'
#' This function will create a pac-man residual plot for for regression analysis. The data will run through a linear regression and plot the resulting factors of standard deviation the domain of the data.
#' @param x,y Numeric data
#' @param	title String
#' @param color1,color2 Color strings
#' @param unit String to define units on the angular axis
#' @param axis_label String to label angular axis
#' @return Pac-Man residual plot
#' @keywords regression visualization
#' @import plotrix circlize
#' @importFrom graphics par text
#' @importFrom stats coef lm nls resid predict sigma
#' @examples
#' x <- rnorm(20, mean=0, sd=10)
#' y <- log(rnorm(20, mean=0, sd=10), base=exp(1))
#' pacviz(x,y,"Title","units", "Axis Label")
#' @export
pacviz <- function(x,y,title, unit, axis_label, model=lm(y~x, data=data.frame(x,y)), color1="Yellow", color2="White", standardize=FALSE){
	# Revert margin settings back to default after exit
	oldpar <- par(mar=par()$mar, oma=par()$oma)
	on.exit(par(oldpar))

	# residual quanities from the regression model
	if (standardize == TRUE){residual <- abs(rstandard(model))}
	else{residual 	<- abs(resid(model))}
	# sequence used for angular position
	t 			<- (x - min(x))/max(x-min(x)) * (40 - 320) + 320

	# Angular axis label positions
	lp = seq.int(40, 320, length.out=6)
	# Angular axis labels
	ln = rev(seq.int(round(min(x, na.rm=TRUE),1), round(max(x, na.rm=TRUE),1), length.out=6))

	# Maximum radial distance
	rmax 		<- max(residual, na.rm=TRUE)
	rmin 		<- min(residual, na.rm=TRUE)
	# 6 equal divisions
	divs 		<- seq(floor(rmin), ceiling(rmax), len=6)
	n 			<- divs[6]/10

	# Plots the residual against an angular position
	par(oma=c(0,0,3,0), cex=0.9)
	polar.plot(0,labels="", radial.lim=c(0, divs[6]), show.grid=FALSE, show.grid.labels=FALSE, show.radial.grid=FALSE)
	title(paste("\n\n", title, sep=""), outer=TRUE)
	# Generates 'tick marks' for angular axis
	for (i in lp){
		polar.plot(c(0, divs[6]+n/2), c(i,i), lwd=1, rp.type="p",line.col="Black", add=TRUE)
	}
	# Generates angular labels (w/ units) and axis title
	for (i in 1:6){
		if (is.element(i, 1:3)){
			arctext(paste(round(ln[i], 1), unit, sep=" "), middle=(lp[i] * pi) / (180), radius=divs[6]+n, clockwise=TRUE)
		}else if (is.element(i, 4:6)){
			arctext(paste(round(ln[i],1), unit, sep=" "), middle=(lp[i] * pi) / (180), radius=divs[6]+n, clockwise=FALSE)
		}
	}
	arctext(axis_label, middle=0, radius=divs[6]+n, clockwise=TRUE)

	# Draws the circles and the labels
	for (i in 6:1){
		if ((i %% 2) == 0){color <- color1}else{color <- color2}
		draw.circle(0,0, radius=divs[i], col=color)
		text(divs[i+1] - n, 0,  labels=bquote(.(divs[i+1])*sigma))
	}
	# Draws the label space
	polar.plot(c(0, divs[6]), c(min(t), min(t)), lwd=1, rp.type="p",line.col="black", add=TRUE)
	polar.plot(c(0, divs[6]), c(max(t), max(t)), lwd=1, rp.type="p",line.col="black", add=TRUE)
	# Representation of the residual standard deivation
	draw.sector(start.degree=320, end.degree=40, rou1=sigma(model), rou2=sigma(model), lty="dashed")
	# Plots the data
	polar.plot(residual, t, rp.type="s", point.col="black", point.symbols=16, radial.lim=c(0, divs[6]), add=TRUE)
}
