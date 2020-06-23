pollutantmean <- function(directory, pollutant, id = 1:332){
  # set working directory
  if(grep("specdata", directory) == 1) {
    directory <- ("./specdata/")
  }
  
  # initialize a vector to hold the pollutant data
  mean_vector <- c()
  
  # find all files in the specdata folder
  all_files <- as.character( list.files(directory) )
  file_paths <- paste(directory, all_files, sep="")
  
  for(i in id) {
    current_file <- read.csv(file_paths[i], header=T, sep=",") ## Read in the csv.
    head(current_file)  ## get the top of the read in csv
    pollutant
    na_removed <- current_file[!is.na(current_file[, pollutant]), pollutant]  ## grab all non-NA items.
    mean_vector <- c(mean_vector, na_removed)  ## add each non-na items to the vector.
  }
  result <- mean(mean_vector)  ## get the mean of the vector.
  return(round(result, 3))  ## round to 3 decimal places.
}