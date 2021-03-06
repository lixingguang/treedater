% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/boot.R
\name{parboot}
\alias{parboot}
\title{Estimate of confidence intervals using parametric bootstrap for molecular clock dating.}
\usage{
parboot(td, nreps = 100, ncpu = 1, overrideTempConstraint = TRUE,
  overrideClock = NULL, overrideSearchRoot = TRUE,
  overrideSeqLength = NULL, quiet = TRUE, normalApproxTMRCA = FALSE,
  parallel_foreach = FALSE)
}
\arguments{
\item{td}{A fitted treedater object}

\item{nreps}{Integer number of simulations to be carried out}

\item{ncpu}{Number of threads to use for parallel computation. Recommended.}

\item{overrideTempConstraint}{If TRUE (default) will not enforce positive branch lengths in simualtion replicates. Will speed up execution.}

\item{overrideClock}{May be 'strict' or 'relaxed' in which case will force simulations to fit the corresponding model. If ommitted, will inherit the clock model from td}

\item{overrideSearchRoot}{If TRUE, will re-use root position from input treedater tree. Otherwise may re-estimate root position in simulations}

\item{overrideSeqLength}{Optional sequence length to use in simulations}

\item{quiet}{If TRUE will minimize output printed to screen}

\item{normalApproxTMRCA}{If TRUE will use estimate standard deviation from simulation replicates and report confidence interval based on normal distribution}

\item{parallel_foreach}{If TRUE will use the foreach package for parallelization. May work better on HPC systems.}
}
\value{
A list with elements 
\itemize{
\item trees: The fitted treedater objects corresponding to each simulation
\item meanRates: Vector of estimated rates for each simulation
\item meanRate_CI: Confidence interval for substitution rate
\item coef_of_variation_CI: Confidence interval for rate variation
\item timeOfMRCA_CI: Confidence interval for time of common ancestor
}
}
\description{
This function simulates phylogenies with branch lengths in units
     of substitutions per site. Simulations are based on a fitted
     treedater object which provides parameters of the molecular clock
     model. The treedater method is applied to each simulated tree
     providing a Monte Carlo estimate of variance in rates and dates.
}
\details{
If the original treedater fit estimated the root position, root
     position will also be estimated for each simulation, so the
     returned trees may have different root positions. Some replicates
     may converge to a strict clock or a relaxed clock, so the
     parameter estimates in each replicate may not be directly
     comparable. It is possible to compute confidence intervals for the
     times of particular nodes or for estimated sample times by
     inspecting the output from each fitted treedater object, which is
     contained in the $trees attribute.
}
\examples{
# make a random tree
tre <- ape::rtree(25)
# simulate sample times based on distance from root to tip:
sts <- setNames(  
ape::dist.nodes( tre)[(length(tre$tip.label)+1), 1:(length(tre$tip.label)+1)]
, tre$tip.label)
# modify edge length to represent evolutionary distance with rate 1e-3:
tre$edge.length <- tre$edge.length * 1e-3
# treedater: 
td <- dater( tre, sts =sts )
# parametric bootstrap: 
pb <- parboot( td, nreps=25 )
# plot lineages through time
plot( pb )

}
\seealso{
dater
boot
}
\author{
Erik M Volz <erik.volz@gmail.com>
}
