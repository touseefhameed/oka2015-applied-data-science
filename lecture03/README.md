# Lecture 3: Introduction to the Tidyverse
Wednesday 16 September 2026, 13:15–15:00, Room G102

Where Lecture 2 stopped: R and RStudio installed, `1 + 1` works. Where this one ends:
the tidyverse installed, a real dataset read into R and inspected, and the code saved in
a script. That is Assignment 1, Problems 1 to 4.

## Open these, in this order

| file | what it is |
|---|---|
| `README_lab.txt` | the plain-text lab guide handed out on Canvas: how to set the folder up, what each file is, how to run the lab |
| `lecture03_slides.pdf` | the slides from class |
| `lecture03_tidyverse.R` | **start here.** The lecture's code, one comment per line. Run it top to bottom with Ctrl + Enter. |
| `lecture03_tidyverse.Rmd` | the same content as an R Markdown tutorial: text and code together. Open it in RStudio and press **Knit** to see how an assignment document is produced. |
| `lecture03_tidyverse.pdf` | what the Rmd looks like once knitted |
| `rmarkdown_guide.Rmd` and `.pdf` | **how to write an R Markdown file**: header, text, code chunks, chunk options, knitting, the usual errors. Uses the lecture file as its example. Read this before Assignment 1. |
| `exercise_lecture03.pdf` (and `.Rmd`) | six short practice tasks. Not graded. Do them before Friday; the warm-up for Assignment 1. |
| `data/students.csv` | the dataset. The script reads it from the web; this copy is for when you are offline. |

Prefer the browser? The same script runs in Colab:
[`../colab/lecture03_tidyverse.ipynb`](../colab/lecture03_tidyverse.ipynb).

## What is covered

1. R as a calculator; objects and `<-`; vectors and `c()`; functions and arguments
2. Comments and object names; precision: case, quotation marks, the `+` prompt
3. RStudio's typing aids: Tab completion, command history, `?` and F1
4. Packages: `install.packages()` once, `library()` every session
5. The tidyverse and its nine core packages
6. Tibbles; `read_csv()` from the web, from disk, and with the Import button
7. First look: `head()`, `nrow()`, `ncol()`, `names()`, `glimpse()`, `summary()`
8. Several files at once, `write_csv()`, and the other `read_*()` functions
9. Real data is rarely clean: `na =`, `gsub()`, `as.numeric()`, a preview of Lecture 4

The R script explains every line and every symbol (`<-`, `c()`, `$`, `=`, `::`, `#`)
in a comment, and opens with a glossary of the symbols used.

## Reading

*R for Data Science* (2e): Introduction (Prerequisites), Ch. 2 *Workflow: basics*,
Ch. 7 *Data import*. Free at <https://r4ds.hadley.nz>.
