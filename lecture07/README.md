# Lecture 7: Descriptive statistics and exploratory analysis
Tuesday 6 October 2026, 10:15 to 12:00. Touseef Hameed.

How to describe data with numbers, following *Business Analytics* Chapter 2: types of
data, distributions and their shape, mean, median and mode, variance, standard deviation
and quartiles, outliers, and the association between two variables.

| file | what it is |
|---|---|
| `README_lab.txt` | the plain-text guide handed out on Canvas: how to set the folder up, what each file is |
| `lecture07_slides.pdf` | the slides from class |
| `lecture07.Rproj` | open the folder through this |
| `lecture07_descriptive.R` | **start here.** The lecture's code, in the lecture's order, one comment per line. Run it top to bottom with Ctrl + Enter. |
| `lecture07_descriptive.Rmd` | the same content as an R Markdown tutorial. Open it in RStudio and press **Knit**. |
| `lecture07_descriptive.pdf` | what the Rmd looks like once knitted |
| `exercise_lecture07.pdf` (and `.Rmd`) | eight practice tasks on the housing data from Assignment 1, not graded |

The data, `flights` and `weather`, comes inside the **nycflights13** package. The
practice exercise reads `housing.csv` from [`../assignment1/data/`](../assignment1/data/).

Prefer the browser? The same script runs in Colab:
[`../colab/lecture07_descriptive.ipynb`](../colab/lecture07_descriptive.ipynb).

## What is covered

1. Types of data: population and sample, quantitative and categorical, cross-sectional and time series
2. Distributions: frequency tables, histograms, symmetric and skewed shapes
3. Central tendency: mean, median, mode; which to report; which to fill missing values with
4. Variability: range, variance, standard deviation, percentiles, quartiles, IQR
5. Outliers: the IQR rule and the boxplot, z-scores, a real data entry error
6. Association: scatter plots, covariance, correlation, `ggpairs()`

## Reading

Camm, Fry, Cochran and Ohlmann (2024), *Business Analytics*, Ch. 2. Wright, Ellis, Hicks
and Peng (2021), *Tidyverse Skills for Data Science in R*, Ch. 5.4 and 5.5,
<https://jhudatascience.org/tidyversecourse/>.
