% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/study_analyse.R
\name{study_analyse}
\alias{study_analyse}
\alias{study_analyze}
\title{Run analysis}
\usage{
study_analyse(study)

study_analyze(study)
}
\arguments{
\item{study}{A study list object with class scivrs_study}
}
\value{
A study object with class scivrs_study
}
\description{
Run the analyses on the data
}
\examples{

s <- study() \%>\%
  add_hypothesis("H1", "Petal width and length will be positively correlated.") \%>\%
  add_analysis("A1", cor.test(dat$Petal.Width, dat$Petal.Length)) \%>\%
  add_criterion("sig", "p.value", "<", 0.05) \%>\%
  add_criterion("pos", "estimate", ">", 0) \%>\%
  add_eval("corroboration", "sig & pos",
           "Petal width is significantly and positively correlated to length") \%>\%
  add_eval("falsification", "sig & !pos",
           "Petal width is significantly and negatively correlated to length") \%>\%
  add_data("dat", iris) \%>\%
  study_analyse()
s

}
