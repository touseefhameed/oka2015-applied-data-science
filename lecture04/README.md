# Lecture 4: Data Lab, importing and transforming data with dplyr (rows)
Friday 18 September 2026, 10:15 to 12:00. Touseef Hameed.

The first hands-on pass over dplyr, following *R for Data Science* Chapter 3 from the
Introduction to the end of "Rows": the flights data, what every verb shares, the pipe,
`filter()` with the comparison and logical operators, `arrange()`, `distinct()` and
`count()`. Columns and groups follow in the next lectures.

| file | what it is |
|---|---|
| `README_lab.txt` | the plain-text lab guide handed out on Canvas: how to set the folder up, what each file is, how to run the lab |
| `lecture04_slides.pdf` | the slides from class |
| `lecture04.Rproj` | open the folder through this, so paths resolve |
| `lecture04_wrangling.R` | **start here.** The lab's code, in the lab's order, one comment per line. Its first block installs any missing package. Run it top to bottom with Ctrl + Enter. |
| `lecture04_wrangling.Rmd` | the same content as an R Markdown tutorial: text and code together. Open it in RStudio and press **Knit**. |
| `lecture04_wrangling.pdf` | what the Rmd looks like once knitted |
| `exercise_lecture04.pdf` (and `.Rmd`) | nine short practice tasks, not graded. The answers to the script's "check yourself" questions are at the end. |

The data, `flights`, comes inside the **nycflights13** package (336,776 flights out of
New York in 2013); the script installs it if it is missing.

Prefer the browser? The same script runs in Colab:
[`../colab/lecture04_wrangling.ipynb`](../colab/lecture04_wrangling.ipynb).

## What is covered

1. Why transform data; dplyr as a grammar of verbs
2. The data: `nycflights13::flights`; `View()`, `print(width = Inf)`, `glimpse()`; column types; `$`
3. dplyr basics: the three things every verb shares; the pipe `|>`; a first pipeline and `na.rm = TRUE`
4. Rows: `filter()` with `== != > >= < <= & | ! %in% is.na()`; the two common mistakes; a verb never changes its input
5. Rows: `arrange()` and `desc()`; `distinct()`; `count(sort = TRUE)`
6. The project file and the R Markdown file, recapped

## Reading

Wickham, Çetinkaya-Rundel and Grolemund (2023), *R for Data Science*, 2nd ed., Ch. 3
up to "Columns", <https://r4ds.hadley.nz/data-transform>.
