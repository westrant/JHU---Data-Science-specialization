complete <- function(directory, id = 1:332){

  # set working directory
  if(grep("specdata", directory) == 1) {
    directory <- ("./specdata/")
  }
  
  # get the length of id vector
  id_len <- length(id)
  complete_data <- rep(0, id_len)
  
  # find all files in the specdata folder
  all_files <- as.character( list.files(directory) )
  file_paths <- paste(directory, all_files, sep="")
  j <- 1 
  
  for (i in id) {
    current_file <- read.csv(file_paths[i], header=T, sep=",")  ## for each file, read data into current_file
    complete_data[j] <- sum(complete.cases(current_file))  ## grab all complete items from the current file.
    j <- j + 1
  }
  
  result <- data.frame(id = id, nobs = complete_data)  ## return the number of complete observations.
  return(result)
} 