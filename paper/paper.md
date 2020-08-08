---
title: Broad Scope Visualization of Regression Analysis using pacres
tags:
  - R
  - regression
  - visualization
authors:
  - name: Spencer Riley
    orcid: 0000-0001-7949-9163
    affiliation: 1
affiliations:
  - name: Physics Department, New Mexico Institute of Mining and Technology
    index: 1
date: DD Mon YYY
bibliography: paper.bib
---
# Summary
The results of a regression algorithm typically takes the form of a residual plot, showing the relationship (or lack thereof) between the domain and the standard deviation of the data associated with the model. From the residual, the performance of the model can be determined.

`pacres` contributes a novel approach for looking at the broad view performance of the regression model by constructing a 'Pac-Man' residual plot. This visualization technique applies a map from the domain of the data to the range of acceptable angular values between 40 and 320 degrees,
\begin{equation}
X: \rightarrow [40, 320]\, .
\end{equation}
This restriction is applied to allow space for radial labels.
By taking the absolute value of the factors of standard deviation on the radial coordinate system, we can observe the overall performance of the model with relative ease.

There are shortcomings for a visualization that views big-picture components of a model.

# Usage
```
library(pacres)

x <- rnorm(20, mean=0, sd=10)
y <- log(rnorm(20, mean=0, sd=10), base=exp(1))

pacres(x,y, "Title", " units", "Axis Label")

```

# Acknowledgments

# References
