pollutantmean <- function(directory, pollutant, id = 1:332){
 
  p1 <- c()  ## create empty vector
  
  files_full <- list.files(directory)  ## get filenames

  print(id)
  
  for (i in id) {
    path <- paste(directory, "/", files_full[i], sep="")
    output <- read.csv(path, header=TRUE)
    p1 <- c(p1, output[, pollutant])
    
    print(i)
  }
 
  m1 <- mean(p1, na.rm=TRUE)
  return(m1)
}


complete <- function(directory, id = 1:332){
  
  datastore <- data.frame()
  
  IDVector <- c()  ## create empty vector to hold IDs
  NobVector <- c()  ## create empty vector to hold nobs
  
  files_full <- list.files(directory)  ## get filenames
  

  
  for (i in id) { 
    path <- paste(directory, "/", files_full[i], sep="")  ## concatenate directory and filename
    output <- read.csv(path, header=TRUE)  ## read in each file and store data
    
    good <- output[complete.cases(output), ]
    ## datastore <- rbind(datastore, output[complete.cases(output), ])
    
    if(nrow(good) > 0)
    {
      IDVector <- c(IDVector, i)
      NobVector <- c(NobVector, nrow(good))
    }
  }
  
  return(data.frame(id = IDVector, nobs = NobVector))
  
}