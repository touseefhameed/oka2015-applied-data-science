############################################################
#  OKA2015 Applied Data Science, University of Inland Norway
#  LECTURE 4, Friday 18 September 2026
#  DATA LAB: IMPORTING AND TRANSFORMING DATA WITH dplyr, PART 1: ROWS
#  Touseef Hameed, touseef.hameed@inn.no
#
#  COVERED TODAY (R for Data Science, Chapter 3, up to the end of "Rows")
#    0)  Packages and the data: nycflights13::flights, a tibble
#    1)  Quick inspection: View, print, head, glimpse, column types, $
#    2)  The operators a condition is built from, the pipe, and na.rm
#    3)  Rows: filter(), with &, |, %in%, is.na(), and the two common mistakes
#    4)  Rows: arrange() and desc()
#    5)  Rows: distinct() and count()
#    Columns and groups follow in the next lectures.
#
#  HOW TO USE THIS FILE
#    Open it in RStudio. Put the cursor on a line and press Ctrl + Enter
#    (Cmd + Enter on a Mac). The line runs in the Console, and the cursor
#    moves to the next line. Work through the file from the top. Everything
#    after a # is a comment: R ignores it, you read it.
#
#  SYMBOLS USED IN THIS FILE
#    <-     assignment: put the value on the right into the name on the left
#    |>     the pipe: pass the result on the left into the function on the right; read it as "then"
#    ==     "is equal to", a comparison. One = alone means something else (section 3)
#    !=     "is not equal to"
#    >  >=  <  <=   greater than, greater or equal, less than, less or equal
#    &      AND, both conditions must hold
#    |      OR, at least one condition must hold
#    !      NOT, reverses TRUE and FALSE
#    %in%   "is one of": month %in% c(1, 2) is TRUE for January and February
#    :      a range: 7:9 is 7 8 9
#    $      one column of a table, as a vector: flights$dep_delay
#    ::     "the object from that package": nycflights13::flights
#    =      inside a function call, names an argument
############################################################


###############################
# 0)  PACKAGES AND THE DATA
#     install.packages() downloads a package. Run it ONCE per computer;
#     running it again does no harm, it only takes time. Needs internet.
#     library() loads the package. Run it EVERY session.
#       tidyverse    gives dplyr (the verbs, and glimpse), readr (read_csv), tibble, ...
#       nycflights13 gives the flights dataset
###############################
#install.packages("tidyverse")        # once per computer. Installed in Lecture 3; harmless to repeat
install.packages("nycflights13")     # once per computer. New today
library(tidyverse)                   # loads dplyr, readr, ggplot2 and the rest, as in Lecture 3
library(nycflights13)                # loads the datasets: flights, airlines, airports, planes, weather

# library(tidyverse) prints a "Conflicts" note: dplyr::filter() masks stats::filter().
# Two packages have a function called filter. The tidyverse one wins. To be explicit,
# write packagename::function(): dplyr::filter() keeps rows; stats::filter() is for time series.

flights <- nycflights13::flights     # the dataset, copied into an object called flights.
                                     # :: reads "flights from the package nycflights13"
# In Lecture 3 the data came from a CSV file with read_csv(). A package that ships its
# data is a fourth way to get data into R. Everything that follows is the same whichever way you used.


###############################
# 0A) QUICK HELP, built in, no internet needed
###############################
# ?filter                  # remove the # to open the help page of one function
# ?flights                 # the help page of the dataset: what every column means
# ??"missing values"       # search the help system by keyword
# help(package = "dplyr")  # the index of a package


###############################
# 1)  QUICK INSPECTION: LOOK BEFORE YOU TOUCH
#     A tibble prints only the first rows and the columns that fit.
#     Four ways to see more: View, print with width = Inf or n = Inf, glimpse.
###############################
flights                            # typing the name prints the tibble: 10 rows, the columns that fit
# View(flights)                    # remove the # for the spreadsheet viewer in RStudio. Capital V
# print(flights, width = Inf)      # all columns in the Console. Inf = infinity, no limit
# print(flights, n = Inf)          # all rows: 336,776 lines in the Console. Use with care
head(flights, 5)                   # the first 5 rows
nrow(flights)                      # 336776 rows: one per flight that left New York in 2013
ncol(flights)                      # 19 columns
glimpse(flights)                   # every column on its own line: name, type, first values

# The column types printed by glimpse():
#   <int>  integer, whole numbers        (month, day, dep_time)
#   <dbl>  double, numbers with decimals (dep_delay, distance)
#   <chr>  character, text               (carrier, origin, dest)
#   <dttm> date-time                     (time_hour)
# The type decides what you can do with a column: arithmetic on numbers, comparisons on all.
# Delays are in minutes; a negative departure delay means the flight left early.
# dep_time 517 means 05:17. NA in dep_delay means the flight was cancelled.

head(flights$dep_delay)            # $ pulls ONE column out as a plain vector; head() shows the first 6
mean(flights$distance)             # a vector goes straight into mean(), sum(), max(): 1040 miles


###############################
# 2)  OPERATORS, THE PIPE, AND na.rm
###############################
# 2.1 Comparison: gives TRUE or FALSE. Arithmetic (+ - * / ^) was Lecture 3.
3 == 3                             # TRUE : "is equal to". TWO equals signs
3 != 4                             # TRUE : "is not equal to"
5 > 2                              # TRUE
2 >= 2                             # TRUE : greater or equal
"JFK" == "jfk"                     # FALSE: text is compared exactly, capitals matter

# 2.2 Logical: combine TRUE/FALSE values
TRUE & FALSE                       # FALSE: AND needs both
TRUE | FALSE                       # TRUE : OR needs at least one
!TRUE                              # FALSE: NOT flips it

# 2.3 Membership: %in%, "is one of"
2 %in% c(1, 2, 3)                  # TRUE
"JFK" %in% c("JFK", "LGA", "EWR")  # TRUE. Quotes make text; c() makes the set
7:9                                # 7 8 9, a range; month %in% 7:9 is "July to September"

# 2.4 The pipe |>  (Ctrl + Shift + M in RStudio)
#     x |> f(y) means f(x, y): take x, THEN apply f to it. Read it as "then".
#     %>% is the older pipe from the magrittr package; for this course the two are the same.
sqrt(16)                           # 4, the usual way: the function wraps its argument
16 |> sqrt()                       # 4, the same: 16, THEN take the square root
flights |> nrow()                  # 336776: flights, THEN count the rows

# 2.5 A first pipeline, and na.rm
flights |>                                   # take the flights, THEN
  filter(month == 1) |>                      # keep January, THEN
  summarise(avg_delay = mean(dep_delay))     # average the departure delay. Result: NA. Why?
# Two different signs: inside summarise(), = gives the result a NAME (avg_delay).
# Outside a function call, <- stores an OBJECT (flights <- ...). They are not interchangeable.
# mean(), sum(), max() return NA if ANY value is missing, and cancelled flights have no delay.
v <- c(1, 2, NA, 4)                # a small vector with one missing value
mean(v)                            # NA: one missing value spoils the result
mean(v, na.rm = TRUE)              # 2.333: the mean of 1, 2 and 4. na.rm = "remove NA" for this calculation
flights |>
  filter(month == 1) |>
  summarise(avg_delay = mean(dep_delay, na.rm = TRUE))   # 10.0 minutes: January flights left 10 minutes late on average
# na.rm skips the missing values inside one calculation. The data itself is unchanged.

# WHAT EVERY dplyr VERB SHARES
#   1. The first argument is a data frame. The pipe supplies it.
#   2. The next arguments say which columns to use, by bare name, no quotes.
#   3. The result is a NEW data frame. The input is never changed.
filter(flights, month == 1)          # verb(data, condition): the same as ...
flights |> filter(month == 1)        # ... this. The pipe puts flights into the first slot


###############################
# 3)  ROWS: filter() KEEPS THE ROWS THAT MEET A CONDITION
###############################
flights |> filter(dep_delay > 120)               # departed more than 120 minutes late: 9723 rows, all 19 columns
flights |> filter(month == 1 & day == 1)         # AND: January AND the first: 842 rows, New Year's Day
flights |> filter(month == 1 | month == 2)       # OR: January OR February: 51955 rows
flights |> filter(month %in% c(1, 2))            # "is one of": the same 51955 rows, shorter to write
flights |> filter(dest == "IAH")                 # text is compared in quotes: flights to Houston, 7198 rows
flights |> filter(dest != "IAH")                 # != is "not equal": every other destination
flights |> filter(is.na(dep_delay))              # is.na() is TRUE where the value is missing: 8255 cancelled flights
flights |> filter(!is.na(dep_delay))             # ! flips it: the 328521 flights that actually departed

# Two common mistakes
# flights |> filter(month = 1)       # ERROR: one = does not compare. R stops and suggests ==
# flights |> filter(month == 1 | 2)  # NO ERROR but wrong: R reads (month == 1) | 2, and 2 counts as TRUE,
#                                    # so all 336776 rows pass. Write month == 1 | month == 2, or month %in% c(1, 2)

# filter() does not change flights. To keep a result, assign it a name with <-
jan1 <- flights |> filter(month == 1 & day == 1)   # jan1 holds the 842 rows; a new object appears in the Environment
nrow(flights)                                      # still 336776: the original is untouched
nrow(jan1)                                         # 842


###############################
# 4)  ROWS: arrange() SORTS
###############################
flights |> arrange(dep_delay)                # ascending: the earliest departures first (negative = left early, -43)
flights |> arrange(desc(dep_delay))          # desc() = descending: the longest delay first, 1301 minutes on 9 January
flights |> arrange(year, month, day, dep_time)   # several columns: earliest year first; within a year the earliest
                                                 # month (January before December); within a month the earliest day;
                                                 # within a day the earliest departure (05:00 before 22:00). Chronological
flights |> arrange(desc(dep_time))               # desc() wraps exactly ONE column: latest departure time first
flights |> arrange(desc(arr_delay), dep_time)    # worst arrival delay first, ties by departure time
flights |> arrange(desc(distance)) |> glimpse()  # distance is off-screen in the normal printout; glimpse() shows
                                                 # every column of the top rows: dest "HNL", distance 4983
# arrange() changes the ORDER of rows, never their number. Still 336776.


###############################
# 5)  ROWS: distinct() AND count()
###############################
flights |> distinct(origin, dest)                  # every unique origin-destination pair, once: 224 routes
flights |> distinct(origin, dest, .keep_all = TRUE)   # .keep_all = TRUE keeps the other columns too (first occurrence)
flights |> distinct(year, month, day) |> nrow()    # how many different days had a flight: 365, every day of the year
flights |> count(origin, dest, sort = TRUE)        # how many flights per route; sort = TRUE puts the busiest first: JFK-LAX, 11262
flights |> count(dest, sort = TRUE)                # flights per destination: Chicago O'Hare (ORD) 17283, Atlanta 17215
flights |> count(month)                            # flights per month, in month order
# count() is the first question to ask of any text column: which values occur, and are any of them typos?


############################################################
#  CHECK YOURSELF (R for Data Science, Ch. 3, exercises on rows; answers in the practice exercise)
#    1) Flights with an arrival delay of two or more hours
#    2) Flights that flew to Houston: "IAH" or "HOU"
#    3) Flights operated by United, American or Delta: "UA", "AA", "DL"
#    4) Flights that departed in summer: July, August, September
#    5) Flights that arrived more than two hours late but did not leave late
#    6) Sort flights to find the longest departure delays; then the flights that left earliest in the morning
#    7) Was there a flight on every day of 2013?
#    8) Which flights travelled the farthest? Which the least?
#
#  WHAT YOU CAN DO NOW
#    * see a table: print, View, head, glimpse, $
#    * write a condition with == != > >= < <= & | ! %in% is.na()
#    * chain steps with the pipe |> and read them as "then"
#    * rows: filter(), arrange() with desc(), distinct(), count()
#    * keep a result with <-, and know that a verb never changes its input
#  The next lectures continue with dplyr: columns, then groups.
############################################################
