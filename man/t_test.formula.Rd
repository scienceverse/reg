% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/t_test.R
\name{t_test.formula}
\alias{t_test.formula}
\title{T-test with N (formula)}
\usage{
\method{t_test}{formula}(formula, data, subset, na.action, ...)
}
\arguments{
\item{formula}{a formula of the form lhs ~ rhs where lhs is a numeric variable giving the data values and rhs either 1 for a one-sample or paired test or a factor with two levels giving the corresponding groups. If lhs is of class "Pair" and rhs is 1, a paired test is done}

\item{data}{an optional matrix or data frame (or similar: see model.frame) containing the variables in the formula formula. By default the variables are taken from environment(formula).}

\item{subset}{an optional vector specifying a subset of observations to be used.}

\item{na.action}{a function which indicates what should happen when the data contain NAs. Defaults to getOption("na.action").}

\item{...}{further arguments to be passed to or from methods.}
}
\description{
See \code{stats::\link[stats]{t.test}} for details.
}
\examples{
t_test(mpg~vs, data = mtcars)$n

}
