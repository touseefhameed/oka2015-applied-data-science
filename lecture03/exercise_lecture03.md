# Practice exercise, Lecture 3

*Reference: Lecture 3 slides and `lecture03_tidyverse.R`. Not graded. Do it before
Friday; it is the warm-up for Assignment 1.*

Use the `students.csv` file. Either read it from the web,
`read_csv("https://pos.it/r4ds-students-csv")`, or from `data/students.csv`.

## Task 1: objects and vectors

The coffee bar sold 18, 22 and 27 lattes on Monday, Tuesday and Wednesday at 52 NOK each.

a. Store the three counts in a vector called `cups` and the price in `price`.
b. Compute the revenue for each day in one line, without a loop.
c. Compute the total revenue and the average cups per day.
d. What does `cups > 20` return? Explain each element of the answer.

## Task 2: packages

a. Which of these two lines do you run once per computer, and which every session?

```r
install.packages("tidyverse")
library(tidyverse)
```

b. You run `library(janitor)` and get `there is no package called 'janitor'`.
   Write the single line that fixes it.

## Task 3: reading data

a. Read the students file into an object called `students`.
b. Show the first six rows.
c. How many observations and how many variables does it have? Use two functions.
d. What does `glimpse(students)` show you that `head(students)` does not?

## Task 4: types

a. Look at the type printed under the `AGE` column. Why is it `<chr>` and not `<dbl>`?
b. Look at `favourite.food` for student 3. Is that a missing value to R? How do you know?
c. Re-read the file so that `"N/A"` becomes a real `NA`. Then count the missing cells.

## Task 5: a sentence with numbers in it

Using `nrow()`, `ncol()` and `cat()`, print exactly this line to the console:

```
The students table has 6 rows and 5 columns.
```

## Task 6: save your work

Put every command you used into a script, add a comment above each one saying what it
does, and save the file as `YourName_lecture03.R`. Close RStudio, open it again, and run
the whole script from the top. It should work without you typing anything else. If it
does not, the missing line is almost always `library(tidyverse)`.
