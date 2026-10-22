############################################################
#  OKA2015 Applied Data Science, University of Inland Norway
#  LECTURE 10, Thursday 22 October 2026
#  DATA MINING AND SIMPLE LINEAR REGRESSION
#  Touseef Hameed, touseef.hameed@inn.no
#
#  COVERED TODAY (Business Analytics, Chapter 8; Tidyverse Skills, Chapter 5.7)
#    0)  Packages and the data: trees (built into R)
#    1)  Data mining: describing and predicting
#    2)  A first look at two variables: scatter plot and correlation
#    3)  Fitting the line: lm(), the estimates, fitted values, residuals, predictions
#    4)  How sure are we? Standard error and p-value of the estimates
#    5)  How good is the line? R-squared, the error term, check plots, broom tables
#    6)  Correlation and causation
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
#    $      one column of a table, as a vector: trees$Height
#    =      inside a function call, names an argument or a new column: data = trees
#    ~      "explained by": Height ~ Girth means Height explained by Girth
#    +      plus; inside ggplot() it adds the next layer to the plot
#    c()    combine values into a vector: c(2, 2)
############################################################


###############################
# 0)  PACKAGES AND THE DATA
#     install.packages() downloads a package. Run it ONCE per computer;
#     running it again does no harm, it only takes time. Needs internet.
#     library() loads the package. Run it EVERY session.
#       tidyverse    gives ggplot2 (plots) and dplyr (the verbs)
#       broom        gives tidy(), glance() and augment(): model results as tables
###############################
install.packages("tidyverse")        # once per computer. Installed in Lecture 3
install.packages("broom")            # once per computer. New today; it often comes with the tidyverse already
library(tidyverse)                   # loads ggplot2, dplyr and the rest
library(broom)                       # loads tidy(), glance() and augment()

data(trees)                          # trees comes with R itself. data() puts a copy in your Environment pane
glimpse(trees)                       # 31 black cherry trees, 3 columns, all numbers
summary(trees)                       # min, quartiles, mean and max of each column
# Girth  = the trunk DIAMETER in inches, measured 4.5 feet above the ground (1 inch = 2.54 cm).
#          The column is called Girth, but R's help page (?trees) says it is the diameter.
# Height = the height of the tree in feet (1 foot = 0.30 m)
# Volume = the volume of timber in cubic feet


###############################
# 1)  DATA MINING (no code in this section)
#     Data mining: using software to find useful patterns in large amounts of data.
#     Descriptive data mining: there is no answer y to predict. Find groups and patterns.
#       Example: a shop groups its customers by what they buy.
#       Also called unsupervised learning.
#     Predictive data mining: learn from past cases where the answer y is known,
#       then predict y for new cases.
#       Example: predict the price of a house from its size.
#       Also called supervised learning: the known answers guide the learning.
#         y is a number    -> a regression task      (today)
#         y is a category  -> a classification task
#     The names:  y = dependent variable = outcome = target
#                 x = independent variable = predictor = feature
#     Simple linear regression: ONE x, and a STRAIGHT line.
#     The model:  y = alpha + beta * x + error
#       alpha = the intercept: the value of y when x is 0 (where the line crosses the y-axis)
#       beta  = the slope: rise over run. When x goes up by 1, y goes up by beta on average
#       error = everything else that affects y, which the line does not capture
###############################


###############################
# 2)  A FIRST LOOK AT TWO VARIABLES
#     The question: the diameter of a tree is easy to measure; the height of a
#     standing tree is not. Can we predict height from diameter?
#     y = Height (what we want to predict), x = Girth (what we predict it from)
###############################
# 2.1 Scatter plot: always look before you fit
ggplot(trees, aes(x = Girth, y = Height)) +   # x on the horizontal axis, y on the vertical axis
  geom_point()                                 # one dot per tree
# The points go up: thicker trees tend to be taller, but with much scatter.

# 2.2 Correlation (Lecture 7): the direction and the strength, without units
cor(trees$Girth, trees$Height)       # 0.52: positive, moderate


###############################
# 3)  FITTING THE LINE
###############################
# 3.1 lm() fits a linear model. Read the formula as "Height explained by Girth".
#     General form:  lm(y ~ x, data = table)   y: what we predict, x: what we predict it from
fit <- lm(Height ~ Girth, data = trees)    # y ~ x. The fitted model is stored in fit
fit                                        # (Intercept) 62.031   Girth 1.054
# The estimates replace alpha and beta:  Height = 62.03 + 1.054 * Girth
# Slope 1.054: one inch more diameter goes with 1.05 feet more height, on average.
# Intercept 62.03: the height the line gives for a diameter of 0. No tree is that thin
#   (the data run from 8.3 to 20.6 inches), so it has no real meaning; it only positions the line.

# 3.2 Draw the line on the scatter plot
ggplot(trees, aes(x = Girth, y = Height)) +            # the same axes as in 2.1
  geom_point() +                                       # the trees
  geom_smooth(method = "lm", se = FALSE) +             # the straight line that lm() fits. se = FALSE: the line only
  labs(x = "Diameter (inches)", y = "Height (feet)")   # axis titles, as in Lectures 8 and 9
# The message "geom_smooth() using formula = 'y ~ x'" is information, not an error.

# 3.3 Fitted values and residuals
trees_fit <- trees |>                     # a copy of trees with two new columns
  mutate(fitted   = fitted(fit),          # the value on the line: what the line says for that diameter
         residual = residuals(fit))       # actual minus fitted: how far the tree is from the line
head(trees_fit, 3)                        # tree 2: actual 65, fitted 71.1, residual -6.1 (6.1 feet below the line)
# Least squares: lm() picks the line that makes the sum of the squared residuals as small as possible.
# Squared, so that residuals above the line (+) and below it (-) do not cancel.

# 3.4 Predict: the line's answer for a new tree
predict(fit, newdata = tibble(Girth = 15))     # a tree 15 inches across: 77.8 feet
# Predict only inside the range of the data (8.3 to 20.6 inches). Outside it is extrapolation.


###############################
# 4)  HOW SURE ARE WE ABOUT THE ESTIMATES?
#     The 31 trees are a sample. Another 31 trees would give slightly different estimates.
###############################
# 4.1 The full report
summary(fit)                         # the full report on the model
# In the Coefficients table, row Girth (the slope):
#   Estimate    1.0544    the beta estimate
#   Std. Error  0.3222    the standard error: how much the estimate would change from sample to sample
#   t value     3.272     estimate / standard error: the estimate is 3.3 standard errors away from 0
#   Pr(>|t|)    0.00276   the p-value
# The same four numbers for the intercept are in the row (Intercept).

# 4.2 Reading the p-value
#   Suppose diameter and height had no linear relationship at all (a true slope of 0).
#   The p-value is the chance of getting a slope at least this far from 0 in that case.
#   Here 0.0028: fewer than 3 samples in 1,000.
#   Decision rule: p < 0.05 -> the estimate is statistically significant: we conclude
#   that the true slope is not 0. Diameter does tell us something about height.
#   The stars: ** means p is between 0.001 and 0.01.
#   The p-value is NOT the chance that our slope is wrong or "due to chance".

# 4.3 The uncertainty, drawn as a band around the line
ggplot(trees, aes(x = Girth, y = Height)) +   # the same axes as in 2.1
  geom_point() +                               # the trees
  geom_smooth(method = "lm")                   # se = TRUE is the default: the grey band shows where the true line plausibly runs


###############################
# 5)  HOW GOOD IS THE LINE?
###############################
# 5.1 R-squared: the share of the variation in y that the line explains, from 0 to 1
#   summary(fit) says: Multiple R-squared 0.2697
#   27% of the differences in height between the trees go with differences in diameter.
#   The remaining 73% is unexplained: age, soil, light and other things, the error term.
cor(trees$Girth, trees$Height)^2     # 0.27: with one x, R-squared = the correlation squared

# 5.2 Residual standard error: 5.538 feet
#   The typical distance of a tree from the line. Not the same as the standard error of the slope.

# 5.3 The error term and the four conditions
#   The error term collects everything that affects y apart from x. The standard error
#   and the p-value are reliable when:
#   1. linearity: the points follow a straight line, not a curve
#   2. independence: one tree does not affect another (each tree is measured once)
#   3. equal spread: the points are about as far from the line everywhere
#   4. normal residuals: most residuals are small, few are large, roughly symmetric

# 5.4 Check plots
par(mfrow = c(2, 2))      # split the plot window into 2 rows and 2 columns
plot(fit)                 # the four standard check plots of a linear model
par(mfrow = c(1, 1))      # back to one plot per window
#   Look for clear patterns. With 31 trees the red lines always wiggle a little.
#   Residuals vs Fitted     points spread around 0, no clear U or arch   -> a straight line fits
#   Q-Q Residuals           points close to the dotted line              -> residuals roughly normal
#   Scale-Location          the red line roughly flat                    -> the spread is about the same everywhere
#   Residuals vs Leverage   no point beyond the dashed Cook's distance   -> no single tree drives the line
# The trees: no clear U or arch; the Q-Q points follow the line; the Scale-Location line
# falls a little on the right. With 31 trees that is mild, so the conditions roughly hold.

# 5.5 The results as tables, with broom
tidy(fit)                 # the coefficients table as a tibble: estimate, std.error, statistic, p.value
glance(fit)               # one row about the whole model: r.squared, adj.r.squared, sigma, p.value, nobs
augment(fit)              # one row per tree: .fitted (the line) and .resid (the residual), and more


###############################
# 6)  CORRELATION AND CAUSATION
#   Regression measures how x and y move together. It does not prove that x causes y.
#   Thicker trees tend to be taller, but a thicker trunk does not make a tree grow taller.
#   Both grow with age: age is a third variable that drives both. Such a variable is
#   called a confounder.
#   Ice cream sales and sunburn cases rise and fall together. Ice cream does not cause
#   sunburn: hot, sunny days drive both.
#   A cause is shown by a controlled experiment, not by a regression on observed data.
###############################


############################################################
#  CHECK YOURSELF (answers on the slide "Check your understanding")
#    1) In lm(sales ~ advertising, data = shop), which variable is the dependent variable?
#    2) A slope is 2.5 and its standard error is 0.5. What is the t value? Is it far from 0?
#    3) A slope has a p-value of 0.30. What do you conclude?
#    4) R-squared is 0.64 and the slope is positive. What is the correlation?
#    5) The more fire fighters come to a fire, the more damage the fire does. Do the
#       fire fighters cause the damage? What could be the third variable?
#
#  WHAT YOU CAN DO NOW
#    * say what predictive and descriptive data mining are
#    * fit a simple linear regression with lm() and draw it with geom_smooth()
#    * read the intercept and the slope in the units of the data, and predict
#    * read the standard error and the p-value, and apply the decision rule
#    * read R-squared, and check the conditions with the check plots
#    * explain why a strong relationship does not prove cause and effect
############################################################
