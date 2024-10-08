# Network Modeling - HS 2023
# C. Stadtfeld, A. Espinosa-Rada, A. Uzaheta
# Based on previous work from: K. Mepham, V. Amati
# Social Networks Lab
# Department of Humanities, Social and Political Sciences
# ETH Zurich
# 20 November 2023
#
# Assignment 2 - Task 2



# Task 2.1 ----------------------------------------------------------------
# The function "simulation" simulates the network evolution between 
# two time points. 
# Given the network at time t1, denoted by x1, the function simulates the 
# steps of the continuous-time Markov chain defined by a SAOM with outdegree,
# recip and transTrip statistics. Unconditional simulation is used.
# The function returns the network at time t2.
# The structure of the algorithm is described in the file
# _Simulating from SAOM.pdf_ available in
# the Lecture notes and additional material section on Moodle.

#' Simulate the network evolution between two time points
#'
#' @param n number of actors in the network
#' @param x1 network at time t1
#' @param lambda rate parameter
#' @param beta1 outdegree parameter
#' @param beta2 reciprocity parameter
#' @param beta3 transTrip parameter
#'
#' @return network at time t2
#'
#' @examples
#' netT1 <- matrix(c(
#'   0, 1, 0, 0, 0,
#'   0, 0, 0, 1, 0,
#'   0, 0, 0, 1, 1,
#'   1, 0, 1, 0, 0,
#'   0, 1, 1, 0, 1
#'   ), 
#'   nrow = 5, ncol =  5, byrow = TRUE)
#' netT2 <- simulation(5, netT1, 4, -2, 0.5, 0.05)
simulation <- function(n, x1, lambda, beta1, beta2, beta3) {
  t <- 0 # time
  x <- x1
  while (t < 1) {
    dt <- rexp(1, n * lambda)
    # --- MISSING ---
  }
  return(x)
}


# Task 2.2 ----------------------------------------------------------------
# Consider the two adjacency matrices in the files net1.csv and net2.csv.
# Estimate the parameters of the SAOM with outdegree, reciprocity and
# transitive triplets statistics using the function `siena07`.
# You can extract the estimated parameters from the `rate` and `theta`
#  components of the output object (e.g., res$rate and res$theta).

# ---MISSING---


# Task 2.3 ----------------------------------------------------------------
# Conditioning on the first observation, generate 1,000 simulations of the 
# network evolution
# Compute the triad census counts for each simulated network.
# Save the results in an object, named `triadCensus`, in which rows are
# the index of a simulated network and columns are the type of triads.
# Column names should use the triad type name, e.g., "003", "012", "102", ... 

# ---MISSING---

# Task 2.4 ----------------------------------------------------------------
## i. standardized the simulated network stats. ----
##   Name the resulting object as triadCensusStd

# ---MISSING---

## ii. variance-covariance matrix and its generalized inverse.         ----

# ---MISSING---

## iii. standardized the observed values of the triad census counts    ----
##  in the second observation using values from i.

# ---MISSING---

## iv. Monte-Carlo Mahalanobis distance computation                                ----
# Compute the Mahalanobis distance using the mhd function for 
# the auxiliar statistics of the simulated networks and the observed network.
# Remember to drop statistics with variance of 0 for the plot and
# Mahalanobis distance computation, report which statistics suffer this issue.

#' Compute the Mahalanobis distance
#'
#' @param auxStats numerical vector with the mean centered or standardized
#'   auxiliar statistics
#' @param invCov numerical matrix with the inverse of the variance-covariance
#'   matrix of the auxiliar statistics in the simulated networks
#'
#' @return numeric value with the Mahalanobis distance of auxiliar stats
#'
#' @examples
#' mhd(c(2, 4) - c(1.5, 2), solve(matrix(c(1, 0.8, 0.8, 1), ncol = 2)))
mhd <- function(auxStats, invCov) {
  t(auxStats) %*% invCov %*% auxStats
}


# ---MISSING---

## iii. Monte-Carlo p-value computation                                ----
# Compute the proportion of simulated networks where the distance is 
# equal or greater than the distance in the observed network.

# ---MISSING---

# violin plots ------------------------------------------------------------
# Fill out the missing part and run the code to obtain the violin plots

# install.packages(c("tidyverse", "ggplot2"))  # # run this line to install 
library(tidyverse)  # used: dplyr and tidyr
library(ggplot2)

# Given the array triadCensusStd, create a data frame from it in a long format, 
# do the same for the observed network statistics at time t2.
# Named the data frame "triadCensusDf" and "triadCensusObs".
# Drops statistics with variance of 0 for the plot.

triadCensusDf <- data.frame(triadCensusStd) |>
  select(where(~ var(.) > 0)) |>  # Drop statistics with zero variance
  pivot_longer(
    everything(),
    names_to = "triad", names_pattern = "^X(.+)$",
    values_to = "nnodes"
  )

# Compute the statistics of the observed network at time t2,
#  standardized using the stats from 2.4 literal i.
triadCensusObs <- # ---MISSING--- |> 
  data.frame() |>
  pivot_longer(
    everything(),
    names_to = "triad", names_pattern = "^X(.+)$",
    values_to = "nnodes"
  ) |>
  filter(triad %in% unique(triadCensusDf$triad))

# The following code computes the 5% and the 95% quantiles
# of the triad counts by type
percTriad <- triadCensusDf |>
  group_by(triad) |>
  summarise(
    quant05 = quantile(nnodes, prob = 0.05),
    quant95 = quantile(nnodes, prob = 0.95)
  ) |>
  pivot_longer(
    starts_with("quant"),
    names_to = "quant", names_pattern = "quant(.+)",
    values_to = "nnodes"
  )


# The following code produces the violin plots
ggplot(triadCensusDf, aes(fct_inorder(triad), nnodes)) +
  geom_violin(trim = FALSE, scale = "width") +
  stat_summary(fun = mean, geom = "point", size = 2) +
  geom_boxplot(width = 0.2, fill = "gray", outlier.shape = 4) +
  geom_point(data = triadCensusObs, col = "red", size = 2) +
  geom_line(
    data = triadCensusObs, aes(group = 1), col = "red", linewidth = 0.5
  ) +
  geom_line(
    data = percTriad, mapping = aes(group = quant),
    col = "gray", linetype = "dashed"
  ) +
  theme_bw() +
  theme(
    panel.grid.major = element_blank(),
    panel.grid.minor = element_blank(),
    axis.title.y = element_blank(),
    axis.text.y = element_blank(),
    axis.ticks.y = element_blank()
  ) +
  xlab("triad type")

