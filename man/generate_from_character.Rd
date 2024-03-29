% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/generate_from_character.R
\name{generate_from_character}
\alias{generate_from_character}
\title{Recode character}
\usage{
generate_from_character(
  data_set,
  cols = "auto",
  verbose = TRUE,
  drop = FALSE,
  ...
)
}
\arguments{
\item{data_set}{Matrix, data.frame or data.table}

\item{cols}{List of character column(s) name(s) of data_set to transform. To transform all
characters, set it to "auto". (character, default to "auto")}

\item{verbose}{Should the function log (logical, default to TRUE)}

\item{drop}{Should \code{cols} be dropped after generation (logical, default to FALSE)}

\item{...}{Other arguments such as \code{name_separator} to separate words in new columns names
(character, default to ".")}
}
\value{
\code{data_set} with new columns. \code{data_set} is edited by \strong{reference}.
}
\description{
Recode character into 3 new columns: \cr
\itemize{
\item was the value not NA, "NA", "",
\item how often this value occurs,
\item the order of the value (ex: M/F => 2/1 because F comes before M in alphabet).
}
}
\examples{
# Load data set
data(tiny_messy_adult)
tiny_messy_adult <- un_factor(tiny_messy_adult, verbose = FALSE) # un factor ugly factors

# transform column "mail"
tiny_messy_adult <- generate_from_character(tiny_messy_adult, cols = "mail")
head(tiny_messy_adult)

# To transform all characters columns:
tiny_messy_adult <- generate_from_character(tiny_messy_adult, cols = "auto")
}
