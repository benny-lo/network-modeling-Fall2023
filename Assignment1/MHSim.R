# Network Modeling - HS 2023
# C. Stadtfeld, A. Espinosa-Rada, A. Uzaheta
# Based on previous version from: K. Mepham, V. Amati
# Social Networks Lab
# Department of Humanities, Social and Political Sciences
# ETH Zurich
# 23 October 2023
#
# Assignment 1 - Task 2


# MHstep ------------------------------------------------------------------
#' Simulate the next step of a network in Markov chain using Metropolis-Hasting
#' 
#' The function `MHstep` simulates the the Metropolis-Hastings step that defines
#' the Markov chain whose stationary distribution is the ERGM with 
#' edge, mutual and nodematch statistics
#'
#' @param net an object of class `matrix`. Adjacency matrix of the network.
#' @param nodeAttr a character or numeric vector. The node attribute. 
#' @param theta1 a numeric value. The value of the edge parameter of the ERGM.
#' @param theta2 a numeric value. The value of the mutual parameter of the ERGM.
#' @param theta3 a numeric value. The value of the nodematch parameter of the ERGM.
#'
#' @return next state of the Markov Chain
#'
#' @examples
#' MHstep(
#'   matrix(c(0, 1, 0, 0, 0, 0, 1, 1, 0), nrow = 3, ncol = 3),
#'   c("v", "g", "g"),
#'   -log(0.5), log(0.4), log(.8)
#' )
MHstep <- function(net, nodeAttr, theta1, theta2, theta3){
  
  # Number of vertices in the network
  nvertices <- nrow(net) 
  
  # Choose randomly two vertices, prevent loops {i,i} with replace = FALSE
  tie <- sample(1:nvertices, 2, replace = FALSE) 
  i <- tie[1]
  j <- tie[2]
  
  # Compute the change statistics
  
  #                --- MISSING---
  
  
  # Compute the probability of the next state 
  # according to the Metropolis-Hastings algorithm
  
  #                --- MISSING---
  
  # Select the next state: 

  #                --- MISSING---
  
  # Return the next state of the chain
  return(net)
}

# Markov Chain simulation -------------------------------------------------
#' The function MarkovChain simulates the networks from the ERGM with 
#' edge, mutual and nodematch statistics
#'
#' @param net an object of class `matrix`. Adjacency matrix of the network.
#' @param nodeAttr a character or numeric vector. The node attribute. 
#' @param theta1 a numeric value. The value of the edge parameter of the ERGM.
#' @param theta2 a numeric value. The value of the mutual parameter of the ERGM.
#' @param theta3 a numeric value. The value of the nodematch parameter of the ERGM.
#' @param burnin an integer value.
#'   Number of steps to reach the stationary distribution.
#' @param thinning an integer value. Number of steps between simulated networks.
#' @param nNet an integer value. Number of simulated networks to return as output.
#'
#' @return a named list:
#'   - netSim: an `array` with the adjancency matrices of the simulated networks.
#'   - statSim: a `matrix` with the value of the statistic defining the ERGM.
#'
#' @examples
#' MarkovChain(
#'   matrix(c(0, 1, 0, 0, 0, 0, 1, 1, 0), nrow = 3, ncol = 3),
#'   c("v", "g", "g"),
#'   -log(0.5), log(0.4), log(.8)
#' )
MarkovChain <- function(net, nodeAttr, theta1, theta2, theta3,
                        burnin = 10000, thinning = 1000, nNet = 1000){
  
  # Burnin phase: repeating the steps of the chain "burnin" times  
  nvertices <- nrow(net)
  burninStep <- 1 # counter for the number of burnin steps
  
  # Perform the burnin steps
  #                --- MISSING---
  
  # After the burnin phase we draw the networks
  # The simulated networks and statistics are stored in the objects
  # netSim and statSim
  netSim <- array(0, dim = c(nvertices, nvertices, nNet))
  statSim <- matrix(0, nNet, 3)
  thinningSteps <- 0 # counter for the number of thinning steps
  netCounter <- 1 # counter for the number of simulated network
  
  #                --- MISSING---
  
  # Return the simulated networks and the statistics
  return(list(netSim = netSim, statSim = statSim))
}
