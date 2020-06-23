---
title: 'Reproducible Research: Peer Assessment 1'
output:
  html_document:
    keep_md: yes
  word_document: default
---
## Introduction
Reproducible Research - Peer Assignment 1.  
Author:  Tim Westran  
Purpose:  Answer questions about behavior of wearable health monitoring appliances.  
Data set used:  https://d396qusza40orc.cloudfront.net/repdata%2Fdata%2Factivity.zip

## Load libraries and set options

```r
## Ensure the ggplot2 library is loaded.
library(ggplot2)

## Don't use scientific notation!
options("scipen"=100, "digits"=4)
```

## Loading and preprocessing the data

```r
## Unzip the activity.zip file.
unzip(zipfile="activity.zip")

## use read.csv to read in activity.csv from unzipped file.
## store data into a variable called data
data <- read.csv("activity.csv")
```

## What is mean total number of steps taken per day?

```r
## Grab the sum of all steps by date.
totalSteps <- tapply(data$steps, data$date, FUN=sum, na.rm=TRUE)

## Plot the total number of steps taken per day.
hist(totalSteps, 
     breaks=20,
     main="Total number of steps taken per day", 
     col="blue", 
     xlab="Steps taken")
```

![](PA1_template_files/figure-html/unnamed-chunk-1-1.png)<!-- -->
    
The mean is 9354.2295 and the median is 10395.

## What is the average daily activity pattern?

```r
## calculate the average number of steps for each interval, across all days.
intervalSteps <- aggregate(x=list(steps=data$steps), by=list(interval=data$interval),
                      FUN=mean, na.rm=TRUE)

## Plot the Average Number Steps per Day by 5  minute Interval.
ggplot(data=intervalSteps, aes(x=interval, y=steps)) +
    geom_line(color="blue") +
    xlab("5 minute Interval") +
    ylab("Average number of steps")
```

![](PA1_template_files/figure-html/avgdailyactivity-1.png)<!-- -->

Find the 5 minute interval with the max average number of steps.

```r
## Find the interval with the max average number of steps.
maxSteps <- intervalSteps[which.max(intervalSteps$steps),]
```


The 5-minute interval, on average across all the days in the data set, 
containing the maximum number of steps is 835 with 206.1698 steps.


## Imputing missing values
Calculate and report the total number of missing values in the dataset (i.e. the total number of rows with ????????s)


```r
## Grab all items that are set to NA.
missingData <- sum(is.na(data$steps))
completeData <- sum(complete.cases(data$steps))
```

Overall there are  2304 incomplete rows containing NAs, which leaves 15264 complete rows.

For filling in the missing values, we take the mean value for the 5-minute interval which the missing value is 
part of. Then we set the NA values equal to the calculated mean.


```r
# Replace each missing value with the mean value of its 5-minute interval
missingVals <- function(steps, interval) {
    replaceVal <- NA
    ## If we don't hit an NA, just copy the existing value over.
    if (!is.na(steps))
        replaceVal <- c(steps)
    ## Otherwise, we have hit an NA.  
    ## Calculate the mean value and use this as a replacement value.
    else
        replaceVal <- (intervalSteps[intervalSteps$interval==interval, "steps"])
    ## Return the replacement value (either the original or else the mean)
    return(replaceVal)
}

## Make a copy of the original data.
dataNoNA <- data

## Move over all replacement values for NA in the new data set.
dataNoNA$steps <- mapply(missingVals, dataNoNA$steps, dataNoNA$interval)
totalSteps <- tapply(dataNoNA$steps, dataNoNA$date, FUN=sum)
```

Make a histogram of the total number of steps taken each day and calculate and report the mean and median total number of steps taken per day. 


```r
hist(totalSteps, 
     breaks=20,
     main="Total steps taken per day - Replaced NAs", 
     col="blue", 
     xlab="Steps taken")
```

![](PA1_template_files/figure-html/unnamed-chunk-3-1.png)<!-- -->

The mean with NA's replaced is 10766.1887 
and the median with NAs replaced is 10766.1887.

The mean and median are both higher after imputting missing data because NA's in the original set
are seen as being equivalent to 0.  When we replace the NA's with means, this will increase the
overall mean and median of the data set.  


## Are there differences in activity patterns between weekdays and weekends?
First, we need to determine if the day is a weekday or weekend.

```r
weekdayOrWeekend <- function(date) {
    ## What day of the week is it?
    day <- weekdays(date)
    
    ## If it's a weekday, then return weekday.
    if (day %in% c("Monday", "Tuesday", "Wednesday", "Thursday", "Friday"))
        return("weekday")
    
    ## If it's a weekend, then return weekend.
    else if (day %in% c("Saturday", "Sunday"))
        return("weekend")
}

## Take our updated data set and add a variable to designate if the day is a weekday or weekend
dataNoNA$day <- sapply(as.Date(dataNoNA$date), FUN=weekdayOrWeekend)
```

Make plots of 5-minute intervals and average number of steps taken on weekdays
and weekends.  See if there is a difference.


```r
## Create two plots, one of weekends and one of weekdays.
ggplot(data = aggregate(steps ~ interval + day, data=dataNoNA, mean), aes(interval, steps)) + 
    geom_line(color = "blue") + 
    facet_grid(day ~ .) +
    xlab("5 minute Interval") + 
    ylab("Average number of steps")
```

![](PA1_template_files/figure-html/weekdayweekendplot-1.png)<!-- -->

We can see that the frequency of steps taken is different across the day, depending on if the day is a 
weekday or weekend.  Weekend steps appear to be more equally distributed across all of the interviews, while weekdays
have a relatively early peak of steps, then it tapers off.  This makes sense, because most people will
exercise early in the day, then have jobs which require a measure of either sitting or standing in place.
