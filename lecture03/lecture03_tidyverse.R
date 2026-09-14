############################################################
#  OEKA2015 Applied Data Science, University of Inland Norway
#  LECTURE 3 (16 September 2026): INTRODUCTION TO THE TIDYVERSE
#  Touseef Hameed
#
#  How to use this file
#    * Open it in RStudio (File > Open File).
#    * Place the cursor on a line and press Ctrl + Enter (Cmd + Enter on
#      a Mac). That runs ONE line and moves to the next. Read the Console.
#    * Every line that starts with # is a comment. R ignores it. The
#      comments explain what each command and each symbol does.
#    * Nothing here changes a file on your computer until section 11.
#
#  Runs in: RStudio on your laptop, or Google Colab (R runtime).
#
#  SYMBOLS YOU WILL SEE, AND WHAT THEY MEAN
#    <-    assignment: put the value on the right into the name on the left
#    ( )   call a function; the arguments go inside
#    ,     separates arguments, or elements in c()
#    " "   quotation marks: the content is text (a "string")
#    #     comment: R ignores the rest of the line
#    =     inside ( ): gives a value to a NAMED argument, e.g. na.rm = TRUE
#    $     selects one column from a table, e.g. students$AGE
#    ::    "the function from this package", e.g. readr::read_csv
#    +  -  *  /  ^   arithmetic: add, subtract, multiply, divide, power
#    ?     opens the help page of a function, e.g. ?mean
############################################################


###############################
# 0)  R AS A CALCULATOR
###############################
1 + 1               # add. This is the line you typed at the end of Lecture 2
1 / 200 * 30        # divide 1 by 200, then multiply by 30. Result: 0.15
(59 + 73 + 2) / 3   # parentheses first, so this computes an average
sin(pi / 2)         # sin() is a function; pi is a built-in constant. Result: 1
2 ^ 3               # ^ is "to the power of". Result: 8

# The [1] in front of every answer means: this line of output starts at
# element number 1 of the result. It matters once results are longer.


###############################
# 1)  OBJECTS AND THE ASSIGNMENT OPERATOR  <-
#     An object is a named location in R's memory that holds a value.
#     The form is always:   object_name <- value
#     Read  cups <- 18  as  "cups gets 18".
#     RStudio shortcut for typing <- :  Alt + minus
###############################
cups <- 18          # <- stores the number 18 under the name cups. Nothing is printed
cups                # a name on its own asks R to display what it holds
cups * 2            # * multiplies. R looks up cups (18) and doubles it. Result: 36

price <- 52         # a latte at our Lillehammer coffee bar, in NOK
cups * price        # 18 * 52. Result: 936

revenue <- cups * price   # the result of a calculation can be stored too
revenue                   # display it


###############################
# 2)  VECTORS  c()
#     A vector holds several values of the same kind in one object.
#     c() means "combine". Most of R operates on whole vectors at once,
#     which is called vectorised computation. It replaces loops.
###############################
cups <- c(18, 22, 27)      # c() combines three numbers, Mon Tue Wed. This REPLACES the old cups
cups                       # display all three
cups * price               # * is applied to every element: 936 1144 1404

length(cups)               # length() counts the elements. Result: 3
sum(cups)                  # sum() adds them. Result: 67
mean(cups)                 # mean() averages them. Result: 22.33
max(cups)                  # max() finds the largest. Result: 27

days <- c("Mon", "Tue", "Wed")   # a vector of text. Text is always in quotation marks
days                             # display it


###############################
# 3)  FUNCTIONS AND ARGUMENTS
#     A function is a named command:  function_name(argument1, argument2)
#     The arguments are what you hand to it, separated by commas.
#     An argument can be given by position, or by name with  name = value
###############################
seq(from = 1, to = 10)     # seq() makes a sequence; both arguments given by NAME
seq(1, 10)                 # the same call, arguments given by POSITION
round(mean(cups), 1)       # a function inside a function: mean() runs first, then round() to 1 decimal
mean(c(18, NA, 27), na.rm = TRUE)   # NA is a missing value; na.rm = TRUE tells mean() to ignore it
?mean                      # ? opens the help page for mean() in the Help pane


###############################
# 4)  COMMENTS AND OBJECT NAMES
#     A name must start with a letter, then letters, numbers, _ and . only.
#     Use descriptive names and one style. This course uses snake_case.
###############################
# a comment above a command explains WHY it is there, as this one does
cups_monday <- 18          # snake_case: lower-case words joined by underscores. Recommended
cupsMonday  <- 18          # camelCase: also valid, less common in the tidyverse
cups.monday <- 18          # periods: valid in R, but avoid, they mean something else in other languages
# 2cups <- 18              # NOT allowed: a name cannot start with a number
# my cups <- 18            # NOT allowed: a name cannot contain a space


###############################
# 5)  PRECISION: R DOES EXACTLY WHAT YOU TYPE
###############################
# Rule 1: R is case-sensitive. cups, Cups and CUPS are three different names.
cups                       # exists, displays 18 22 27
# Cups                     # remove the # and run: Error: object 'Cups' not found

# Rule 2: text needs quotation marks, numbers do not.
shop <- "Kaffebar"         # text, in quotes
year <- 2026               # a number, no quotes
# town <- Lillehammer      # remove the # and run: Error: object 'Lillehammer' not found.
                           # Without quotes, R looked for an OBJECT called Lillehammer

# Rule 3: quotation marks and parentheses come in pairs.
# x <- "hello              # if you run this, the Console shows  +  and waits
                           # for the closing quote. Press Esc to cancel


###############################
# 6)  THE ENVIRONMENT: what R currently holds in memory
#     Watch the Environment pane (top right) while you run these.
###############################
ls()                       # ls() lists every object created so far
rm(revenue)                # rm() removes one object
ls()                       # revenue is gone
# rm(list = ls())          # removes EVERYTHING. Useful at the top of a script
# Objects live in memory only. Close RStudio and they are gone. The script
# that created them is what you keep.


###############################
# 7)  PACKAGES: INSTALL ONCE, LOAD EVERY SESSION
#     A package is a collection of functions written by others.
#     install.packages() downloads it to your laptop. ONCE per computer.
#     library() loads it for the current session. EVERY time you open R.
#     Note the quotes: install.packages("tidyverse") has them,
#                      library(tidyverse) does not.
###############################
# install.packages("tidyverse")   # remove the # and run this ONCE. It downloads
                                  # about 40 packages. Wait for the > prompt

library(tidyverse)         # loads the nine core packages for this session.
                           # A message listing them, plus a "Conflicts" note, is normal

# If you ever see:  Error in library(x) : there is no package called 'x'
# it means install.packages("x") has not been run on this computer yet.
# tidyverse_update()       # reports whether newer versions are available


###############################
# 8)  READING A CSV FILE WITH readr
#     read_csv() reads a comma-separated file and returns a TIBBLE,
#     the tidyverse's data table. The first argument is the path.
#     Our file: 6 students, 5 columns, from the R for Data Science book.
###############################

# Route 1: straight from the web. Nothing to download first.
students <- read_csv("https://pos.it/r4ds-students-csv")   # the path is a web address, in quotes
                           # read_csv prints "Rows: 6 Columns: 5" and the column types. Not an error

# Route 2: from a file on your laptop. The path is relative to your
#          WORKING DIRECTORY (section 10). Remove the # to use it.
# students <- read_csv("data/students.csv")

# Route 3: click Import Dataset in the Environment pane, choose
#          From Text (readr), pick the file. RStudio writes Route 2 for you.


###############################
# 9)  A FIRST LOOK AT THE DATASET
#     Always inspect before you analyse. These lines are Assignment 1,
#     Problems 1 to 4.
###############################
students                   # a tibble prints its size, column names and column types
head(students)             # head() shows the first six rows
nrow(students)             # nrow() counts rows, the observations: 6
ncol(students)             # ncol() counts columns, the variables: 5
names(students)            # names() lists the column names
glimpse(students)          # glimpse() shows every column on its own line, with its type
summary(students)          # summary() gives basic statistics per column
# View(students)           # View() opens a spreadsheet view. Capital V. RStudio only

# Storing the counts so you can print a sentence with them:
num_rows <- nrow(students)                        # store the row count
num_cols <- ncol(students)                        # store the column count
cat("Rows:", num_rows, "  Columns:", num_cols, "\n")   # cat() prints text and values; "\n" means new line


###############################
# 10)  WHERE AM I? THE WORKING DIRECTORY
#      R reads and writes files relative to ONE folder, the working directory.
#      On Windows, write paths with forward slashes /
###############################
getwd()                    # getwd() prints the current working directory
# setwd("C:/Users/yourname/OneDrive/oka2015")   # setwd() changes it. EDIT the path first
# Recommended instead: File > New Project in RStudio. Then paths just work.


###############################
# 11)  REAL DATA IS RARELY CLEAN (a preview of Lecture 4)
#      In favourite.food one entry is the TEXT "N/A", not a missing value.
#      In AGE one entry is the WORD "five", so the whole column became text.
###############################
students$favourite.food    # $ selects one column. Row 3 shows "N/A" in quotes: text
students$AGE               # the column type is <chr>, text, because of "five"

# Tell read_csv which strings mean "missing". Then "N/A" becomes a real NA.
students <- read_csv("https://pos.it/r4ds-students-csv",   # same file
                     na = c("N/A", ""))                    # na = : a named argument, "treat these as missing"
students$favourite.food    # row 3 is now NA, without quotes
sum(is.na(students))       # is.na() is TRUE where a value is missing; sum() counts the TRUEs. Result: 2
colSums(is.na(students))   # colSums() counts them per column

# Correct the word "five" and convert AGE to numbers.
students$AGE <- gsub("five", "5", students$AGE)   # gsub() = global substitute: replace "five" by "5"
students$AGE <- as.numeric(students$AGE)          # as.numeric() converts text to numbers
students$AGE                                      # now: 4 5 7 NA 5 6
mean(students$AGE, na.rm = TRUE)                  # the mean, ignoring the missing value. Result: 5.4


###############################
# 12)  SAVE A COPY OF THE DATA ON YOUR LAPTOP
#      write_csv() is the reverse of read_csv(): the object, then the path.
###############################
dir.create("data", showWarnings = FALSE)   # dir.create() makes a folder called data if it is missing
write_csv(students, "data/students_clean.csv")    # write the tibble to a file
file.exists("data/students_clean.csv")            # file.exists() returns TRUE if the file is there
list.files("data")                                # list.files() shows what the folder contains


###############################
# 13)  SEVERAL FILES AT ONCE (for reference)
#      Data split over several files can be read in one call.
###############################
sales_files <- c("https://pos.it/r4ds-01-sales",   # c() combines three paths into one vector: January
                 "https://pos.it/r4ds-02-sales",   # February; the comma continues the list
                 "https://pos.it/r4ds-03-sales")   # March; the closing ) ends the c() call
sales <- read_csv(sales_files, id = "file")   # id = "file" adds a column saying which file each row came from
head(sales)                                   # inspect the combined table


###############################
# 14)  OTHER FILE TYPES (for reference, do not run)
###############################
# read_csv2("file.csv")               # semicolon-separated. Common in Norway (Excel exports)
# read_tsv("file.tsv")                # tab-separated
# read_delim("file.txt", delim = "|") # any separator, given with delim =
# readxl::read_excel("file.xlsx")     # Excel workbooks. readxl:: names the package explicitly


############################################################
#  WHAT YOU CAN DO NOW
#    * store values in objects, combine them with c()
#    * call a function with named or positional arguments
#    * install and load a package
#    * read a CSV from the web or from disk, by three routes
#    * report its size, names, types and summary
#  Lecture 4 (Friday): the dplyr verbs filter, select, mutate,
#  arrange, group_by, summarise. That is Assignment 1, Problems 5 and 6.
############################################################
