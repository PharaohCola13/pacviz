#' Pac-Man Residual function
#'
#'This function will create a pac-man residual plot for for regression analysis. The data will run through a linear regression and plot the resulting factors of standard deviation against an arbitrary angular measurement.
#' @param x: domain of the data.
#					y: range of the data.
#					title: title of the plot.
# 				color1: Inner-most alternating color.
#					color2: Alternate alternating color.
#' @keywords regression visualization
#' @export
#' @examples
## Produces the Pac-Man Residual using the Yellow-White color scheme
#' pacman(x, y, "Yellow", "White")

pacman <- function(x,y,title, color1, color2){
	xmin 	<- min(x, na.rm=TRUE)
	xmax 	<- max(x, na.rm=TRUE)
	newx 	<- seq(xmin, xmax, length.out=length(x))

	model.0 <- lm(y~x, data=data.frame(x,y))
	start 	<- list(a=coef(model.0)[1], b=coef(model.0)[2])
	model 	<- nls(y~a+b*x, data=data.frame(x=x, y=y), start=start)

# residual quanities from the regression model
	residual 	<- abs(resid(model))
# sequence used for angular position
	t 			<- seq(40, 320, len=length(residual))
# Maximum radial distance
	rmax 		<- max(residual, na.rm=TRUE)
	rmin 		<- min(residual, na.rm=TRUE)
# 6 equal divisions
	divs 		<- seq(round(rmin, 0), round(rmax, 0), len=6)
	if(divs[6] == 0){
		par(oma=c(1,1,1,1), cex=0.9)
		divs 	<- seq(round(rmin, 1), round(rmax, 1), len=5)
		n = -2* divs[5]/10 * -0.45
	}else{
		par(oma=c(1,1,1,1), cex=0.9)
		n = divs[6]/10
	}
	if (divs[1] != 0){
# Plots the residual against an angular position
		polar.plot(0, rp.type="s",labels="", point.col="Red",
			radial.lim=c(0, divs[5]),show.grid=TRUE, show.grid.labels=FALSE,
			main=title, show.radial.grid=FALSE, grid.col="black")

		draw.circle(0, 0, radius=divs[5], col=color1)
		draw.circle(0, 0, radius=divs[4], col=color2)
		draw.circle(0, 0, radius=divs[3], col=color1)
		draw.circle(0, 0, radius=divs[2], col=color2)
		draw.circle(0, 0, radius=divs[1], col=color1)

		text(divs[1] - n - n/10, 0,  labels=bquote(.(divs[1])*sigma))
		text(divs[2] - n, 0,  labels=bquote(.(divs[2])*sigma))
		text(divs[3] - n, 0,  labels=bquote(.(divs[3])*sigma))
		text(divs[4] - n, 0,  labels=bquote(.(divs[4])*sigma))
		text(divs[5] - n, 0,  labels=bquote(.(divs[5])*sigma))

		polar.plot(c(0, divs[5]), c(min(t) - 10, min(t) - 10), lwd=1, rp.type="p",line.col="black", add=TRUE)
		polar.plot(c(0, divs[5]), c(max(t) + 10, max(t) + 10), lwd=1, rp.type="p",line.col="black", add=TRUE)
	}else{
# Plots the residual against an angular position
		polar.plot(0, rp.type="s",labels="", point.col="Red",
			radial.lim=c(0, divs[6]),show.grid=TRUE, show.grid.labels=FALSE,
			main=title, show.radial.grid=FALSE, grid.col="black")

		draw.circle(0, 0, radius=divs[6], col=color1)
		draw.circle(0, 0, radius=divs[5], col=color2)
		draw.circle(0, 0, radius=divs[4], col=color1)
		draw.circle(0, 0, radius=divs[3], col=color2)
		draw.circle(0, 0, radius=divs[2], col=color1)
		draw.circle(0, 0, radius=divs[1], col=color2)

		text(divs[2] - n, 0,  labels=bquote(.(divs[2])*sigma))
		text(divs[3] - n, 0,  labels=bquote(.(divs[3])*sigma))
		text(divs[4] - n, 0,  labels=bquote(.(divs[4])*sigma))
		text(divs[5] - n, 0,  labels=bquote(.(divs[5])*sigma))
		text(divs[6] - n, 0,  labels=bquote(.(divs[6])*sigma))

		polar.plot(c(0, divs[6]), c(min(t) - 10, min(t) - 10), lwd=1, rp.type="p",line.col="black", add=TRUE)
		polar.plot(c(0, divs[6]), c(max(t) + 10, max(t) + 10), lwd=1, rp.type="p",line.col="black", add=TRUE)
	}
	polar.plot(residual, t, rp.type="s",
		point.col="blue",point.symbols=16, add=TRUE)
}
