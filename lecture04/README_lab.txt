OKA2015 Applied Data Science, University of Inland Norway
LECTURE 4, 18 September 2026
DATA LAB: importing and transforming data (wrangling) with dplyr
Touseef Hameed, touseef.hameed@inn.no

STEP 1: SET UP THE FOLDER (do this before anything else)

  Canvas shows the files as a flat list. On your computer they must sit in one
  folder, so that the project file finds them.

  1. Create a folder on your computer, for example  Documents/oka2015/lecture04
  2. Download every file of Lecture 4 from Canvas into that folder.

  The result must look like this (no data subfolder this time; the data comes
  from a package):

     lecture04/
        lecture04.Rproj
        lecture04_wrangling.R
        lecture04_wrangling.Rmd
        lecture04_wrangling.pdf
        exercise_lecture04.pdf
        README_lab.txt

  3. Double-click lecture04.Rproj. RStudio opens with this folder as its working
     directory.

WHAT THE FILES ARE

  lecture04.Rproj            The project file. Always open the lab through this.
  lecture04_wrangling.R      Every command from the lab, in the order of the lab,
                             one comment per line. Open it and run it line by line
                             with Ctrl + Enter. The install.packages() line at the
                             top is needed once per computer.
  lecture04_wrangling.Rmd    The same content as an R Markdown document: text and
                             code together. Open it and press Knit.
  lecture04_wrangling.pdf    What the .Rmd looks like once knitted.
  exercise_lecture04.pdf     Nine short practice tasks, not graded. Do them before
                             the next lecture. The answers to the script's "check yourself"
                             questions are at the end.

THE DATA

  The flights table, 336,776 flights out of New York in 2013, comes inside the
  nycflights13 package. The script installs it with install.packages() and loads
  it with library(nycflights13). Internet is needed once, for the install.

HOW TO WORK THROUGH THE LAB

  1. Open lecture04.Rproj.
  2. In the Files pane (bottom right) click lecture04_wrangling.R.
  3. Put the cursor on the first line and press Ctrl + Enter, line by line. Read
     the Console after each line. The first line of every result tells you how
     many rows and columns came back; that is how you check a verb.
  4. install.packages("nycflights13") at the top is needed once per computer.
     Running it again does no harm; it only takes a minute. The tidyverse was
     installed in Lecture 3; its install line is there too, commented out.

IF SOMETHING GOES WRONG

  could not find function "filter"     run library(tidyverse) first
  object 'flights' not found           run library(nycflights13) first
  there is no package called 'dplyr'   run install.packages("tidyverse"), wait, then library(tidyverse)
  We detected a named input ... `=`    a single = in filter(); use ==
  object 'IAH' not found               text needs quotes: dest == "IAH"
  every summary is NA                  add na.rm = TRUE inside mean() or sum()
  Console shows + and waits            an unfinished pipeline or a missing bracket; press Esc

ONLINE

  The same files, plus a Colab notebook that runs the script in the browser:
  https://github.com/touseefhameed/oka2015-applied-data-science
  Free textbook: https://r4ds.hadley.nz  (Ch. 3, Data transformation)
