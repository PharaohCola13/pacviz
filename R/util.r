#' @title Pac-Man SVM
#'
#' @description A visualization technique in R for regression analysis results, specifically residual values, based on a restricted
#' radial coordinate system. It provides a broad view perspective on the performance of regression models, and supports
#' most model inputs. See the pacviz documentation page for more information: https://pharaohcola13.github.io/pacviz/book/
#' @param x,y Numeric data
#' @param l Numeric labels data
#' @param train_size Fraction of total data that the SVM will train on
#' @return Pac-Man SVM
#' @keywords machine-learning visualization
#' @import plotrix circlize
#' @importFrom graphics par text mtext rect abline plot
#' @importFrom stats coef lm nls resid predict sigma rstandard median
#' @importFrom utils packageDescription
#' @importFrom e1071 svm
#' @export

svm.partition <- function(x,y,l, train_size){
  train_idx <- sample(1:length(x), trunc(length(x)*train_size))
  test_idx  <- (1:length(x))[-(train_idx)]

  train_dat <- data.frame(x[train_idx],
                          y[train_idx])
  train_lab <- factor(gsub(2, -1, c(l[train_idx])))

  names(train_dat)[1] <- "Avg.Temperature"
  names(train_dat)[2] <- "Avg.TPW"

  test_dat  <- data.frame(x[test_idx],
                          y[test_idx])
  test_lab  <- factor(c(gsub(2, -1, l[test_idx])))

  names(test_dat)[1] <- "Avg.Temperature"
  names(test_dat)[2] <- "Avg.TPW"
  output <- list(train_dat=train_dat, train_lab=train_lab, test_dat=test_dat, test_lab=test_lab, train_idx=train_idx)
  return(output)
}

rad2deg <- function(rad) {(rad * 180) / (pi)}
deg2rad <- function(deg) {(deg * pi) / (180)}

linMap  <- function(x,i, f) {(x - min(x))/max(x - min(x)) * (i - f) + f}
