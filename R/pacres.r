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
#' pacres(x,y,"\u00B0C", "unit", "Title")
#' @export
pacres <- function(x,y,title, unit, axis_label, color1="Yellow", color2="White"){
# Finds and removes NaNed values from the dataset
	nans <- c(grep("NaN", y)); nans <- append(nans, grep("NaN", x))
	x <- x[-(nans)]; y <- y[-(nans)]

	linMap <- function(x, xi, xf) {(x - min(x))/max(x-min(x)) * (xi - xf) + xf}
	deg2rad <- function(deg) {(deg * pi) / (180)}

# Linear Regression operations
	model.0 <- lm(y~x, data=data.frame(x,y))
	start 	<- list(a=coef(model.0)[1], b=coef(model.0)[2])
	model 	<- nls(y~a+b*x, data=data.frame(x=x, y=y), start=start)

	# residual quanities from the regression model
	residual 	<- abs(resid(model))
# sequence used for angular position
	t 			<- linMap(x, 40, 320)

	lp = seq.int(40, 320, length.out=5)
	ln = rev(seq.int(round(min(x, na.rm=TRUE),-1), round(max(x, na.rm=TRUE),-1), length.out=5))

# Maximum radial distance
	rmax 		<- max(residual, na.rm=TRUE)
	rmin 		<- min(residual, na.rm=TRUE)
# 6 equal divisions
	divs 		<- seq(floor(rmin), ceiling(rmax), len=6)
	n 			<- divs[6]/10
# Plots the residual against an angular position
	par(oma=c(1,1,1,1), cex=0.9)
	polar.plot(0,labels="", radial.lim=c(0, divs[6]), main=title,show.grid=FALSE, show.grid.labels=FALSE, show.radial.grid=FALSE)
# Generates 'tick marks' for angular axis
	for (i in lp){
		polar.plot(c(0, divs[6]+n/2), c(i,i), lwd=1, rp.type="p",line.col="Black", add=TRUE)
	}
# Generates angular labels (w/ units) and axis title
	for (i in 1:5){
		if (is.element(i, 1:2)){
			arctext(paste(ln[i], unit, sep=""), middle=deg2rad(lp[i]), radius=divs[6]+n, clockwise=TRUE)
		}else if (is.element(i, 4:5)){
			arctext(paste(ln[i], unit, sep=""), middle=deg2rad(lp[i]), radius=divs[6]+n, clockwise=FALSE)
		}else{
			text(-divs[6]-(n*1.5), 0, labels=paste(ln[3], unit, sep=""))
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
	polar.plot(c(0, divs[6]), c(min(t) - 10, min(t) - 10), lwd=1, rp.type="p",line.col="black", add=TRUE)
	polar.plot(c(0, divs[6]), c(max(t) + 10, max(t) + 10), lwd=1, rp.type="p",line.col="black", add=TRUE)
# Representation of the residual standard deivation
	draw.sector(start.degree=330, end.degree=30, rou1=sigma(model), rou2=sigma(model))
# Plots the data
	polar.plot(residual, t, rp.type="s", point.col="blue", point.symbols=16,add=TRUE)
}
