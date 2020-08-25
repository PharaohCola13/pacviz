#' @title Pac-Man SVM
#'
#' @description A visualization technique in R for regression analysis results, specifically residual values, based on a restricted
#' radial coordinate system. It provides a broad view perspective on the performance of regression models, and supports
#' most model inputs. See the pacviz documentation page for more information: https://pharaohcola13.github.io/pacviz/book/
#' @param x,y Numeric data
#' @param l Numeric labels data
#' @param title Figure title
#' @param train_size Fraction of total data that the SVM will train on
#' @return Pac-Man SVM
#' @keywords machine-learning visualization
#' @import plotrix
#' @importFrom graphics par text mtext rect abline plot
#' @importFrom stats coef resid predict median
#' @importFrom e1071 svm
#' @importFrom pacviz linMap rad2deg svm.partition
#' @export

lsvm <- function(x,y,l, title, train_size=0.7, rand_state=sample(1:2^15, 1)) {

    pre       <- svm.partition(x,y,l, train_size, rand_state)
    train     <- pre$train
    test      <- pre$test
    train_idx <- pre$train_idx

    svmfit <- svm(x=train[1:2], y=train[3],type="C-classification", kernel="linear", scale=FALSE)
    pred <- predict(svmfit, test[1:2])

    plot(x,y, pch=16, col=ifelse(l[1:length(l)]==sort(unique(train[3])[,1])[1], "blue", "red"))

    cf <- coef(svmfit)

    abline(-cf[1]/cf[3], -cf[2]/cf[3], col = "red")

# plot margin and mark support vectors
    abline(-(cf[1] + 1)/cf[3], -cf[2]/cf[3], col = "black", lty="dashed")
    abline(-(cf[1] - 1)/cf[3], -cf[2]/cf[3], col = "black", lty="dashed")
}

pac.lsvm <- function(x,y,lab, title, axis_label, rand_state=sample(1:2^15, 1), color1 = "lightpink", color2= "lightsteelblue", color3="plum") {
  pre       <- svm.partition(x,y,lab, 0.7, rand_state)
  train     <- pre$train
  test      <- pre$test
  train_idx <- pre$train_idx

  svmfit <- svm(x=train[1:2], y=train[3],type="C-classification", kernel="linear", scale=FALSE)
  pred <- predict(svmfit, test[1:2])
  cf <- coef(svmfit)

  t <- linMap(x, 40, 320)
  r <- linMap(y,1, 0)

  # Angular axis label positions
  lp = seq.int(40, 320, length.out = 6)
  # Angular axis labels
  ln = rev(seq.int(round(min(x, na.rm = TRUE), 1), round(max(x, na.rm = TRUE),1), length.out = 6))

  db_x <- train[1]
  db_t <- rad2deg(atan(-cf[1]/cf[3] * db_x - cf[2]/cf[3])/db_x)
  db_r <- -cf[1]/cf[3] * db_t - cf[2]/cf[3]

  s1_r <- -(cf[1] + 1)/cf[3] * db_t - cf[2]/cf[3]
  s2_r <- -(cf[1] - 1)/cf[3] * db_t - cf[2]/cf[3]

  # s1_t <- rad2deg(atan((-(cf[1] + 1)/cf[3] * db_x - cf[2]/cf[3])/(db_x)))
  # s2_t <- rad2deg(rad2deg(atan((-(cf[1] - 1)/cf[3] * db_x - cf[2]/cf[3])/(db_x))))

  # 6 equal divisions
  divl  <- seq(floor(min(c(y), na.rm = TRUE)), ceiling(max(c(y), na.rm = TRUE)), len = 4)
  divs  <- seq(floor(min(c(r), na.rm = TRUE)), ceiling(max(c(r), na.rm = TRUE)), len = 4)
  n <- divs[4]/10

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
      text <- paste(sprintf("%.2f", round(ln[i], 1)), " ", sep="")
      if (is.element(i, 1:3)) {
          arctext(text, middle = (lp[i] * pi)/(180), radius = divs[4] + n, clockwise = TRUE)
      } else if (is.element(i, 4:6)) {
          arctext(text, middle = (lp[i] * pi)/(180), radius = divs[4] + n, clockwise = FALSE)
      }
  }
  arctext(axis_label, middle = 0, radius = divs[4] + n, clockwise = TRUE)

  for (i in 4:1) {
      if ((i%%2) == 0) {
          color <- "gold"
      } else {
          color <- "White"
      }
      draw.circle(0, 0, radius = divs[i], col = color)
      rlab <- mean(c(abs(divs[i + 1]), abs(divs[i])))
      text(rlab, 0, labels = bquote(.(round(divl[i + 1], 2))))
  }

  polar.plot(c(0, divs[4]), c(40, 40), lwd = 1, rp.type = "l", line.col = "black",
        radial.lim = c(0, divs[4]), add = TRUE)
  polar.plot(c(0, divs[4]), c(320,320), lwd = 1, rp.type = "l", line.col = "black",
          radial.lim = c(0, divs[4]), add = TRUE)

  polar.plot(s1_r,db_t, lwd = 1, rp.type = "l", line.col = "black", radial.lim = c(0, divs[4]), add = TRUE)
  # draw.sector(start.degree = max(db_t), end.degree = min(db_t), rou1 = 0, rou2 = divs[6],
  #     lty = "dashed", border = "Black", col=color1)
  polar.plot(r,t, rp.type = "s", point.col=ifelse(lab[1:length(lab)]==sort(unique(train[3])[,1])[1], "blue", "red"), point.symbols=16, add=TRUE)
}

# fname <- read.table(file="https://raw.githubusercontent.com/physicsgoddess1972/Precipitable-Water-Model/master/data/ml/ml_data.csv", sep=",", header=TRUE, strip.white=TRUE)
# #
# # suppressPackageStartupMessages(library(circlize))
# library(e1071); library(plotrix)
# x <- fname[,2]
# y <- fname[,3]
#
# l <- fname[,5]
# lsvm(x,y, l, "Function Test", rand_state=1)
# pac.lsvm(x,y, l, "Function Test", "Axis Label", rand_state=1)
# warnings()
