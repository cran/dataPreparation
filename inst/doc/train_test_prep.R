## ----results='hide', message=FALSE, warning=FALSE, echo=FALSE-----------------
set.seed(2)
library(dataPreparation)
library(data.table)
library(knitr)
library(kableExtra)
library(pander)
options(knitr.table.format = "html")
Sys.setlocale("LC_TIME", "C")

## ----comment="#",  null_prefix=TRUE-------------------------------------------
data("adult")
print(head(adult, n = 4))

## ----comment="#",  null_prefix=TRUE-------------------------------------------
# Random sample indexes
train_index <- sample(1:nrow(adult), 0.8 * nrow(adult))
test_index <- setdiff(1:nrow(adult), train_index)

# Build X_train, y_train, X_test, y_test
X_train <- adult[train_index, -15]
y_train <- adult[train_index, "income"]

X_test <- adult[test_index, -15]
y_test <- adult[test_index, "income"]

## ----warning = FALSE, comment="#",  null_prefix=TRUE--------------------------
constant_cols <- which_are_constant(adult)
double_cols <- which_are_in_double(adult)
bijections_cols <- which_are_bijection(adult)

## ----warning = FALSE, comment="#",  null_prefix=TRUE--------------------------
X_train$education_num = NULL
X_test$education_num = NULL

## ----warning = FALSE, comment="#",  null_prefix=TRUE--------------------------
scales <- build_scales(data_set = X_train, cols = c("capital_gain", "capital_loss"), verbose = TRUE)
print(scales)

## ----warning = FALSE, comment="#",  null_prefix=TRUE--------------------------
X_train <- fast_scale(data_set = X_train, scales = scales, verbose = TRUE)
X_test <- fast_scale(data_set = X_test, scales = scales, verbose = TRUE)

## ----warning = FALSE, comment="#",  null_prefix=TRUE--------------------------
print(head(X_train[, c("capital_gain", "capital_loss")]))

## ----warning = FALSE, comment="#",  null_prefix=TRUE--------------------------
bins <- build_bins(data_set = X_train, cols = "age", n_bins = 10, type = "equal_freq")
print(bins)

## ----warning = FALSE, comment="#",  null_prefix=TRUE--------------------------
X_train <- fast_discretization(data_set = X_train, bins = list(age = c(0, 18, 25, 45, 62, +Inf)))
X_test <- fast_discretization(data_set = X_test, bins = list(age = c(0, 18, 25, 45, 62, +Inf)))

## ----warning = FALSE, comment="#",  null_prefix=TRUE--------------------------
print(table(X_train$age))

## ----warning = FALSE, comment="#",  null_prefix=TRUE--------------------------
encoding <- build_encoding(data_set = X_train, cols = "auto", verbose = TRUE)

## ----warning = FALSE, comment="#",  null_prefix=TRUE--------------------------
X_train <- one_hot_encoder(data_set = X_train, encoding = encoding, drop = TRUE, verbose = TRUE)
X_test <- one_hot_encoder(data_set = X_test, encoding = encoding, drop = TRUE, verbose = TRUE)

## ----warning = FALSE, comment="#",  null_prefix=TRUE--------------------------
print("Dimensions of X_train: ")
print(dim(X_train))
print("Dimensions of X_test: ")
print(dim(X_test))

## ----warning = FALSE, comment="#",  null_prefix=TRUE--------------------------
bijections <- which_are_bijection(data_set = X_train, verbose = TRUE)
print(names(X_train)[bijections])

## ----warning = FALSE, comment="#",  null_prefix=TRUE--------------------------
set(X_train, NULL, names(X_train)[bijections], NULL)
set(X_test, NULL, names(X_train)[bijections], NULL)

## ----warning = FALSE, comment="#",  null_prefix=TRUE--------------------------
X_test <- same_shape(X_test, reference_set = X_test, verbose = TRUE)

