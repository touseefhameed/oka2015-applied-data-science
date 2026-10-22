# Lecture 10: Data mining and simple linear regression
Thursday 22 October 2026, 12:15 to 14:00. Touseef Hameed.

Predictive data mining and the simple linear regression model, following *Business
Analytics* Chapter 8 and *Tidyverse Skills for Data Science* Chapter 5.7: the least
squares line, the slope (the beta estimate) and its standard error, the p-value,
R-squared, the conditions behind the model, and correlation versus causation.

| file | what it is |
|---|---|
| `README_lab.txt` | the plain-text guide handed out on Canvas: how to set the folder up, what each file is |
| `lecture10_slides.pdf` | the slides from class |
| `lecture10.Rproj` | open the folder through this |
| `lecture10_regression.R` | **start here.** The lecture's code, in the lecture's order, one comment per line. Run it top to bottom with Ctrl + Enter. |
| `lecture10_regression.Rmd` | the same content as an R Markdown tutorial. Open it in RStudio and press **Knit**. |
| `lecture10_regression.pdf` | what the Rmd looks like once knitted |

The data: `trees` comes with R itself: 31 black cherry trees, their diameter (the column
`Girth`, in inches), height (feet) and timber volume (cubic feet).

Prefer the browser? The same script runs in Colab:
[`../colab/lecture10_regression.ipynb`](../colab/lecture10_regression.ipynb).

## What is covered

1. Data mining: descriptive and predictive, regression and classification
2. Simple linear regression: the model, the least squares line, fitted values and residuals
3. Fitting the model in R: `lm()`, reading the slope and the intercept, predictions, extrapolation
4. How sure we are: the standard error, the t value, the p-value and the decision rule
5. How good the line is: R-squared, the error term, the four conditions and the check plots
6. Correlation and causation: confounders

## Reading

Camm, Cochran, Fry and Ohlmann (2024), *Business Analytics*, 5th ed., Ch. 8. Wright,
Ellis, Hicks and Peng (2021), *Tidyverse Skills for Data Science in R*, Ch. 5.7,
<https://jhudatascience.org/tidyversecourse/model.html>.
