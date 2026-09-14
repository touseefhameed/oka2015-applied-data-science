# ØKA2015 Applied Data Science
### University of Inland Norway, Lillehammer, autumn 2026
Touseef Hameed (touseef.hameed@inn.no)

[![Open In Colab](https://colab.research.google.com/assets/colab-badge.svg)](https://colab.research.google.com/github/touseefhameed/oka2015-applied-data-science/blob/main/colab/lecture03_tidyverse.ipynb)

Code, data and slides for the lectures, so you can rerun everything from class at your
own pace. **The primary way to follow the course is RStudio on your own laptop, typing
the commands yourself**; that is how the lectures are taught and how assignments are
written. This repository is for afterwards: download a script to rerun it, read the
knitted tutorial, or run the code directly in Colab when your own installation is not
available.

---

## Contents

| folder | what is in it |
|---|---|
| `lecture02/` | Lecture 2, 27 August: the data science process, tidy data, R and RStudio. Slides only. |
| `lecture03/` | **Lecture 3, 16 September: Introduction to the Tidyverse.** Slides, the commented R script, the R Markdown tutorial with its PDF, the practice exercise, and the data. |
| `colab/` | The same scripts as Google Colab notebooks, R runtime, one result per cell. |
| `tools/` | The script that builds a Colab notebook from an R script. Instructor use. |

Each lecture folder has its own `README.md` saying what to open first.

## Running the code

### Option A, RStudio on your laptop (recommended, this is how assignments are written)

1. Click the green **Code** button at the top of this page, then **Download ZIP**.
   Unzip it somewhere sensible, for example `Documents/oka2015`.
2. In RStudio: **File → Open Project**, or just **File → Open File** and pick the
   `.R` script you want.
3. Run it line by line with **Ctrl + Enter**. Read the comments; they explain each line.

Requirements: R 4.2 or newer, RStudio, and the tidyverse (`install.packages("tidyverse")`,
once). Lecture 2 covered installing R and RStudio; Lecture 3 covers the tidyverse.

### Option B, Google Colab in the browser (nothing to install)

1. Click the **Open in Colab** badge above, or open a notebook in `colab/`.
2. Sign in with any Google account.
3. The notebook is already set to the R runtime. Press the play button on the first
   cell, then on each cell in order.

Your changes in Colab are not saved to this repository. **File → Save a copy in Drive**
keeps your own version.

## Data

| file | what it is | source |
|---|---|---|
| `lecture03/data/students.csv` | six students, five columns, deliberately a little messy | Wickham et al., *R for Data Science* (2e), Ch. 7, <https://pos.it/r4ds-students-csv> |
| `data/housing.csv` | California Housing Prices, 20,640 districts from the 1990 census, 10 columns. Used in Assignment 1. | Pace and Barry (1997), StatLib; CSV as distributed on [Kaggle](https://www.kaggle.com/datasets/camnugent/california-housing-prices) and in Géron, *Hands-On Machine Learning* |

## Reading

- Wickham, Çetinkaya-Rundel and Grolemund (2023). *R for Data Science*, 2nd ed. Free at
  <https://r4ds.hadley.nz>.
- Wright, Ellis, Hicks and Peng (2021). *Tidyverse Skills for Data Science in R*.
  <https://jhudatascience.org/tidyversecourse/>
- Camm, Cochran, Fry and Ohlmann (2024). *Business Analytics*. Cengage.

## Licence

Code is MIT. Teaching text and slides are CC BY 4.0. Data files keep the licence of
their original source; cite that source, not this repository.
