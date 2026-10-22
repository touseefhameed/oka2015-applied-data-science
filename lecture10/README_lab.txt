OKA2015 Applied Data Science, University of Inland Norway
LECTURE 10, 22 October 2026
DATA MINING AND SIMPLE LINEAR REGRESSION
Touseef Hameed, touseef.hameed@inn.no

STEP 1: SET UP THE FOLDER (do this before anything else)

  Canvas shows the files as a flat list. On your computer they must sit in one
  folder, so that the project file finds them.

  1. Create a folder on your computer, for example  Documents/oka2015/lecture10
  2. Download every file of Lecture 10 from Canvas into that folder.

  The result must look like this (no data subfolder; the data comes with R and
  with a package):

     lecture10/
        lecture10.Rproj
        lecture10_regression.R
        lecture10_regression.Rmd
        lecture10_regression.pdf
        README_lab.txt

  3. Double-click lecture10.Rproj. RStudio opens with this folder as its working
     directory.

  Easier: download the whole course from GitHub as one zip file (green Code
  button, then Download ZIP), unzip it, and double-click lecture10/lecture10.Rproj.

WHAT THE FILES ARE

  lecture10.Rproj            The project file. Always open the lecture through this.
  lecture10_regression.R     Every command from the lecture, in the order of the
                             lecture, one comment per line. Open it and run it line
                             by line with Ctrl + Enter.
  lecture10_regression.Rmd   The same content as an R Markdown document: text and
                             code together. Open it and press Knit.
  lecture10_regression.pdf   What the .Rmd looks like once knitted.

THE DATA

  trees comes with R itself: 31 black cherry trees, with the trunk diameter in
  inches (the column is called Girth), the height in feet and the timber volume
  in cubic feet. The script loads it with data(trees).

PACKAGES

  The two install.packages() lines at the top of the script are needed once per
  computer: tidyverse you already have; broom is new today, and it often came with
  the tidyverse already. Running an install line again does no harm; it only takes
  a minute.

IF SOMETHING GOES WRONG

  could not find function "tidy"         run library(broom) first
  there is no package called 'broom'     run install.packages("broom"), wait, then library(broom)
  object 'fit' not found                 run the lm() line first: fit <- lm(Height ~ Girth, data = trees)
  geom_smooth() using formula = 'y ~ x'  a message, not an error: nothing to fix
  figure margins too large               make the Plots pane larger, then run plot(fit) again
  the next plots are tiny, four at once  run par(mfrow = c(1, 1)) to go back to one plot
  Console shows + and waits              an unfinished line or a missing bracket; press Esc

ONLINE

  The same files, plus a Colab notebook that runs the script in the browser:
  https://github.com/touseefhameed/oka2015-applied-data-science
