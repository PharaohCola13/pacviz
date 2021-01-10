#' @title Pac-Man Residual Function
#'
#' @description A visualization technique in R for regression analysis results, specifically residual values, based on a restricted
#' radial coordinate system. It provides a broad view perspective on the performance of regression models, and supports
#' most model inputs. See the pacviz documentation page for more information: https://pharaohcola13.github.io/pacviz/book/
#' @param x,y Numeric data
#' @param title Figure title
#' @param taxis Vector with the first entry being the axis label and the second entry being units
#' @param model An object for which the extraction of model residuals is meaningful.
#' @param color1 Color value as string or rgb
#' @param standardize Boolean to standardize the residual value
#' @return Pac-Man residual plot
#' @keywords regression visualization
#' @import plotrix circlize
#' @importFrom graphics par text mtext rect abline plot
#' @importFrom stats coef lm nls resid predict sigma rstandard median
#' @importFrom utils packageDescription
#' @examples
#' data("cars")
#' x <- cars$dist
#' y <- cars$speed
#' pac.resid(x,y, 'Example 2',
#'             c("Temperature",'degC'),
#'             color1="lightblue",
#'             standardize=TRUE)
#' @export
pac.resid <- function(x, y, title, taxis, model = lm(y ~ x, data = data.frame(x,y)), color1 = "gold", standardize = FALSE) {
    # Revert margin settings back to default after exit
    oldpar <- par(mar = par()$mar, oma = par()$oma)
    on.exit(par(oldpar))

    tunit <- unit_format(taxis[2])

    # residual quanities from the regression model
    if (standardize == TRUE) {
        residual <- abs(rstandard(model))
    } else {
        residual <- abs(resid(model))
    }
    # sequence used for angular position
    t <-linMap(x, 40, 320)

    # Angular axis label positions
    lp = seq.int(40, 320, length.out = 6)
    # Angular axis labels
    ln = rev(seq.int(round(min(x, na.rm = TRUE), 1), round(max(x, na.rm = TRUE),1), length.out = 6))

    # Maximum radial distance
    rmax <- max(residual, na.rm = TRUE)
    rmin <- min(residual, na.rm = TRUE)
    # 6 equal divisions
    divs <- seq(floor(rmin), ceiling(rmax), len = 6)
    n <- divs[6]/10

    # Plots the residual against an angular position
    par(oma = c(0, 0, 3, 0), cex = 0.9)
    polar.plot(0, labels = "", radial.lim = c(0, divs[6]), show.grid = FALSE, show.grid.labels = FALSE,show.radial.grid = FALSE)
    title(paste("\n\n", title, sep = ""), outer = TRUE)
    # Generates 'tick marks' for angular axis
    for (i in lp) {
        polar.plot(c(0, divs[6] + n/2), c(i, i), lwd = 1, rp.type = "p", line.col = "Black",add = TRUE)
    }
    # Generates angular labels (w/ units) and axis title
    for (i in 1:6) {
				text <- sprintf("%.2f", round(ln[i], 1))
        if (is.element(i, 1:3)) {
            arctext(text, middle = (lp[i] * pi)/(180), radius = divs[6] + n, clockwise = TRUE)
        } else if (is.element(i, 4:6)) {
            arctext(text, middle = (lp[i] * pi)/(180), radius = divs[6] + n, clockwise = FALSE)
        }
    }
    arctext(paste(taxis[1], paste(tunit$unit, "]", sep=""), sep=" ["), middle = 0, radius = divs[6] + n, clockwise = TRUE)

    # Draws the circles and the labels
    for (i in 6:1) {
        if ((i%%2) == 0) {
            color <- color1
        } else {
            color <- "White"
        }
        draw.circle(0, 0, radius = divs[i], col = color)
    }
    draw.sector(40, -40, rou1=divs[6], col="white")
    for (i in 6:1){
      rlab <- mean(c(abs(divs[i + 1]), abs(divs[i])))
      text(rlab, 0, srt=0, labels = bquote(.(divs[i + 1] * 2) * sigma))
      draw.sector(40, 38, rou1=divs[i], rou2=divs[i])
      draw.sector(-38, -40, rou1=divs[i], rou2=divs[i])
    }
    # Draws the label space
    polar.plot(c(0, divs[6]), c(min(t), min(t)), lwd = 1, rp.type = "p", line.col = "black",
        add = TRUE)
    polar.plot(c(0, divs[6]), c(max(t), max(t)), lwd = 1, rp.type = "p", line.col = "black",
        add = TRUE)

    # Plots the data
    polar.plot(residual, t, rp.type = "s", point.col = "black", point.symbols = 16,
        radial.lim = c(0, divs[6]), add = TRUE)

    # Representation of the residual standard deivation
    text(mean(c(abs(divs[3 + 1]), abs(divs[3]))), 0.25, srt=0, labels="Residual Values")
    mtext(c(parse(text = sprintf("sigma == %.3f*%s", sigma(model), tunit$unit_box))), at = par("usr")[1] +0.05 * diff(par("usr")[1:2]))
    rect(par("usr")[1] - 0.05 * diff(par("usr")[1:2]), -(par("usr")[1] - 0.05 * diff(par("usr")[1:2])),
        par("usr")[1] + 0.15 * diff(par("usr")[1:2]), -(par("usr")[1] + 0.01 * diff(par("usr")[1:2])),
        border = 1)
}
