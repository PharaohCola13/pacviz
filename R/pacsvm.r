#' @title Pac-Man SVM
#'
#' @description A visualization technique in R for regression analysis results, specifically residual values, based on a restricted
#' radial coordinate system. It provides a broad view perspective on the performance of regression models, and supports
#' most model inputs. See the pacviz documentation page for more information: https://pharaohcola13.github.io/pacviz/book/
#' @param x,y Numeric data
#' @param title Figure title
#' @param unit String to define units on the angular axis (For temperature measurements use 'degC' or 'degF')
#' @param axis_label Angular axis label
#' @param model An object for which the extraction of model residuals is meaningful.
#' @param color1 Color value as string or rgb
#' @param standardize Boolean to standardize the residual value
#' @return Pac-Man SVM
#' @keywords machine-learning visualization
#' @import plotrix circlize
#' @importFrom graphics par text mtext rect
#' @importFrom stats coef lm nls resid predict sigma rstandard
#' @importFrom utils packageDescription
#' @examples
#' # Generic Pac-Man residual
#' x <- rnorm(20, mean=0, sd=10)
#' y <- log(rnorm(20, mean=0, sd=10), base=exp(1))
#' pacman(x,y,'Example 1','units', 'Axis Label')
#' @examples
#'
#' # Pac-Man residual using alternate color, residual standardization, and temperature units
#' x <- rnorm(20, mean=0, sd=10)
#' y <- log(rnorm(20, mean=0, sd=10), base=exp(1))
#' pacman(x,y, 'Example 2', 'degC', "Temperature", color1="lightblue", standardize=TRUE)
#' @export
pacsvm <- function(x,y,lab, title, kernel='linear', color1 = "lightpink", color2= "lightsteelblue", color3="plum") {
    # Revert margin settings back to default after exit
    oldpar <- par(mar = par()$mar, oma = par()$oma)
    on.exit(par(oldpar))

		# Finds and removes NaNed values from the dataset
		# nans <- c(grep("NaN", y)); nans <- append(nans, grep("NaN", x))
		# x <- x[-(nans)]; y <- y[-(nans)]; l <- l[-(nans)]

    train_idx <- sample(1:length(x), trunc(length(x)*0.7))
    test_idx  <- (1:length(x))[-(train_idx)]

    train_dat <- data.frame(x[train_idx],
                           y[train_idx])
    train_lab <- l[train_idx]

    names(train_dat)[1] <- "Avg.Temperature"
    names(train_dat)[2] <- "Avg.TPW"


    test_dat  <- data.frame(x[test_idx],
                            y[test_idx])
    test_lab  <- l[test_idx]

    names(test_dat)[1] <- "Avg.Temperature"
    names(test_dat)[2] <- "Avg.TPW"

    svmfit <- svm(train_lab ~ train_dat[,1], data=train_dat, kernel="linear", degree=5, C=2, fit=TRUE)
    pred <- predict(svmfit, test_dat)

    plot(train_dat, pch=16, col =ifelse(lab[train_idx]==1, "blue", "red"))

    cf <- coef(svmfit)
    print(cf)
    abline(svmfit, col = "plum")
    abline(-cf[1]/cf[3], -cf[2]/cf[3], col = "red")

    # plot margin and mark support vectors
    abline(-(cf[1] + 1)/cf[3], -cf[2]/cf[3], col = "blue")
    abline(-(cf[1] - 1)/cf[3], -cf[2]/cf[3], col = "blue")
    points(svmfit$SV, pch = 5, cex = 2)
}
# fname       <- read.table(file="../../Precipitable-Water-Model/data/ml/ml_data.csv", sep=",", header=TRUE, strip.white=TRUE)

# library(e1071); library(plotrix); library(circlize)
# x <- fname[,2]
# y <- fname[,3]

# l <- fname[,5]
# pacsvm(x,y, l, "Function Test")
# warnings()
