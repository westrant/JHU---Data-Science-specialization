add2 <- function(x, y) {
  x + y
}

## this returns the elements in X that are greater than 10.
above10 <- function(x) {
  use <- x > 10
  x[use]
}

## this returns the elements in X that are greater than n (defaulted to 10).
above <- function(x, n = 10) {
  use <- x > n
  x[use]
}

columnmean <- function(y, removeNA = TRUE)  {    ## functionality to remove NAs
  nc <- ncol(y)         		## get the number of columns in y
  means <- numeric(nc)  		## empty vector the size of nc
  for(i in 1:nc) {      		##  loop through each column
    means[i] <- mean(y[, i], na.rm = removeNA)      ## calculate the mean of each col
  }
  means                 			## We are returning what's in vector means
}  
