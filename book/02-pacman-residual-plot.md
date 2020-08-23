# Pac-Man Residual Plot

## Description
The results of a regression algorithm typically takes the form of a residual plot, showing the relationship (or lack thereof) between the domain and the residual values of the data associated with the model. From the residual, a broad scope of the model's performance can be determined.

`pacviz` contributes a simple approach for looking at the broad view performance of the regression model by constructing a 'Pac-Man' residual plot.

### Formalism
This visualization technique applies a bijective map from the domain of the data to angular values between 40 and 320 degrees,
\begin{equation}
X: \rightarrow [40, 320]\, .
\end{equation}

This restriction is applied to allow space for radial labels. By taking the absolute value of the residual values on the radial coordinate system, we can observe the overall performance of the model with relative ease.

In addition, we have added the residual standard deviation for the model both in its numerical form and graphically as a dashed line at one $\sigma$. This circular segment was created by the `circlize` package
.

There are shortcomings for a visualization that views big-picture components of a model. In the case of the 'Pac-Man' residual plot we lose the ability to determine the dependence of the relationship. Through a traditional residual plot, it would be simple to determine if there was systematic or random error based on the relationship between the standard deviation and the domain of the data.   

## Recommendations

The discussions in this section will revolve around preferred color schemes and helpful character codes for UTF-8 symbols
that can be used as units.

### Color Scheme

Since one of the two colors in the visualization is white, the other is a user input with the default being `gold`.
The following colors are predefined in R, with the whole list available [here](http://www.stat.columbia.edu/~tzheng/files/Rcolor.pdf)\footnote{http://www.stat.columbia.edu/~tzheng/files/Rcolor.pdf},
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

## Usage
The function is setup to implement an arbitrary regression model and supports residual standardization.
As we have discussed above,

```R
pacman(
  x,y,
  title,
  unit,
  axis_label,
  model = lm(y ~ x, data = data.frame(x, y)),
  color1 = "gold",
  standardize = FALSE
)
```

## Examples

For the following examples, the domain and range that will be processed by the
function will be:

```R
data("cars")
x <- cars$dist
y <- cars$speed

```
The units associated with each of the plots are not accurate, they simply demonstrate the capabilities of the function to use a variety of inputs.

### Example 1
In the below snippet, we use

```R
# Generic Pac-Man residual
pacman(x,y, 'Example 1',
            'm/s',
            'Axis Label')
```

\begin{figure}

{\centering \includegraphics[width=1\linewidth]{examples/figures/fig1} 

}

\caption{Graphical result of Example 1. We can see that the units are attached to the residual standard deviation as well as the angular axis markings. Make note that if you want a space between the numerical value and the units to add a space in the character string.}(\#fig:example1)
\end{figure}
\newpage

### Example 2
```R
# Pac-Man residual using alternate color,
# residual standardization, and temperature units
pacman(x,y, 'Example 2',
            'degC',
            "Temperature",
            color1="lightblue",
            standardize=TRUE)
```

\begin{figure}

{\centering \includegraphics[width=1\linewidth]{examples/figures/fig2} 

}

\caption{Graphical result of Example 2.}(\#fig:unnamed-chunk-1)
\end{figure}
\newpage

### Example 3
```R
# Pac-Man residual using alternate color,
# a quadratic model, and a UTF8 character for units
pacman(x,y, 'Example 3',
            "\uc5",
            "Distance",
            model=lm(y~poly(x,2)),
            color1="darksalmon")
```
\begin{figure}

{\centering \includegraphics[width=1\linewidth]{examples/figures/fig3} 

}

\caption{Graphical result of Example 3.}(\#fig:unnamed-chunk-2)
\end{figure}
