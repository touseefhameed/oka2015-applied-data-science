OKA2015 Applied Data Science, University of Inland Norway
LECTURE 7, 6 October 2026
DESCRIPTIVE STATISTICS AND EXPLORATORY ANALYSIS
Touseef Hameed, touseef.hameed@inn.no

STEP 1: SET UP THE FOLDER (do this before anything else)

  Canvas shows the files as a flat list. On your computer they must sit in one
  folder, so that the project file finds them.

  1. Create a folder on your computer, for example  Documents/oka2015/lecture07
  2. Download every file of Lecture 7 from Canvas into that folder.

  The result must look like this (no data subfolder; the data comes from a
  package, and the practice exercise reads its data from the web):

     lecture07/
        lecture07.Rproj
        lecture07_descriptive.R
        lecture07_descriptive.Rmd
        lecture07_descriptive.pdf
        exercise_lecture07.pdf
        README_lab.txt

  3. Double-click lecture07.Rproj. RStudio opens with this folder as its working
     directory.

WHAT THE FILES ARE

  lecture07.Rproj            The project file. Always open the lecture through this.
  lecture07_descriptive.R    Every command from the lecture, in the order of the
                             lecture, one comment per line. Open it and run it line
                             by line with Ctrl + Enter.
  lecture07_descriptive.Rmd  The same content as an R Markdown document: text and
                             code together. Open it and press Knit.
  lecture07_descriptive.pdf  What the .Rmd looks like once knitted.
  exercise_lecture07.pdf     Eight practice tasks on the housing data from
                             Assignment 1, not graded. Do them before the next lecture.

THE DATA

  flights and weather both come inside the nycflights13 package, installed in
  Lecture 4. The script loads them with library(nycflights13).

PACKAGES

  The three install.packages() lines at the top of the script are needed once per
  computer: tidyverse and nycflights13 you already have, GGally is new today.
  Running an install line again does no harm; it only takes a minute.

IF SOMETHING GOES WRONG

  could not find function "ggpairs"      run library(GGally) first
  there is no package called 'GGally'    run install.packages("GGally"), wait, then library(GGally)
  object 'weather' not found             run library(nycflights13) first
  the mean or sd comes out NA            add na.rm = TRUE inside mean(), sd(), median()
  cor() comes out NA                     add use = "complete.obs" inside cor()
  hist(): 'x' must be numeric            the column is text; check its type with glimpse()
  Console shows + and waits              an unfinished line or a missing bracket; press Esc

ONLINE

  The same files, plus a Colab notebook that runs the script in the browser:
  https://github.com/touseefhameed/oka2015-applied-data-science
