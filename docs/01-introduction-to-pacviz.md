# Introduction to the package

Provides a broad-view perspective on data via
    linear mapping of data onto a radial coordinate system. The package
    contains functions to visualize the residual values of linear
    regression and Cartesian data in the defined radial scheme. See the
    'pacviz' documentation page for more information:
    <https://pacviz.sriley.dev>.


The primary functions that are enclosed in this package include:

- `pac.plot`
- `pac.resid`
- `pac.lsvm` *(In development)*

Some secondary functions include:

- `svm.partition`
- `deg2rad`
- `rad2deg`
- `linMap`


## Installation Guide
For the most up-to-date version of the package, install the package directly from GitHub.

```R
devtools::install_github("PharaohCola13/pacviz")
```
For offical releases, install the package through CRAN
```R
install.package('pacviz')
```

## Package Dependencies
R (>= 4.0.0)

Packages: circlize, e1071, graphics, plotrix, stats, utils

## Recommendations

The discussions in this section will revolve around preferred color schemes and helpful character codes for UTF-8 symbols
that can be used as units.

### Color Scheme

Since one of the two colors in the visualization is white, the other is a user input with the default being `gold`. The following colors are predefined in R, with the whole list available [here](http://www.stat.columbia.edu/~tzheng/files/Rcolor.pdf)\footnote{http://www.stat.columbia.edu/~tzheng/files/Rcolor.pdf},
and are a good fit in terms of contrast and readability.

- `lightskyblue`
- `lightsteelblue`
- `darksalmon`
- `palegreen`
- `gray86`
- `plum`

### Characters

- Angstrom: `\uc5`
- More will be added
