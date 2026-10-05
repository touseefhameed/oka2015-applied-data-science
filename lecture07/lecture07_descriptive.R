############################################################
#  OKA2015 Applied Data Science, University of Inland Norway
#  LECTURE 7, Tuesday 6 October 2026
#  DESCRIPTIVE STATISTICS AND EXPLORATORY ANALYSIS
#  Touseef Hameed, touseef.hameed@inn.no
#
#  COVERED TODAY (Business Analytics, Chapter 2)
#    0)  Packages and the data: flights and weather from nycflights13
#    1)  Types of data: population and sample, quantitative and
#        categorical, cross-sectional and time series
#    2)  Distributions: frequency tables, histograms, shape
#    3)  Central tendency: mean, median, mode
#    4)  Variability: range, variance, standard deviation, quartiles, IQR
#    5)  Outliers: the IQR rule, boxplots, z-scores, data entry errors
#    6)  Association between two variables: scatter plots,
#        covariance, correlation
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
#    $      one column of a table, as a vector: flights$dep_delay
#    ::     "the object from that package": nycflights13::flights
#    c()    combine values into a vector: c(3, 7, 2)
#    =      inside a function call, names an argument or a new column
############################################################


###############################
# 0)  PACKAGES AND THE DATA
#     install.packages() downloads a package. Run it ONCE per computer;
#     running it again does no harm, it only takes time. Needs internet.
#     library() loads the package. Run it EVERY session.
#       tidyverse    gives dplyr (the verbs), readr, tibble, ...
#       nycflights13 gives the flights and weather tables
#       GGally       gives ggpairs(), a matrix of plots for several columns (section 6)
###############################
install.packages("tidyverse")        # once per computer. Installed in Lecture 3
install.packages("nycflights13")     # once per computer. Installed in Lecture 4
install.packages("GGally")           # once per computer. New today
library(tidyverse)                   # loads dplyr, readr, ggplot2 and the rest
library(nycflights13)                # loads flights, weather, airlines, airports, planes
library(GGally)                      # loads ggpairs()

flights <- nycflights13::flights     # 336,776 flights out of New York in 2013, as in Lectures 4 to 6
weather <- nycflights13::weather     # hourly weather at the three New York airports in 2013
glimpse(weather)                     # 26,115 rows: temperature, humidity, wind, pressure, visibility


###############################
# 1)  TYPES OF DATA
###############################
# 1.1 Population and sample
#     Population: every element of interest. Sample: a subset of it.
#     flights is the population of all 2013 departures from New York.
#     slice_sample() draws a random sample. set.seed() fixes the random draw,
#     so everyone in the room gets the same sample.
set.seed(2026)                                     # any number; the same number gives the same sample
flights_sample <- flights |> slice_sample(n = 1000)   # 1,000 flights drawn at random
mean(flights$dep_delay, na.rm = TRUE)              # population mean: 12.6 minutes
mean(flights_sample$dep_delay, na.rm = TRUE)       # sample mean: 12.9 minutes, close to it
# A different sample gives a slightly different mean. A random sample is
# representative: on average it tells the truth about the population.

# 1.2 Quantitative and categorical
#     Quantitative: numbers you can add and average (<int>, <dbl>).
#       discrete: counts, whole numbers (month, number of passengers)
#       continuous: measurements, any value (distance, air_time)
#     Categorical: labels you can only count (<chr>, <fct>).
#       nominal: no order (carrier, origin, dest)
#       ordinal: an order (low < medium < high, a 1 to 5 rating)
flights |> select(carrier, origin, month, dep_delay, distance) |> glimpse()   # the type under each name tells you which kind

# 1.3 Cross-sectional and time series
#     Cross-sectional: many units at one point in time.
#     Time series: one quantity measured over many time periods.
flights |> filter(month == 1, day == 1)    # cross-section: the 842 flights of 1 January
flights |> count(month)                    # time series: flights per month, January to December


###############################
# 2)  DISTRIBUTIONS
#     A distribution shows which values a variable takes, and how often.
###############################
# 2.1 Categorical: a frequency table, with percentages
flights |>
  count(carrier, sort = TRUE) |>                  # frequency: how many flights per airline
  mutate(percent = round(100 * n / sum(n), 1))    # percent frequency: share of all flights. UA 17.4%

# 2.2 Quantitative: a histogram
#     hist() splits the range into bins and draws one bar per bin.
#     breaks = the number of bins; xlim = the part of the x-axis to show.
hist(flights$dep_delay)                                       # one tall bar: most delays are small, a few are huge
hist(flights$dep_delay, breaks = 200, xlim = c(-50, 300))     # more bins, zoomed in: a long tail to the right

# 2.3 Three shapes
hist(weather$pressure)      # symmetric: the left side mirrors the right. Mean 1017.9, median 1017.6
hist(flights$dep_delay, breaks = 200, xlim = c(-50, 300))   # skewed right: tail to the right. Mean 12.6 > median -2
hist(weather$visib)         # skewed left: tail to the left. Mean 9.3 < median 10
# Rule of thumb: skewed right, mean > median; skewed left, mean < median; symmetric, mean = median.


###############################
# 3)  CENTRAL TENDENCY: WHERE IS THE MIDDLE?
###############################
# 3.1 By hand, on seven numbers: the books seven students read
books <- c(3, 7, 2, 9, 7, 5, 7)
mean(books)                   # mean: sum / count = 40 / 7 = 5.71
median(books)                 # median: the middle value once sorted (2 3 5 7 7 7 9): 7
tibble(books) |> count(books, sort = TRUE)   # mode: the most frequent value. R has no mode() for this; count() gives it: 7, three times

# 3.2 On real data
mean(flights$dep_delay, na.rm = TRUE)       # 12.6 minutes. na.rm = TRUE skips the cancelled flights
median(flights$dep_delay, na.rm = TRUE)     # -2 minutes: the typical flight left two minutes EARLY
flights |> count(dep_delay, sort = TRUE)    # mode: -5 minutes, 24,821 flights
# The mean is pulled up by a few very late flights. For skewed data, the median describes the typical case.

# 3.3 By group: the same measures for each origin airport
flights |>
  group_by(origin) |>                                  # one group per airport, as in Lecture 6
  summarise(mean   = mean(dep_delay, na.rm = TRUE),    # average delay
            median = median(dep_delay, na.rm = TRUE),  # typical delay
            n      = n())                              # how many flights: always report it
# EWR has the highest mean (15.1). All three medians are negative: most flights leave on time.

# 3.4 Which value to fill a missing value with (Lectures 5 and 6 showed how)
#     symmetric quantitative -> mean      skewed quantitative -> median      categorical -> mode
weather_filled <- weather |>
  mutate(pressure = replace_na(pressure, mean(pressure, na.rm = TRUE)))   # pressure is symmetric: the mean is fine
sum(is.na(weather$pressure))           # 2,729 missing before
sum(is.na(weather_filled$pressure))    # 0 after
flights_filled <- flights |>
  mutate(dep_delay = replace_na(dep_delay, median(dep_delay, na.rm = TRUE)))   # dep_delay is skewed: use the median
flights |> count(carrier, sort = TRUE) |> slice(1)    # the mode of a categorical column: UA
# Filling changes the data. Do it only with a reason, and say so in your report.


###############################
# 4)  VARIABILITY: HOW SPREAD OUT ARE THE VALUES?
###############################
# 4.1 By hand, on five exam scores
scores <- c(70, 75, 80, 85, 90)
tibble(scores) |>
  mutate(deviation = scores - mean(scores),      # distance from the mean (80)
         squared   = deviation^2)                # squared, so that minus and plus do not cancel
# sum of squared deviations = 100 + 25 + 0 + 25 + 100 = 250
var(scores)          # variance: 250 / (5 - 1) = 62.5. We divide by n - 1 for a sample
sd(scores)           # standard deviation: the square root of the variance, 7.9, in the units of the data
range(scores)        # smallest and largest value: 70 and 90. The range is 90 - 70 = 20

# 4.2 On real data
sd(flights$dep_delay, na.rm = TRUE)          # 40.2 minutes
var(flights$dep_delay, na.rm = TRUE)         # 1616.8 squared minutes: hard to read, so we report the sd
range(flights$dep_delay, na.rm = TRUE)       # -43 to 1301 minutes
sd(flights$dep_delay, na.rm = TRUE) / mean(flights$dep_delay, na.rm = TRUE)   # coefficient of variation: sd / mean = 3.2

# 4.3 Percentiles, quartiles, IQR
#     The p-th percentile: p% of the values lie below it.
#     Quartiles: the 25th (Q1), 50th (Q2, the median) and 75th (Q3) percentiles.
#     IQR = Q3 - Q1: the spread of the middle 50%. Not moved by extreme values.
quantile(flights$dep_delay, c(0.25, 0.50, 0.75), na.rm = TRUE)   # Q1 -5, median -2, Q3 11
IQR(flights$dep_delay, na.rm = TRUE)                              # 11 - (-5) = 16 minutes
summary(flights$dep_delay)       # min, Q1, median, mean, Q3, max, and the number of NA, in one line


###############################
# 5)  OUTLIERS
#     An outlier is a value far from the rest. It can be an error, or a
#     real but rare case. Find it, explain it, and only then decide.
###############################
# 5.1 The IQR rule, which the boxplot uses
#     lower fence = Q1 - 1.5 * IQR = -5 - 24 = -29
#     upper fence = Q3 + 1.5 * IQR = 11 + 24 =  35
#     Values outside the fences are flagged.
boxplot(flights$dep_delay)                           # box = Q1 to Q3, thick line = median, dots = flagged values
boxplot(flights$dep_delay, ylim = c(-50, 150))       # zoomed in, to see the box
flights |> filter(dep_delay < -29 | dep_delay > 35) |> nrow()   # 43,216 flights flagged, nearly all late ones
# A flag is not a verdict. In skewed data the rule flags many real, if unusual, flights.

# 5.2 The z-score rule
#     z = (value - mean) / sd: how many standard deviations a value lies from the mean.
#     |z| > 3 is a common flag. Works best for bell-shaped data.
m <- mean(flights$dep_delay, na.rm = TRUE)   # store the mean ...
s <- sd(flights$dep_delay, na.rm = TRUE)     # ... and the standard deviation
flights |>
  mutate(z = (dep_delay - m) / s) |>         # a new column: the z-score of every flight
  filter(abs(z) > 3) |>                      # abs() removes the sign: both tails
  nrow()                                     # 7,928 flights more than 3 sd from the mean

# 5.3 A real data entry error
weather |> arrange(desc(wind_speed)) |> select(origin, month, day, hour, wind_speed)   # 1048 mph: impossible
boxplot(weather$wind_speed)              # one dot far above everything else
# A hurricane is about 75 mph. 1048 mph is a recording error. Remove it, and write down that you did:
weather_clean <- weather |> filter(wind_speed < 200 | is.na(wind_speed))
nrow(weather) - nrow(weather_clean)      # 1 row removed
# The 1301-minute delay, by contrast, is real (Hawaiian flight, 9 January). Keep it.


###############################
# 6)  ASSOCIATION BETWEEN TWO VARIABLES
###############################
# 6.1 Scatter plot: one dot per observation, x against y. A sample keeps it fast.
plot(flights_sample$distance, flights_sample$air_time)     # longer flights take longer: a tight upward line
plot(flights_sample$dep_delay, flights_sample$arr_delay)   # late departure, late arrival: upward
plot(flights_sample$distance, flights_sample$dep_delay)    # no pattern: distance says nothing about delay

# 6.2 Covariance: the direction of the relationship, but in awkward units
cov(flights$distance, flights$air_time, use = "complete.obs")   # 68,301 mile-minutes. Positive: they move together
cov(flights$distance * 1.609, flights$air_time, use = "complete.obs")   # in km: 109,897. Same relationship, new number
# use = "complete.obs" drops rows with an NA in either column.

# 6.3 Correlation: covariance rescaled to lie between -1 and +1, with no units
cor(flights$distance, flights$air_time, use = "complete.obs")    #  0.99: strong positive
cor(flights$dep_delay, flights$arr_delay, use = "complete.obs")  #  0.91: strong positive
cor(flights$distance, flights$dep_delay, use = "complete.obs")   # -0.02: none
# +1 perfect positive, 0 no linear relationship, -1 perfect negative.

# 6.4 Several columns at once
flights |>
  select(dep_delay, arr_delay, air_time, distance) |>   # the numeric columns of interest
  cor(use = "complete.obs") |>                          # a correlation matrix: every pair
  round(2)                                              # two decimals
flights_sample |>
  select(dep_delay, arr_delay, distance) |>   # three numeric columns
  ggpairs()                                   # scatter plots, densities and r in one picture
# Correlation is not causation. Late departures and late arrivals move together,
# but correlation alone cannot tell us why. That needs more than these numbers.


############################################################
#  CHECK YOURSELF (answers in the practice exercise)
#    1) Is ocean_proximity in the housing data quantitative or categorical? Nominal or ordinal?
#    2) Mean 250,000, median 180,000. Which way is the distribution skewed?
#    3) Why do we report the standard deviation, not the variance?
#    4) Q1 = 10, Q3 = 30. Where are the IQR fences?
#    5) Two columns have correlation -0.85. What does a scatter plot look like?
#
#  WHAT YOU CAN DO NOW
#    * name the type of a variable and of a dataset
#    * describe a distribution: frequency table, histogram, shape
#    * report the centre (mean, median, mode) and the spread (sd, IQR)
#    * flag outliers with the IQR rule and z-scores, and decide what to do
#    * describe two variables together with a scatter plot and a correlation
############################################################
