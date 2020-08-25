# Pac-Man Plot

## Description

## Usage
The function is setup to implement an arbitrary regression model and supports residual standardization.
As we have discussed above,

```R
pac.plot(
  x,y,
  title,
  xaxislabel,
  yaxislabel,
  xunits,
  yunit,
  color1 = "gold",
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
