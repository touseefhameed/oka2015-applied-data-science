############################################################
#  OKA2015 Applied Data Science, University of Inland Norway
#  LECTURE 11, Tuesday 3 November 2026
#  MULTIPLE REGRESSION, LOGISTIC REGRESSION AND K-NEAREST NEIGHBOURS
#  Touseef Hameed, touseef.hameed@inn.no
#
#  COVERED TODAY (Business Analytics, Chapters 8 and 10; Tidyverse Skills, Chapter 5)
#    0)  Packages and the data: bloodpress.csv, mtcars, iris
#    1)  Multiple linear regression: more than one x
#    2)  Inference: t-tests, the F-test, R-squared and adjusted R-squared
#    3)  Multicollinearity: correlated x variables, VIF
#    4)  Logistic regression: predicting a yes/no outcome
#    5)  k-nearest neighbours (kNN), and train and test
#
#  HOW TO USE THIS FILE
#    Open lecture11.Rproj, then this file. Put the cursor on a line and press
#    Ctrl + Enter (Cmd + Enter on a Mac). Work through the file from the top.
#    Everything after a # is a comment: R ignores it, you read it.
#
#  SYMBOLS USED IN THIS FILE
#    <-     assignment: put the value on the right into the name on the left
#    |>     the pipe: pass the result on the left into the function on the right; read it as "then"
#    $      one column of a table, as a vector: bp$BP
#    =      inside a function call, names an argument or a new column: data = bp
#    ~      "explained by": BP ~ Age + Weight means BP explained by Age and Weight
#    +      in a formula, "and": Age + Weight; inside ggplot() it adds a layer
#    ==     "is equal to?", gives TRUE or FALSE
#    >      "is greater than?", gives TRUE or FALSE
############################################################


###############################
# 0)  PACKAGES AND THE DATA
#     install.packages() is needed ONCE per computer; library() EVERY session.
#       tidyverse    ggplot2 and dplyr
#       broom        tidy() and glance(): model results as tables
#       GGally       ggpairs(): all scatter plots and correlations at once (Lecture 7)
#       car          vif(): measures multicollinearity. New today
#       class        knn(): k-nearest neighbours. New today; it comes with R
###############################
install.packages("tidyverse")        # once per computer. Installed in Lecture 3
install.packages("broom")            # once per computer. Installed in Lecture 10
install.packages("GGally")           # once per computer. Installed in Lecture 7
install.packages("car")              # once per computer. New today
install.packages("class")            # once per computer. New today
library(tidyverse)                   # loads ggplot2, dplyr and the rest
library(broom)                       # loads tidy() and glance()
library(GGally)                      # loads ggpairs()
library(car)                         # loads vif()
library(class)                       # loads knn()

bp <- read_csv("data/bloodpress.csv")  # 20 patients with high blood pressure
glimpse(bp)                          # 20 rows, 7 columns, all numbers
# BP      blood pressure (mm Hg)           the y we want to explain
# Age     age (years)
# Weight  weight (kg)
# BSA     body surface area (square metres)
# Dur     years since the diagnosis of high blood pressure
# Pulse   pulse (beats per minute)
# Stress  stress score from a questionnaire


###############################
# 1)  MULTIPLE LINEAR REGRESSION: MORE THAN ONE x
#     Lecture 10:  y = alpha + beta x + error            (one x)
#     Today:       y = alpha + beta1 x1 + beta2 x2 + ... + error
#     Each beta is the change in y when its x goes up by 1,
#     HOLDING THE OTHER x VARIABLES CONSTANT.
###############################
fit2 <- lm(BP ~ Age + Weight, data = bp)  # BP explained by Age and Weight
summary(fit2)                        # the estimates, standard errors, p-values, R-squared
# Estimated equation:  BP = -16.58 + 0.708 x Age + 1.033 x Weight
# Age:    one year older, same weight     -> BP about 0.71 mm Hg higher
# Weight: one kg heavier, same age        -> BP about 1.03 mm Hg higher

predict(fit2, newdata = tibble(Age = 50, Weight = 95))  # BP for a 50-year-old who weighs 95 kg: 117.0


###############################
# 2)  INFERENCE: HOW SURE ARE WE?
#     t-test for each beta:  H0: beta = 0  (this x does not help, given the others)
#     F-test for the model:  H0: all betas = 0  (no x helps at all)
#     Decision rule: p-value < 0.05  ->  reject H0
###############################
fit6 <- lm(BP ~ Age + Weight + BSA + Dur + Pulse + Stress, data = bp)  # all six x variables
summary(fit6)                        # Age, Weight, BSA significant; Dur, Pulse, Stress not
tidy(fit6)                           # the same coefficient table as a tibble
# F-statistic 560.6 on 6 and 13 DF, p-value 6.4e-15: the model as a whole is significant

glance(fit2)                         # R-squared 0.9914, adjusted 0.9904
glance(fit6)                         # R-squared 0.9962, adjusted 0.9944
# R-squared never goes down when we add an x, even a useless one.
# Adjusted R-squared subtracts a penalty for each extra x,
# so use it to compare models with a different number of x variables.


###############################
# 3)  MULTICOLLINEARITY: WHEN THE x VARIABLES MOVE TOGETHER
#     If two x variables are strongly correlated, the model cannot tell
#     their effects apart: standard errors grow and estimates become unstable.
###############################
bp |>
  select(Age, Weight, BSA, Dur, Pulse, Stress) |>  # the six x variables
  ggpairs()                          # scatter plots below, correlations above
bp |>
  select(Age, Weight, BSA, Dur, Pulse, Stress) |>  # the six x variables
  cor() |>                           # the correlation matrix
  round(2)                           # two decimals. Weight and BSA: 0.88

vif(fit6)                            # variance inflation factor, one per x
# VIF = 1: no problem.  VIF above 5: worry.  VIF above 10: serious.
# Weight 8.4 and BSA 5.3: weight and body surface area measure almost the same thing

fit5 <- lm(BP ~ Age + Weight + Dur + Pulse + Stress, data = bp)  # the same model without BSA
vif(fit5)                            # all VIFs now below 5
glance(fit5)                         # adjusted R-squared 0.992: almost nothing lost


###############################
# 4)  LOGISTIC REGRESSION: PREDICTING YES OR NO
#     y has two values, 1 (yes) and 0 (no). The model gives the
#     PROBABILITY that y = 1, always between 0 and 1 (an S-shaped curve).
#     Data: mtcars (comes with R), 32 cars.
#       am = 1 manual gearbox, am = 0 automatic;  wt = weight in 1000 lbs
###############################
glimpse(mtcars)                      # 32 cars, 11 columns
logit <- glm(am ~ wt, data = mtcars, family = binomial)  # glm with family = binomial is logistic regression
summary(logit)                       # wt: -4.02, p = 0.005
# The sign is what we read: heavier cars are LESS likely to be manual.

cars <- mtcars |>
  mutate(prob = predict(logit, type = "response"),  # type = "response" gives probabilities
         pred = if_else(prob > 0.5, 1, 0))          # cut-off 0.5: above it, predict manual

cars |>
  select(wt, am, prob, pred) |>      # the columns we need
  head()                             # first six cars

predict(logit, newdata = tibble(wt = 3), type = "response")  # a car of 3000 lbs: probability 0.49

cars |>
  count(am, pred)                    # the confusion matrix: actual am against predicted
cars |>
  summarise(accuracy = mean(am == pred))  # share predicted correctly: 0.91 (29 of 32)


###############################
# 5)  K-NEAREST NEIGHBOURS, AND TRAIN AND TEST
#     kNN: to classify a new point, find the k closest known points
#     (straight-line distance) and take the most common class among them.
#     Distance between two points: sqrt((x1 - x1')^2 + (x2 - x2')^2)
###############################

# 5a) BY HAND: WHICH T-SHIRT SIZE FOR A NEW CUSTOMER OF 162 CM AND 58 KG?
shirts <- tibble(
  height = c(158, 158, 158, 160, 160, 163, 163, 160, 163,
             165, 165, 165, 168, 168, 168, 170, 170, 170),  # height in cm
  weight = c(58, 59, 63, 59, 60, 60, 61, 64, 64,
             61, 62, 65, 62, 63, 66, 63, 64, 68),            # weight in kg
  size   = c("M", "M", "M", "M", "M", "M", "M", "L", "L",
             "L", "L", "L", "L", "L", "L", "L", "L", "L"))   # T-shirt size of 18 known customers

shirts |>
  mutate(distance = sqrt((height - 162)^2 +
                         (weight - 58)^2)) |>  # distance from the new customer to each known one
  arrange(distance) |>               # closest first
  slice_head(n = 5)                  # the 5 nearest (k = 5): all wear M, so we predict M

# 5b) TRAIN AND TEST, AND kNN WITH knn()
#     Train: the model learns on 80% of the rows.
#     Test:  we check it on the other 20%, rows it has never seen.
#     Data: iris (comes with R), 150 flowers of three species.
flowers <- iris |>
  mutate(id = row_number())          # a number for every flower, to split by

set.seed(2026)                       # makes the random split the same every time
train <- flowers |>
  slice_sample(prop = 0.8)           # a random 80%: 120 flowers
test <- flowers |>
  anti_join(train, by = "id")        # the other 20%: 30 flowers

ggplot(train, aes(x = Petal.Length, y = Petal.Width, colour = Species)) +
  geom_point() +                     # the training flowers
  labs(x = "Petal length (cm)", y = "Petal width (cm)")

train_x <- train |>
  select(Petal.Length, Petal.Width)  # the x variables of the training flowers
test_x <- test |>
  select(Petal.Length, Petal.Width)  # the x variables of the test flowers

set.seed(2026)                       # knn() breaks ties at random
pred5 <- knn(train = train_x, test = test_x, cl = train$Species, k = 5)  # k = 5 neighbours

test <- test |>
  mutate(pred = pred5)               # add the predicted species to the test table
test |>
  count(Species, pred)               # the confusion matrix
test |>
  summarise(accuracy = mean(Species == pred))  # share of test flowers classified correctly: 0.97 (29 of 30)

# How to choose k: try a few values and keep the one with the best test accuracy.
# Small k follows every single point (overfitting risk); large k smooths too much.
# Petal length and width are both in cm. With x variables in different units,
# put them on the same scale first, or the large numbers dominate the distance.

# End of script
