# Lecture 11: Multiple regression, logistic regression and k-nearest neighbours
Tuesday 3 November 2026, 12:15 to 14:00. Touseef Hameed.

Regression with several x variables, its inference and multicollinearity, logistic
regression for yes-or-no outcomes, and k-nearest neighbours checked on a test set,
following *Business Analytics* Chapters 8, 10 and 11 and *Tidyverse Skills for Data
Science* Chapter 5.

| file | what it is |
|---|---|
| `lecture11_slides.pdf` | the slides from class |
| `lecture11.Rproj` | open the folder through this |
| `lecture11_models.R` | **start here.** The lecture's code, in the lecture's order, one comment per line. Run it top to bottom with Ctrl + Enter. |
| `lecture11_models.Rmd` | the same content as an R Markdown tutorial. Open it in RStudio and press **Knit**. |
| `lecture11_models.pdf` | what the Rmd looks like once knitted |
| `data/bloodpress.csv` | 20 patients with high blood pressure: BP, Age, Weight, BSA, Dur, Pulse, Stress |

The other data come with R: `mtcars` (32 cars) and `iris` (150 flowers).

Prefer the browser? The same script runs in Colab:
[`../colab/lecture11_models.ipynb`](../colab/lecture11_models.ipynb).

## What is covered

1. Multiple linear regression: one y, several x, holding the others constant
2. Inference: t-tests, the F-test, R-squared and adjusted R-squared
3. Multicollinearity: the correlation matrix, `ggpairs()` and the VIF
4. Logistic regression: `glm()`, probabilities, the cut-off, the confusion matrix and accuracy
5. k-nearest neighbours: distance, the T-shirt and income examples, choosing k, train and test, `knn()`

## Reading

Camm, Cochran, Fry and Ohlmann (2024), *Business Analytics*, 5th ed., Ch. 8.4 and 8.5,
Ch. 10.2 and 10.3, Ch. 11.1 to 11.4. Wright, Ellis, Hicks and Peng (2021), *Tidyverse
Skills for Data Science in R*, Ch. 5, <https://jhudatascience.org/tidyversecourse/model.html>.
