generate_locations = function(n = 500, clusters = 5, spread = 0.2){
  #randomly distributed locations will account for 40% of the sample
  random_n = round(.4*n)
  
  #the remainder of the sample will be distributed to the clusters
  n.per = runif(clusters, min = 0.2, max = 0.8)
  n.per = round((n-random_n)*(n.per/sum(n.per)))
  
  if(sum(n.per)!=(n-random_n)){
    n.per[1] = n.per[1]+(n-random_n-sum(n.per))
  }
  
  #generate non-overlapping cluster centroids
  separation = .4/clusters
  
  cluster_range = seq(from = 0.15, to = 0.85, by = 0.0001)
  
  x = sample(x = cluster_range, size = 1)
  y = sample(x = cluster_range, size = 1)
  
  for(centroid in 2:clusters){
    nextcentroid.x = 0
    nextcentroid.y = 0
    
    while(any(abs(nextcentroid.x-x)<separation)|nextcentroid.x==0){
      nextcentroid.x = sample(x = cluster_range, size = 1)
    }
    
    x = c(x, nextcentroid.x)
    
    while(any(abs(nextcentroid.y-y)<separation)|nextcentroid.y==0){
      nextcentroid.y = sample(x = cluster_range, size = 1)
    }
    
    y = c(y, nextcentroid.y)
  }
  
  #plot(x,y, xlim = c(0:1),ylim = c(0,1))
  
  locations = cbind(x,y)
  
  #generate locations around the centroids
  range = seq(from = 0.001, to = 0.999, by = 0.0001)  
  locations = rbind(locations, cbind(sample(x = range, size = random_n-clusters), sample(x = range, size = random_n-clusters)))
  
  for(center in 1:clusters){
    for(add in 1:n.per[center]){
      newx = newy = 0
      
      #generate coordinates within the bounds according to normal distribution where sd is defined by spread parameter
      while(newx<=0 | newx>=1){
        h = rnorm(1, mean = 0, sd = 0.5*spread)
        newx = x[center]+h
      }
      
      while(newy<=0 | newy>=1){
        v = rnorm(1, mean = 0, sd = 0.5*spread)
        newy = y[center]+v
      }
      
      locations = rbind(locations, c(newx,newy))  
    }
    
  }
  
  return(locations)
}
