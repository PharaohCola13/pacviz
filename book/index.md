---
title: "pacviz"
author: "Spencer Riley"
date: "last revised on 2021-01-12"
site: bookdown::gitbook
favicon: "favicon.ico"
documentclass: book
lot: yes
lof: yes
bibliography: [book.bib]
biblio-style: apalike
link-citations: yes
github-repo: PharaohCola13/pacviz
url: 'https\://pharaohcola13.github.io/pacviz/book'
output:
  bookdown::gitbook:
    dev: svglite
    highlight: monochrome
    config:
      download: pdf
      sharing:
        github: yes
        facebook: no
        google: yes
        twitter: no
        all: no
      fontsettings:
        theme: night
      info: no

---
<!-- default, tango, pygments, kate, monochrome, espresso, zenburn, and haddock -->
# About this document {-}

This is the documentation of the
[**pacviz**](https://cran.r-project.org/package=pacviz) package. Examples
in the book are generated under version 1.0.0.0.

<img src="images/cover.png" style="width:500px;border:2px solid black;" />

Session info:


```r
sessionInfo()
```

```
## R version 3.6.1 (2019-07-05)
## Platform: x86_64-pc-linux-gnu (64-bit)
## Running under: Linux Mint 20
## 
## Matrix products: default
## BLAS:   /usr/local/lib/R/lib/libRblas.so
## LAPACK: /usr/local/lib/R/lib/libRlapack.so
## 
## locale:
##  [1] LC_CTYPE=en_US.UTF-8       LC_NUMERIC=C              
##  [3] LC_TIME=en_US.UTF-8        LC_COLLATE=en_US.UTF-8    
##  [5] LC_MONETARY=en_US.UTF-8    LC_MESSAGES=en_US.UTF-8   
##  [7] LC_PAPER=en_US.UTF-8       LC_NAME=C                 
##  [9] LC_ADDRESS=C               LC_TELEPHONE=C            
## [11] LC_MEASUREMENT=en_US.UTF-8 LC_IDENTIFICATION=C       
## 
## attached base packages:
## [1] stats     graphics  grDevices utils     datasets  methods   base     
## 
## loaded via a namespace (and not attached):
##  [1] compiler_3.6.1  magrittr_2.0.1  bookdown_0.21   htmltools_0.5.0
##  [5] tools_3.6.1     yaml_2.2.1      stringi_1.5.3   rmarkdown_2.6  
##  [9] knitr_1.30      stringr_1.4.0   digest_0.6.27   xfun_0.19      
## [13] rlang_0.4.9     evaluate_0.14
```

## The Author {-}
