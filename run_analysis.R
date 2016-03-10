##  Getting and Cleaning Data Assignment 
## E. Pillay

## This script collects and cleans data from the Human Activity Recognition database 
## built from the recordings of 30 subjects performing activities of daily living (ADL) 
## while carrying a waist-mounted smartphone with embedded inertial sensors.  
## 
## A full description of the data can be found here:
##
## http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones
##
## The actual data can be downloaded here:
##
## https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip
##
## THis script performs the following function:
##
## 1) Downloads and extracts the data (if necessary)
## 2) Reads in all the necessary downloaded text files into R
## 3) Merges both the test and train data sets into a single data frame
## 4) Finds all the variables that relate to the mean and standard deviation
## 5) Refactors the data frame so that it only includes subject, activity and mean and std dev data    
## 6) Replaces numeric activities with the actual activity labels
## 7) substitute specific elements of variable names with reasonable labels
## 8) Split the data into activity and subject subsets with means and variances for both subsets



rm(list=ls())
setwd("C:/Users/User/Documents/Ev_Data_Cleaning")

# load libraries
library(plyr)

# download file if need be 
if (!file.exists("dataset.zip")){
  url <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
  download.file(url, destfile = "dataset.zip")
}

# unzip file if necessary
if (!file.exists("dataset")){
  unzip("dataset.zip", exdir = "dataset")
}  

# read in files from UCI HAR Dataset folder
setwd("dataset/UCI HAR Dataset")
files_full <- list.files(full.names=TRUE)

# read in activity_labels.txt and features.txt
labels <- read.table(files_full[1])
features <- read.table(files_full[2])

# read in files from test Dataset folder
test_files <- list.files("test", full.names=TRUE)
y_test <- read.table(test_files[4])
x_test <- read.table(test_files[3])
subject_test <- read.table(test_files[2])

# read in files from test Dataset folder
train_files <- list.files("train", full.names=TRUE)
y_train <- read.table(train_files[4])
x_train <- read.table(train_files[3])
subject_train <- read.table(train_files[2])


# create data
all_subject <- rbind(subject_train, subject_test)
all_activity <- rbind(y_train, y_test)
data <- cbind(all_subject, all_activity)
colnames(data) <- c("subject", "activity")

# get feature names from features data frame and convert to character
feature_characters <- as.character(features$V2)
# add x_train with correctly named col names to train_frame
all_statistics <- rbind(x_train, x_test)
colnames(all_statistics) <- feature_characters

data <- cbind(data, all_statistics)


# Part 2
# find mean or standard deviation in character vector
index <- grep("mean\\(\\)|std\\(\\)",feature_characters) + 2 # add 2 here to move index so that first two variables are in tact
index <- c(1,2,index)
data <- data[, index]
 

# Part 3
# extract activities from data frame 
activities <- data$activity
# get numeric and character labels
index_numeric <- as.numeric(labels$V1)
index_char <- as.character(labels$V2)
# match numeric activities from data fram to characters
for (i in 1:6) {
  activities[activities == index_numeric[i]] <- index_char[i]
}
# update data frame
data$activity <- activities

# Part 4
# substitute specific elements of data names with reasonable labels
names(data) <- gsub("std()", "SD", names(data))
names(data) <- gsub("mean()", "MEAN", names(data))
names(data) <- gsub("^t", "time", names(data))
names(data) <- gsub("^f", "frequency", names(data))
names(data) <- gsub("Acc", "Accelerometer", names(data))
names(data) <- gsub("Gyro", "Gyroscope", names(data))
names(data) <- gsub("Mag", "Magnitude", names(data))
names(data) <- gsub("BodyBody", "Body", names(data))

# Part 5
data2 <- aggregate(. ~subject + activity, data, mean)
data2 <- data2[order(data2$subject,data2$activity),]
write.table(data2, file = "tidydata.txt",row.name=FALSE)
