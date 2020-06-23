# This repo contains the following files:
- run_analysis.R - R script to perform analysis on wearable data, taking the averages.
- CodeBook.md - Codebook which describes the variables and methodology
- tidydata.txt - text file containing the averaged mean and std dev of the tidy data.
- tidydataRAW.txt - text file containing the raw tidy data.

# How run_analysis.R works:
- The script will check your current working directory to see if the .ZIP file is present.  If it is, then it proceeds into the "UCI HAR Dataset" directory and grabs the .txt files needed.
- If the .zip file is NOT present, then the script will download it, and unzip it.  
- Once the .txt files are parsed, the data is cleaned by formatting column headers (removing parenthesis) and renaming the first two headers.
- Then, all of the mean and std dev values are pulled into an object.
- Last, the means of all mean and std dev values of the tidy data are taken, and this final output is written to "tidydata.txt"
    
# Requirements:
- reshape 2
- dplyr
