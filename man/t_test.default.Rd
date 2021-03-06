% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/t_test.R
\name{t_test.default}
\alias{t_test.default}
\title{T-test with N}
\usage{
\method{t_test}{default}(
  x,
  y = NULL,
  alternative = c("two.sided", "less", "greater"),
  mu = 0,
  paired = FALSE,
  var.equal = FALSE,
  conf.level = 0.95,
  names = NULL,
  ...
)
}
\arguments{
\item{x}{a (non-empty) numeric vector of data values.}

\item{y}{an optional (non-empty) numeric vector of data values.}

\item{alternative}{a character string specifying the alternative hypothesis, must be one of "two.sided" (default), "greater" or "less". You can specify just the initial letter.}

\item{mu}{a number indicating the true value of the mean (or difference in means if you are performing a two sample test).}

\item{paired}{a logical indicating whether you want a paired t-test.}

\item{var.equal}{a logical variable indicating whether to treat the two variances as being equal. If TRUE then the pooled variance is used to estimate the variance otherwise the Welch (or Satterthwaite) approximation to the degrees of freedom is used.}

\item{conf.level}{confidence level of the interval.}

\item{names}{optional group names for 2-sample tests}

\item{...}{further arguments to be passed to or from methods.}
}
\description{
See \code{stats::\link[stats]{t.test}} for details.
}
\examples{
t_test(rnorm(20), rnorm(20, 0.25), names = c("A", "B"))$n

t_test(mtcars$mpg, mu = 20)$n

v <- rnorm(20)
v[3] <- NA
t_test(v)$n
}
