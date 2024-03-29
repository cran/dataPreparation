# Data set documentation

###################################################################################################
################################## messy_adult ###################################################
###################################################################################################
#' Adult with some ugly columns added
#'
#'For examples and tutorials, messy_adult has been built using UCI \code{adult}.
#'
#'We added 9 really ugly columns to the data set:
#'
#'\itemize{
#'     \item 4 dates with various formats and time stamp, containing NAs
#'     \item 1 constant column
#'     \item 3 numeric with different decimal separator
#'     \item 1 email address
#' }
#'
#'
#'@name messy_adult
#' @docType data
#' @keywords data
#' @usage data(tiny_messy_adult)
#' @format A data.table with 32561 rows and 24 variables.
NULL


###################################################################################################
################################## tiny_messy_adult ###############################################
###################################################################################################
#' First 500 rows of \code{\link{messy_adult}}
#'
#'@name tiny_messy_adult
#' @docType data
#' @keywords data
#' @usage data(tiny_messy_adult)
#' @format A data.table with 500 rows and 24 variables.
NULL


###################################################################################################
###################################### adult #####################################################
###################################################################################################
#' Adult for UCI repository
#'
#'For examples and tutorials, and in order to build \code{messy_adult}, UCI adult data set is used. \cr
#' Data Set Information: \cr
#' \cr
#' Extraction was done by Barry Becker from the 1994 Census database. A set of reasonably clean records was
#' extracted using the following conditions: ((AAGE>16) && (AGI>100) && (AFNLWGT>1)&& (HRSWK>0))\cr
#'\cr
#' Prediction task is to determine whether a person makes over 50K a year.
#' @name adult
#' @docType data
#' @references \url{https://archive.ics.uci.edu/ml/datasets/adult}
#' @keywords data
#' @usage data("adult")
#' @format A data.frame with 32561 rows and 15 variables.
NULL