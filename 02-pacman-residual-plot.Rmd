# Pac-Man Residual Plot
The results of a regression algorithm typically takes the form of a residual plot, showing the relationship (or lack thereof) between the domain and the residual values of the data associated with the model. From the residual, the performance of the model can be determined.

`pacviz` contributes a novel approach for looking at the broad view performance of the regression model by constructing a 'Pac-Man' residual plot. This visualization technique applies a bijective map from the domain of the data to angular values between 40 and 320 degrees,
\begin{equation}
X: \rightarrow [40, 320]\, .
\end{equation}
This restriction is applied to allow space for radial labels. By taking the absolute value of the residual values on the radial coordinate system, we can observe the overall performance of the model with relative ease.

There are shortcomings for a visualization that views big-picture components of a model. In the case of the 'Pac-Man' residual plot we lose the ability to determine the dependence of the relationship. Through a traditional residual plot, it would be simple to determine if there was systematic or random error based on the relationship between the standard deviation and the domain of the data.   

## Usage
```R
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

## Examples
For the following examples, the domain and range that will be processed by the
function will be:

```R
x <- rnorm(20, mean=0, sd=10)
y <- log(rnorm(20, mean=0, sd=10), base=exp(1))
```
It should be noted that these values do change after every run.

### Example 1
In the below snippet, we use

```R
# Generic Pac-Man residual
pacman(x,y,'Example 1',
           'units',
           'Axis Label')
```
<img src="examples/figures/fig1.png" width="100%" />

### Example 2
```R
# Pac-Man residual using alternate color, residual standardization, and temperature units
pacman(x,y, 'Example 2',
            'degC',
            "Temperature",
            color1="lightblue",
            standardize=TRUE)
```
<img src="examples/figures/fig2.png" width="100%" />
