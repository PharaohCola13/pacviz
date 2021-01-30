---
title: Broad Scope Visualization of Regression Analysis using pacviz
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
The results of a regression algorithm typically takes the form of a residual plot, showing the relationship (or lack thereof) between the domain and the residual values of the data associated with the model. From the residual, the performance of a particular model can be determined.

`pacviz` contributes a novel approach for looking at data using broad view visualizations, within the package we provide graphical functions that have the capability to determine the performance of a regression model by constructing a 'Pac-Man' residual plot. In addition to the residual plot, we have developed a graphical function for examining traditional Cartesian data. These visualization technique applies a bijective map from the domain of the data to angular values between 40 and 320 degrees,
\begin{equation}
X: \rightarrow [40, 320]\, .
\end{equation}
This restriction is applied to allow space for radial labels. By taking the absolute value of the residual values on the radial coordinate system, we can observe the overall performance of the model with relative ease.

There are shortcomings for a visualization that views big-picture components of a model. In the case of the 'Pac-Man' residual plot we lose the ability to determine the dependence of the relationship. Through a traditional residual plot, it would be simple to determine if there was systematic or random error based on the relationship between the standard deviation and the domain of the data.   

For more information please refer to the official [`pacviz` documentation page](https://spencerriley.me/pacviz/book).
