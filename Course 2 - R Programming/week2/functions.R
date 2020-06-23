add2 <- function(x, y) {
    x+y
}

above10 <- function(x) {
    use < - x > 10
    x[use]
}

above <- function(x, n = 10) {
  use <- x > n
  x[use]
}

columnmean <- function(y, removeNA = TRUE)  {
  nc <- ncol(y)         ## get the number of columns in y
  means <- numeric(nc)  ## empty vector the size of nc
  for(i in 1:nc) {      ##  loop through each column
    means[i] <- mean(y[, i], na.rm = removeNA)      ## calculate the mean of each col
  }
  means                 ## We are returning what's in vector means
}  

