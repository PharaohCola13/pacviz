#' @title Pac-Man SVM
#'
#' @description A visualization technique in R for regression analysis results, specifically residual values, based on a restricted
#' radial coordinate system. It provides a broad view perspective on the performance of regression models, and supports
#' most model inputs. See the pacviz documentation page for more information: https://pharaohcola13.github.io/pacviz/book/
#' @param x,y Numeric data
#' @param title Figure title
#' @param xaxislabel Angular axis label
#' @param yaxislabel Radial axis label
#' @param xunits String to define units on the angular axis (For temperature measurements use 'degC' or 'degF')
#' @param yunits String to define units on the radial axis (For temperature measurements use 'degC' or 'degF')
#' @param color1 Color value as string or rgb
#' @return Pac-Man SVM
#' @keywords machine-learning visualization
#' @import plotrix circlize
#' @importFrom graphics par text mtext rect abline plot
#' @importFrom stats coef lm nls resid predict sigma rstandard median
#' @importFrom utils packageDescription
#' @examples
#' # Generic Pac-Man residual
#' data("cars")
#' pac.plot(cars$dist,cars$speed, 'Example 1', "Distance", "Speed", 'm', 'm/s')
#' @export
pac.plot <- function(x,y, title, xaxislabel, yaxislabel, xunits, yunits, color1 = "gold") {

  t <- linMap(x, 40, 320)
  r <- linMap(y, 1, 0)

  # Angular axis label positions
  lp = seq.int(40, 320, length.out = 6)
  # Angular axis labels
  ln = rev(seq.int(round(min(x, na.rm = TRUE), 1), round(max(x, na.rm = TRUE),1), length.out = 6))

  rmax <- max(c(r), na.rm = TRUE)
  rmin <- min(c(r), na.rm = TRUE)
  # 6 equal divisions
  divl  <- seq(floor(min(c(y), na.rm = TRUE)), ceiling(max(c(y), na.rm = TRUE)), len = 4)
  divs  <- seq(floor(min(c(abs(r)), na.rm = TRUE)), ceiling(max(c(abs(r)), na.rm = TRUE)), len = 4)

  n     <- abs(divs[4]/10)
  # Plots the residual against an angular position
  par(oma = c(0, 0, 3, 0), cex = 0.9)
  polar.plot(0, labels = "", radial.lim = c(0, divs[4]), show.grid = FALSE, show.grid.labels = FALSE,show.radial.grid = FALSE)
  title(paste("\n\n", title, sep = ""), outer = TRUE)
  # Generates 'tick marks' for angular axis
  for (i in lp) {
      polar.plot(c(0, divs[4] + n/2), c(i, i), lwd = 1, rp.type = "p", line.col = "Black",add = TRUE)
  }
  # Generates angular labels (w/ units) and axis title
  for (i in 1:6) {
      text <- paste(sprintf("%.2f", round(ln[i], 1)), xunits, sep="")
      if (is.element(i, 1:3)) {
          arctext(text, middle = (lp[i] * pi)/(180), radius = divs[4] + n, clockwise = TRUE)
      } else if (is.element(i, 4:6)) {
          arctext(text, middle = (lp[i] * pi)/(180), radius = divs[4] + n, clockwise = FALSE)
      }
  }
  arctext(xaxislabel, middle = 0, radius = divs[4] + n, clockwise = TRUE)

  for (i in 4:1) {
      if ((i%%2) == 0) {
          color <- "gold"
      } else {
          color <- "White"
      }
      draw.circle(0, 0, radius = abs(divs[i]), col = color)
      rlab <- mean(c(abs(divs[i + 1]), abs(divs[i])))
      text(rlab, 0, srt=0, labels = bquote(.(round(divl[i + 1], 2)) * .(yunits)))
    }
  # print(par("usr")[1] + 0.05 * diff(par("usr")[1:2]))
  text(x=divs[median(4:1) + 1] - (1.5*n) , labels = yaxislabel, srt = 45)
  polar.plot(c(0, divs[4]), c(40, 40), lwd = 1, rp.type = "l", line.col = "black",
        radial.lim = c(0, divs[4]), add = TRUE)
  polar.plot(c(0, divs[4]), c(320,320), lwd = 1, rp.type = "l", line.col = "black",
          radial.lim = c(0, divs[4]), add = TRUE)
  polar.plot(r,t, rp.type = "s", point.col="black", add=TRUE)
}
#
# library(plotrix)
# data("cars")
# x <- rnorm(20, mean=0, sd=10)
# y <- rnorm(20, mean=0, sd=10)
# plot(cars$dist, cars$speed)
# abline(h=12.5)
# abline(h=16.67)
# abline(h=25.0)
# pac.plot(cars$dist,cars$speed, 'Example 1', "Distance", "Speed", 'm', 'm/s')
# plot(x,y)
# pac.plot(x,y, 'Example 1', "xaxislabel", "yaxislabel", 'm', 'm/s')
