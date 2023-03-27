# Melissa Meeker
# Simulating predictor datasets for xy location data

# Clear Environment
rm(list = ls())

# Libraries
library(readr)
library(ape)  
library(spdep)
library(mvtnorm)
library(dplyr)

# Read in location data
data <- read_csv("sample_locations.csv")
data = data[,-1]

n_predictors = 100

simulate_predictors  = function(data, n.preds = n_predictors, phi.value = 0.1, seed = 1){
  
  # Sample Size
  n = nrow(data)
  
  # Spatial Euclidean Distance Matrix
  distance <- as.matrix(dist(data, method="euclidean"))
  
  # Generate Dataset 
  sig2 = .1
  Cov.Structure=as.matrix(sig2*exp(-distance*phi.value))
    
  set.seed(seed)
  X <-  rmvnorm(n.preds, mean = rep(0,n), sigma = Cov.Structure)
    
  X = as.data.frame(t(X))
  
  return(X)
}

predictors = simulate_predictors(data, n_predictors)

#To depict level of spatial correlation among predictors:
dists = as.matrix(dist(cbind(data$x, data$y)))

dists.inv = 1/dists
diag(dists.inv) = 0

remove(dists)

preds = paste("V", 1:100, sep = "")
mi = rep(NA, times = 100)
for(pred in 1:100){
  moran = Moran.I(predictors%>% pull(preds[pred]), dists.inv)
  mi[pred] = moran$observed
}

remove(dists.inv, n_predictors, pred, preds)

summary(mi)

hist(mi, main = "Histogram of Moran's I Across Predictors", xlab = "Moran's I")
