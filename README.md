# spatial-exploration

Spatial data have an underlying correlation structure that makes them not suitable for standard statistical models that assume data are independent and identically distributed.

In order to perform tests with spatial data, we often need to simulated spatially oriented data.

There are a few things that we may need to consider doing.
1) Generate xy locations of spatial data.
2) Generate a set of predictors associated with the spatial data that follow a spatial distribution.

The file generate_locations.R contains a function that can be used to generate sets of spatial locations with parameters for:
  a) sample size
  b) number of cluster center points
  c) spread of locations around cluster centers
  
The file 'Generating Spatial Predictor Datasets.R' can be used to generate a spatially correlated predictor set for the sets of xy coordinate locations generated from 'generate_locations.R'. The predictors follow a normal distribution with a covariance structure based on an exponential variogram. The exponential variogram has a parameter, phi, that can be used to adjust the level of spatial correlation in the dataset (lower phi corresponds to more spatial correlation). You can adjust the following:
  a) the number of predictors
  b) the value of phi
  
The file 'Generating Spatial Predictor Datasets.R' also provides code to calculate the Moran's I of each predictor based on an inverse distance relationship. These Moran's I values are summarized and plotted via a histogram.
