# Variables used and their purpose
- fileURL - Path to the .ZIP file for the data used.
- dataFile - Path of where the .ZIP file will be stored locally.
- subject_test - Object used to hold the results of reading in "UCI HAR Dataset/test/subject_test.txt"
- x_test - Object used to hold the results of reading in "./UCI HAR Dataset/test/X_test.txt"
- y_test - Object used to hold the results of reading in "./UCI HAR Dataset/test/y_test.txt"
- subject_train - Object used to hold the results of reading in "./UCI HAR Dataset/train/subject_train.txt"
- x_train - Object used to hold the results of reading in "./UCI HAR Dataset/train/X_train.txt"
- y_train - Object used to hold the results of reading in "./UCI HAR Dataset/train/y_train.txt"
- x_merge - Object used to hold the results of combining x_train and x_test
- y_merge - Object used to hold the results of combining y_train and y_test
- subject_merge - Object used to hold the results of combining subject_train and subject_test
- col_names - Object used to hold the results of reading in "./UCI HAR Dataset/features.txt"
- index_col_names - Object used to hold the result of just the mean and std values from the merged data set.
- activity_label - Object used to hold the results of reading in "./UCI HAR Dataset/activity_labels.txt"
- tidyDataSet - Object used to hold the raw tidy data set, before any averaging is done.
- rawData - Object used to hold the raw data set, minus the subject and activity columns (used for aggregating data)
- tidyDataMean - Object used to hold the means of mean and std dev of the tidy data set.
