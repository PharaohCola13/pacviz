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
#' @example
#' data("cars")
#' l <- sample(rep(c(0,1),length.out=length(cars$dist)/2),length(cars$dist), replace=TRUE)
#' svm.partition(cars$dist,cars$speed,l, colnames(cars)[2], colnames(cars)[1], train_size=0.1, rand_state=2)
#' @export
svm.partition <- function(x,y,l, train_size=0.7, rand_state=sample(1:2^15, 1)){
  set.seed(rand_state)
  train_idx <- sample(1:length(x), trunc(length(x)*train_size), replace=FALSE)
  test_idx  <- (1:length(x))[-(train_idx)]

  train     <- data.frame(x[train_idx],
                          y[train_idx],
                          factor(c(l[train_idx])))
  colnames(train) <- c("x", "y", "labels")

  test    <- data.frame(x[test_idx],
                          y[test_idx],
                        factor(c(l[test_idx])))
  colnames(test) <- c("x", "y", "labels")


  output <- list(train=train, test=test, train_idx=train_idx)
  return(output)
}
# data("cars")
# l <- sample(rep(c(0,1),length.out=length(cars$dist)/2),length(cars$dist), replace=TRUE)
# svm.partition(cars$dist,cars$speed,l, train_size=0.1, rand_state=2)
#' @title Pac-Man SVM
#'
#' @description Conversion between radians and degrees
#' @param x,y Numeric data
#' @param l Numeric labels data
#' @param train_size Fraction of total data that the SVM will train on
#' @return Pac-Man SVM
#' @keywords machine-learning visualization
#' @export
rad2deg <- function(rad) {(rad * 180) / (pi)}

#' @title Pac-Man SVM
#'
#' @description Conversion between degrees and radians
#' @param x,y Numeric data
#' @param l Numeric labels data
#' @param train_size Fraction of total data that the SVM will train on
#' @return Pac-Man SVM
#' @keywords machine-learning visualization
#' @export
deg2rad <- function(deg) {(deg * pi) / (180)}
#' @title Pac-Man SVM
#'
#' @description linear map
#' @param x,y Numeric data
#' @param l Numeric labels data
#' @param train_size Fraction of total data that the SVM will train on
#' @return Pac-Man SVM
#' @keywords machine-learning visualization
#' @export
linMap  <- function(x,i, f) {(x - min(x))/max(x - min(x)) * (i - f) + f}
