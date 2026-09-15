OKA2015 Applied Data Science, University of Inland Norway
LECTURE 3, 16 September 2026: Introduction to the Tidyverse
Touseef Hameed, touseef.hameed@inn.no

STEP 1: SET UP THE FOLDER (do this before anything else)

  Canvas shows the files as a flat list. On your computer they must sit in one
  folder, with the data file in a subfolder called data. Otherwise the paths in
  the code will not work.

  1. Create a folder on your computer, for example  Documents/oka2015/lecture03
  2. Download every file of Lecture 3 from Canvas into that folder.
  3. Inside it, create a subfolder named  data  (lower case) and move
     students.csv into it.

  The result must look exactly like this:

     lecture03/
        lecture03.Rproj
        lecture03_tidyverse.R
        lecture03_tidyverse.Rmd
        lecture03_tidyverse.pdf
        rmarkdown_guide.pdf
        exercise_lecture03.pdf
        README_lab.txt
        data/
           students.csv

  4. Double-click lecture03.Rproj. RStudio opens with this folder as its working
     directory, and every path in the files now works.

WHAT THE FILES ARE

  lecture03.Rproj            The project file. Always open the lab through this.
  lecture03_tidyverse.R      Every command from the lecture, one comment per line.
                             Open it and run it line by line with Ctrl + Enter.
  lecture03_tidyverse.Rmd    The same content as an R Markdown document: text and
                             code together. Open it and press Knit to see how a
                             report is produced. This is the form the assignment takes.
  lecture03_tidyverse.pdf    What the .Rmd looks like once knitted.
  rmarkdown_guide.pdf        How to write an R Markdown file. Read it before you
                             start Assignment 1.
  exercise_lecture03.pdf     Six short practice tasks, not graded. Do them before
                             Friday; they are the warm-up for Assignment 1.
  data/students.csv          The dataset. The .Rmd reads it from the data folder;
                             the script also shows how to read it from the web.

HOW TO WORK THROUGH THE LAB

  1. Open lecture03.Rproj.
  2. In the Files pane (bottom right) click lecture03_tidyverse.R.
  3. Put the cursor on the first line and press Ctrl + Enter, line by line.
     Read the Console after each line.
  4. The line install.packages("tidyverse") is commented out. If the tidyverse
     is not yet installed on this computer, remove the # and run it once.

TO SEE HOW KNITTING WORKS

  Open lecture03_tidyverse.Rmd and press Knit (the ball-of-wool icon above the
  editor). A PDF appears next to the file. If PDF fails, change the header line
  "output:" to html_document, or run tinytex::install_tinytex() once in the Console.

IF SOMETHING GOES WRONG

  cannot open file 'data/students.csv'  the data subfolder is missing, or you did
                                        not open the lab through lecture03.Rproj
  could not find function "read_csv"    run library(tidyverse) first
  there is no package called 'x'        run install.packages("x") once
  Console shows + and waits             a quote or bracket is missing; press Esc

ONLINE

  The same files, plus a Colab notebook that runs the script in the browser:
  https://github.com/touseefhameed/oka2015-applied-data-science
  Free textbook: https://r4ds.hadley.nz  (Introduction, Ch. 2, Ch. 7)
