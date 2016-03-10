# GettingAndCleaningDataAssignment

## Background

The script created for this assignment collects and cleans data from the Human Activity Recognition database built from the recordings of 30 subjects performing activities of daily living (ADL) while carrying a waist-mounted smartphone with embedded inertial sensors.  

## Data 

A full description of the data can be found here:

http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones

The actual data can be downloaded here:

https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip

## The Script

The script run_analysis.R does the following:

1) Downloads and extracts the data (if necessary)

2) Reads in all the necessary downloaded text files into R

3) Merges both the test and train data sets into a single data frame

4) Finds all the variables that relate to the mean and standard deviation

5) Refactors the data frame so that it only includes subject, activity and mean and std dev data    

6) Replaces numeric activities with the actual activity labels

7) substitute specific elements of variable names with reasonable labels

8) Split the data into activity and subject subsets with means and variances for both subsets

## Code Book

Additionally a Code Book has also been submitted for this assignment.
