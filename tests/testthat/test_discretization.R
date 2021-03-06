context("test_discretization.R")
verbose <- TRUE
## build_bins
# ---------------
test_that("build_bins: with cols set to auto if perform it on all numerics", {
    # Given
    data_set <- data.table(num_col = c(1, 2, 3),
    not_num_col <- c("a", "b", "c"))

    # When
    bins <- build_bins(data_set, cols = "auto", verbose = verbose)

    # Then
    expect_equal("num_col", names(bins))
})

test_that("build_bins: type doesn't affect result shape", {
    # Given
    data_set <- data.table(num_col = 1 : 100)

    # When
    bins_freq <- build_bins(data_set, cols = "num_col", type = "equal_freq", verbose = verbose)
    bins_width <- build_bins(data_set, cols = "num_col", type = "equal_width", verbose = verbose)

    # Then
    expect_equal(length(bins_width), length(bins_freq))
    expect_equal(names(bins_width), names(bins_freq))
    expect_equal(sapply(bins_width, length), sapply(bins_freq, length))
})

test_that("build_bins: doesn't do anything on not numeric col", {
    # Given
    data_set <- data.table(not_numeric_col = c("a", "b", "c"))

    # When
    bins <- build_bins(data_set, cols = "not_numeric_col", verbose = verbose)

    # Then
    expect_equal(list(), bins)
})

test_that("build_bins: doesn't do anything on constant col", {
    # Given
    data_set <- data.table(constant_col = rep(1, 100))

    # When
    bins <- build_bins(data_set, cols = "constant_col", verbose = verbose)

    # Then
    expect_equal(list(), bins)
})

test_that("build_bins: expect error when type is not correct", {
    # Given
    data_set <- data.table(col = 1 : 10)
    wrong_type <- "a"

    # When and Then
    expect_error(build_bins(data_set, type = wrong_type, verbose = verbose),
    ": type should either be 'equal_width' or 'equal_freq'.")
})

# equal_width_splits
# ------------------
test_that("private function: equal_width_splits: Generate n_bins + 1 threshold to have n_bins bins", {
    # Given
    a_column <- runif(100)
    n_bins <- 9

    # When
    bins <- equal_width_splits(a_column, n_bins = n_bins, verbose = verbose)

    # Then
    expect_equal(length(bins), n_bins + 1)
})

test_that("private function: equal_width_splits: Generate n_bins + 1 threshold to have
          n_bins bins even with less values than n_bins", {
    # Given
    a_column <- runif(5)
    n_bins <- 9

    # When
    bins <- equal_width_splits(a_column, n_bins = n_bins, verbose = verbose)

    # Then
    expect_equal(length(bins), n_bins + 1)
})


test_that("private function: equal_width_splits", {
    # Given
    a_column <- c(1, 2, 3)
    n_bins <- 2

    # When
    bins <- equal_width_splits(a_column, n_bins = n_bins, verbose = verbose)

    # Then
    expect_equal(bins, c(1, 2, 3))
})

test_that("private function: equal_width_splits", {
    # Given
    a_column <- c(1, 2, 2.1, 2.2, 3)
    n_bins <- 2

    # When
    bins <- equal_width_splits(a_column, n_bins = n_bins, verbose = verbose)

    # Then
    expect_equal(bins, c(1, 2, 3))
})

test_that("private function: equal_width_splits", {
    # Given
    a_column <- c(1)
    n_bins <- 10

    # When
    bins <- equal_width_splits(a_column, n_bins = n_bins, verbose = verbose)

    # Then
    expect_equal(bins, c(1))
})

# equal_freq_splits
# ------------------
test_that("private function: equal_freq_splits: Generate n_bins + 1 threshold to have n_bins bins", {
    # Given
    a_column <- runif(100)
    n_bins <- 9

    # When
    bins <- equal_freq_splits(a_column, n_bins = n_bins, verbose = verbose)

    # Then
    expect_equal(length(bins), n_bins + 1)
})

test_that("private function: equal_freq_splits: ", {
    # Given
    a_column <- c(1, 2, 3)
    n_bins <- 2

    # When
    bins <- equal_freq_splits(a_column, n_bins = n_bins, verbose = verbose)

    # Then
    expect_equal(bins, c(- Inf, 2, + Inf))
})

test_that("private function: equal_freq_splits", {
    # Given
    a_column <- c(1, 2, 2.1, 2.2, 3)
    n_bins <- 2

    # When
    bins <- equal_freq_splits(a_column, n_bins = n_bins, verbose = verbose)

    # Then
    expect_equal(bins, c(- Inf, 2.1, + Inf))
})

test_that("private function: equal_freq_splits: with more bins than values", {
    # Given
    a_column <- c(1)
    n_bins <- 10

    # When
    bins <- equal_freq_splits(a_column, n_bins = n_bins, verbose = verbose)

    # Then
    expect_equal(bins, c(- Inf, 1, + Inf))
})

# is.possible_to_split
# ------------------
test_that("private function: is.possible_to_split: control sanity check data_set should be a vector.", {
    # Given
    wrong_data_set <- "something"
    n_bins <- 2

    # When and Then
    expect_error(is.possible_to_split(data_set = wrong_data_set, n_bins = n_bins),
    "data_set should be a vector of numerics and n_bins a numeric.")
})

test_that("private function: is.possible_to_split: control sanity check n_bins should be numeric.", {
    # Given
    data_set <- c(1, 2)
    wrong_n_bins <- "something"

    # When and Then
    expect_error(is.possible_to_split(data_set = data_set, n_bins = wrong_n_bins),
    "data_set should be a vector of numerics and n_bins a numeric.")
})


## fast_discretization
# -------------------
test_that("fast_discretization: after discretisation there are no more numerics", {
    # Given
    data_set <- data.table(col = runif(10))
    data_set[["col"]][1] <- NA # add a NA

    # When
    discretized_adult <- fast_discretization(data_set, bins = NULL, verbose = verbose)

    # Then
    expect_false(any(sapply(discretized_adult, is.numeric)))
})

## build_splits_names
# -------------------
test_that("private function: build_splits_names: without inf", {
    # Given
    splits <- c(0, 1, 2)
    expected_split_names <- c("[0, 1[", "[1, 2]")

    # When
    split_names <- build_splits_names(splits)

    # Then
    expect_identical(expected_split_names, split_names)
    expect_identical(build_splits_names(c(- Inf, 2, + Inf)), c("]-Inf, 2[", "[2, +Inf["))
})

test_that("private function: build_splits_names: with inf", {
    # Given
    splits <- c(- Inf, 2, + Inf)
    expected_split_names <- c("]-Inf, 2[", "[2, +Inf[")

    # When
    split_names <- build_splits_names(splits)

    # Then
    expect_identical(expected_split_names, split_names)
})
