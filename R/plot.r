#' @title Pac-Man SVM
#'
#' @description A
#' @param x,y Numeric data
#' @param title Figure title
#' @param taxis,raxis Vector with the first entry being the axis label and the second entry being units
#' @param color1 Color value as string or rgb
#' @return Pac-Man SVM
#' @keywords visualization
#' @import plotrix circlize
#' @importFrom graphics par text mtext rect abline plot
#' @importFrom stats coef lm nls resid predict sigma rstandard median
#' @examples
#' # Generic Pac-Man residual
#' data("cars")
#' pac.plot(cars$dist,cars$speed, 'Example 1', c("Distance", "m"), c("Speed", "m/s"))
#' @export
pac.plot <- function(x,y, title, taxis, raxis, color1 = "gold") {
  # Revert margin settings back to default after exit
  oldpar <- par(mar = par()$mar, oma = par()$oma)
  on.exit(par(oldpar))

  # Maping function for the angular axis
  t <- linMap(x, 40, 320)
  # Mapping function for the radial axis
  r <- linMap(y, 1, 0)
  # gets formatted units for the angular axis
  tunit <- unit_format(taxis[2])

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
      text <- sprintf("%.2f", round(ln[i], 1))
      if (is.element(i, 1:3)) {
          arctext(text, middle = (lp[i] * pi)/(180), radius = divs[4] + n, clockwise = TRUE)
      } else if (is.element(i, 4:6)) {
          arctext(text, middle = (lp[i] * pi)/(180), radius = divs[4] + n, clockwise = FALSE)
      }
  }
  arctext(paste(taxis[1], paste(tunit$unit, "]", sep=""), sep=" ["), middle = 0, radius = divs[4] + n, clockwise = TRUE)

  for (i in 4:1) {
      if ((i%%2) == 0) {
          color <- "gold"
      } else {
          color <- "White"
      }
      draw.circle(0, 0, radius = abs(divs[i]), col = color)
    }
  draw.sector(40, -40, col="white")
  for (i in 4:1){
    rlab <- mean(c(abs(divs[i + 1]), abs(divs[i])))
    text(rlab, 0, srt=0, labels = round(divl[i + 1], 2))
    draw.sector(40, 38, rou1=divs[i], rou2=divs[i])
  }
  draw.sector(-38, -40, rou1=0.333, rou2=0.333)
  draw.sector(40, 38, rou1=0.666, rou2=0.666)
  draw.sector(-38, -40, rou1=0.666, rou2=0.666)

  text(mean(c(abs(divs[2 + 1]), abs(divs[2]))), 0.1, srt=0, labels=paste(raxis[1], paste(raxis[2], "]", sep=""), sep=" ["))
  polar.plot(r,t, rp.type = "s", point.col="black", add=TRUE, point.symbol=16)
  draw.sector(0, 360, rou1=)
}
