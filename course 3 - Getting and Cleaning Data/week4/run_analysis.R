## Set URL of zipped data set.
fileURL <- 'https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip'

## Set local path for zip file.
dataFile <- "./UCI-HAR-Dataset.zip"

## Download and upzip the dataset, if it doesn't already exist.
if (file.exists(dataFile) == FALSE) {
  download.file(fileURL, dataFile)
  unzip(dataFile)
}


## 1. Merges the training and the test sets to create one data set.
## First, read the test data.
subject_test <- read.table("./UCI HAR Dataset/test/subject_test.txt", header = FALSE)
x_test <- read.table("./UCI HAR Dataset/test/X_test.txt", header = FALSE)
y_test <- read.table("./UCI HAR Dataset/test/y_test.txt", header = FALSE)

## Read the train data.
subject_train <- read.table("./UCI HAR Dataset/train/subject_train.txt", header = FALSE)
x_train <- read.table("./UCI HAR Dataset/train/X_train.txt", header = FALSE)
y_train <- read.table("./UCI HAR Dataset/train/y_train.txt", header = FALSE)

## Last, merge the training and test sets, store results in single objects.
x_merge <- rbind(x_train, x_test)
y_merge <- rbind(y_train, y_test)
subject_merge <- rbind(subject_train, subject_test)


## 2. Extracts only the measurements on the mean and standard deviation for each measurement.
## Grab column names from the features.txt file.
col_names <- read.table("./UCI HAR Dataset/features.txt")

## Set column names of the features.txt dataset to feature_id and feature_name.
names(col_names) <- c('feature_id', 'feature_name')

## grep column names to find all mean and std dev items.
index_col_names <- grep("-mean\\(\\)|-std\\(\\)", col_names$feature_name) 
x_merge <- x_merge[, index_col_names] 

## Remove all parenthesis from feature names.
names(x_merge) <- gsub("\\(|\\)", "", (col_names[index_col_names, 2]))


## 3. Uses descriptive activity names to name the activity_label in the data set (combined with step 4)
## 4. Appropriately labels the data set with descriptive activity names (combined with step 3)
## grab labels from the activity labels flat file.
activity_label <- read.table("./UCI HAR Dataset/activity_labels.txt")

## Set column names of the activity_labels.txt dataset to activity_id and activity_name.
names(activity_label) <- c('activity_id', 'activity_name')
y_merge[, 1] = activity_label[y_merge[, 1], 2]

## Use the labels "Activity" and "Subject" as column headings for tidy data output.
names(y_merge) <- "Activity"
names(subject_merge) <- "Subject"

## Merge all 3 data sets (subject, x, and y) into a single object.
## We now have our tidy data, ready for calculating averages.
tidyDataSet <- cbind(subject_merge, y_merge, x_merge)


## 5. From the data set in step 4, creates a second, independent tidy data set with the 
## average of each variable for each activity and each subject.

## Grab all values, strip off Subject and Activity.
rawData <- tidyDataSet[, 3:dim(tidyDataSet)[2]] 

## Take the mean of all mean values and standard dev values, create new object.
tidyDataMean <- aggregate(rawData,list(tidyDataSet$Subject, tidyDataSet$Activity), mean)

## Set column names of mean data set.
names(tidyDataMean)[1] <- "Subject"
names(tidyDataMean)[2] <- "Activity"

## Write out the tidy data means.
write.table(tidyDataMean, "./tidydata.txt", row.name=FALSE)

## Uncomment this to write out the raw tidy data (no averages)
## write.table(tidyDataSet, "./tidydataRAW.txt")
