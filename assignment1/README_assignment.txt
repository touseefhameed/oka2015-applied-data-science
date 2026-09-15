OKA2015 Applied Data Science, University of Inland Norway
ASSIGNMENT 1: reading and inspecting data with readr and dplyr
Due Wednesday 30 September 2026, 23:59, on Canvas. Individual submission.
Touseef Hameed, touseef.hameed@inn.no

STEP 1: SET UP THE FOLDER (do this before anything else)

  Canvas shows the files as a flat list. On your computer they must sit in one
  folder, with the data file in a subfolder called data. Otherwise the paths in
  the templates will not work.

  1. Create a folder on your computer, for example  Documents/oka2015/assignment1
  2. Download every file of Assignment 1 from Canvas into that folder.
  3. Inside it, create a subfolder named  data  (lower case) and move
     housing.csv into it.

  The result must look exactly like this:

     assignment1/
        assignment1.Rproj
        Assignment1.pdf
        Assignment1_template.R
        Assignment1_template.Rmd
        README.txt
        data/
           housing.csv

  4. Double-click assignment1.Rproj. RStudio opens with this folder as its working
     directory, and "data/housing.csv" is then found automatically.

WHAT THE FILES ARE

  assignment1.Rproj          The project file. Always open the assignment through this.
  Assignment1.pdf            The assignment: the eight problems, what to hand in,
                             how it is assessed. Read it fully before you start.
  Assignment1_template.Rmd   A ready-made R Markdown document with one heading per
                             problem and an empty code chunk under each. Rename it
                             with your name, fill it in, knit it.
  Assignment1_template.R     A script skeleton with the same eight sections. Every
                             command you use goes here too, with a comment.
  data/housing.csv           The California Housing Prices data, 20,640 rows and
                             10 columns. The templates read it from this folder;
                             the PDF also gives a web address for it.

HOW TO WORK

  1. Open assignment1.Rproj.
  2. In the Files pane, rename the two templates:
        Assignment1_template.Rmd  ->  YourName_Assignment1.Rmd
        Assignment1_template.R    ->  YourName_Assignment1.R
     (tick the file, click Rename).
  3. Open YourName_Assignment1.R. Work out each problem there first, line by line
     with Ctrl + Enter, until the output is what the problem asks for.
  4. Copy the working commands into the matching chunk of YourName_Assignment1.Rmd,
     write your explanation under it, and press Knit.
  5. Check the PDF: every problem shows the code and its output.

WHAT TO HAND IN ON CANVAS

  YourName_Assignment1.R
  YourName_Assignment1.Rmd  together with the knitted YourName_Assignment1.pdf
  (or .html). If knitting does not work on your computer, screenshots of your
  RStudio window showing each command and its output are accepted instead.

IF SOMETHING GOES WRONG

  cannot open file 'data/housing.csv'   the data subfolder is missing, or you did
                                        not open the folder through assignment1.Rproj
  could not find function "read_csv"    run library(tidyverse) first
  Knit fails on PDF                     change "output:" in the header to html_document

QUESTIONS

  Ask me in class, or email touseef.hameed@inn.no.
  The Lecture 3 materials include rmarkdown_guide.pdf, a short guide to writing
  an R Markdown file.
