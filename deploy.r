
library(devtools)

check(document=TRUE, manual=TRUE, cran=TRUE, cleanup=TRUE)
build_manual(pkg = ".", path="./man")
