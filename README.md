<span id="title_page.xhtml"></span>

<span id="ch001.xhtml"></span>

<div id="ch001.xhtml#pacviz" class="section level1 unnumbered">

# pacviz

<!-- default, tango, pygments, kate, monochrome, espresso, zenburn, and haddock -->

</div>

<span id="ch002.xhtml"></span>

<div id="ch002.xhtml#about-this-document" class="section level1 unnumbered">

# About this document

This is the documentation of the
[**pacviz**](https://cran.r-project.org/package=pacviz) package.
Examples in the book are generated under version 1.0.0.0.

![](media/file0.png)

Session info:

<div id="ch002.xhtml#the-author" class="section level2 unnumbered">

## The Author

<!--chapter:end:index.Rmd-->

</div>

</div>

<span id="ch003.xhtml"></span>

<div id="ch003.xhtml#introduction-to-the-package" class="section level1">

# <span class="header-section-number">1</span> Introduction to the package

See the pacviz documentation page for more information:
<https://pharaohcola13.github.io/pacviz/book/>.

The functions that are enclosed in this package include:

  - `pacviz`

<div id="ch003.xhtml#installation-guide" class="section level2">

## <span class="header-section-number">1.1</span> Installation Guide

For the most up-to-date version of the package, install it directly from
GitHub.

<div id="ch003.xhtml#cb1" class="sourceCode">

``` sourceCode r
devtools::install_github("PharaohCola13/pacviz")
```

</div>

Through CRAN

<div id="ch003.xhtml#cb2" class="sourceCode">

``` sourceCode r
install.package('pacviz')
```

</div>

</div>

<div id="ch003.xhtml#package-dependencies" class="section level2">

## <span class="header-section-number">1.2</span> Package Dependencies

GlobalOptions, shape, colorspace, circlize, plotrix

<!--chapter:end:01-introduction-to-pacviz.Rmd-->

</div>

</div>

<span id="ch004.xhtml"></span>

<div id="ch004.xhtml#pac-man-residual-plot" class="section level1">

# <span class="header-section-number">2</span> Pac-Man Residual Plot

<div id="ch004.xhtml#description" class="section level2">

## <span class="header-section-number">2.1</span> Description

The results of a regression algorithm typically takes the form of a
residual plot, showing the relationship (or lack thereof) between the
domain and the residual values of the data associated with the model.
From the residual, a broad scope of the model’s performance can be
determined.

`pacviz` contributes a simple approach for looking at the broad view
performance of the regression model by constructing a ‘Pac-Man’ residual
plot.

<div id="ch004.xhtml#formalism" class="section level3">

### <span class="header-section-number">2.1.1</span> Formalism

This visualization technique applies a bijective map from the domain of
the data to angular values between 40 and 320 degrees,
\[\left. X:\rightarrow\lbrack 40,320\rbrack\,. \right.\]

This restriction is applied to allow space for radial labels. By taking
the absolute value of the residual values on the radial coordinate
system, we can observe the overall performance of the model with
relative ease.

In addition, we have added the residual standard deviation for the model
both in its numerical form and graphically as a dashed line at one
\(\sigma\). This circular segment was created by the `circlize` package
.

There are shortcomings for a visualization that views big-picture
components of a model. In the case of the ‘Pac-Man’ residual plot we
lose the ability to determine the dependence of the relationship.
Through a traditional residual plot, it would be simple to determine if
there was systematic or random error based on the relationship between
the standard deviation and the domain of the data.

</div>

</div>

<div id="ch004.xhtml#recommendations" class="section level2">

## <span class="header-section-number">2.2</span> Recommendations

The discussions in this section will revolve around preferred color
schemes and helpful character codes for UTF-8 symbols that can be used
as units.

<div id="ch004.xhtml#color-scheme" class="section level3">

### <span class="header-section-number">2.2.1</span> Color Scheme

Since one of the two colors in the visualization is white, the other is
a user input with the default being `gold`. The following colors are
predefined in R, with the whole list available
[here](http://www.stat.columbia.edu/~tzheng/files/Rcolor.pdf), and are a
good fit in terms of contrast and readability.

  - `lightskyblue`
  - `lightsteelblue`
  - `darksalmon`
  - `palegreen`
  - `gray86`
  - `plum`

</div>

<div id="ch004.xhtml#characters" class="section level3">

### <span class="header-section-number">2.2.2</span> Characters

  - Angstrom: `\uc5`
  - More will be added

</div>

</div>

<div id="ch004.xhtml#usage" class="section level2">

## <span class="header-section-number">2.3</span> Usage

The function is setup to implement an arbitrary regression model and
supports residual standardization. As we have discussed above,

<div id="ch004.xhtml#cb1" class="sourceCode">

``` sourceCode r
pacman(
  x,y,
  title,
  unit,
  axis_label,
  model = lm(y ~ x, data = data.frame(x, y)),
  color1 = "Yellow",
  standardize = FALSE
)
```

</div>

</div>

<div id="ch004.xhtml#examples" class="section level2">

## <span class="header-section-number">2.4</span> Examples

For the following examples, the domain and range that will be processed
by the function will be:

<div id="ch004.xhtml#cb2" class="sourceCode">

``` sourceCode r
x <- rnorm(20, mean=0, sd=10)
y <- log(rnorm(20, mean=0, sd=10), base=exp(1))
```

</div>

It should be noted that these values do change after every run.

<div id="ch004.xhtml#example-1" class="section level3">

### <span class="header-section-number">2.4.1</span> Example 1

In the below snippet, we use

<div id="ch004.xhtml#cb3" class="sourceCode">

``` sourceCode r
# Generic Pac-Man residual
pacman(x,y,'Example 1',
           'units',
           'Axis Label')
```

</div>

![](media/file1.png)

</div>

<div id="ch004.xhtml#example-2" class="section level3">

### <span class="header-section-number">2.4.2</span> Example 2

<div id="ch004.xhtml#cb4" class="sourceCode">

``` sourceCode r
# Pac-Man residual using alternate color,
# residual standardization, and temperature units
pacman(x,y, 'Example 2',
            'degC',
            "Temperature",
            color1="lightblue",
            standardize=TRUE)
```

</div>

![](media/file2.png)

</div>

<div id="ch004.xhtml#example-3" class="section level3">

### <span class="header-section-number">2.4.3</span> Example 3

<div id="ch004.xhtml#cb5" class="sourceCode">

``` sourceCode r
# Pac-Man residual using alternate color,
# a quadratic model, and a UTF8 character for units
pacman(x,y, 'Example 3',
            "\uc5",
            "Distance",
            model=lm(y~poly(x,2)),
            color1="darksalmon")
```

</div>

![](media/file3.png) <!--chapter:end:02-pacman-residual-plot.Rmd-->

</div>

</div>

</div>

<span id="ch005.xhtml"></span>

<div id="ch005.xhtml#releases" class="section level1">

# <span class="header-section-number">3</span> Releases

<div id="ch005.xhtml#v1.0-blinky" class="section level2 unnumbered">

## V1.0 *Blinky*

This is the initial release of the `pacviz` R package.

<!--chapter:end:03-releases.Rmd-->

</div>

</div>
