% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/epochs_from_nwb_stimulus.R
\name{epochs_from_nwb_stimulus}
\alias{epochs_from_nwb_stimulus}
\title{Get epochs from stimulus trace by identifying significant changes in point differences}
\usage{
epochs_from_nwb_stimulus(x, s, ntail = 2, n_expected)
}
\arguments{
\item{x}{path to file}

\item{s}{acquisition_name}

\item{ntail}{epoch transitions to gather}

\item{n_expected}{}
}
\description{
Get epochs from stimulus trace by identifying significant changes in point differences
}
