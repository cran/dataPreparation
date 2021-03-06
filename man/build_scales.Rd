% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/scale.R
\name{build_scales}
\alias{build_scales}
\title{Compute scales}
\usage{
build_scales(data_set, cols = "auto", verbose = TRUE)
}
\arguments{
\item{data_set}{Matrix, data.frame or data.table}

\item{cols}{List of numeric column(s) name(s) of data_set to transform. To transform all
characters, set it to "auto". (character, default to "auto")}

\item{verbose}{Should the algorithm talk? (Logical, default to TRUE)}
}
\value{
A list where each element name is a column name of data set and each element contains means and sd.
}
\description{
Build a list of means and standard deviation for each \code{cols}.
}
\examples{
# Get a data set
data(adult)
scales <- build_scales(adult, cols = "auto", verbose = TRUE)

print(scales)
}
