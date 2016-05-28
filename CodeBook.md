CodeBook for run_analysis.R

Data source

This dataset is derived from the "Human Activity Recognition Using Smartphones Data Set" 
URL: http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones

Overview

The script completes the steps on the dataset above as described in the final project:
1. Merges the training and the test sets to create one data set.
2. Extracts only the measurements on the mean and standard deviation for each measurement.
3. Uses descriptive activity names to name the activities in the data set
4. Appropriately labels the data set with descriptive variable names.
5. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.

Original Data

x_test.txt contains the features for the test data 
y_test.txt contains the activity labels for the test data
subject_test.txt contains the test subjects for the test data
X_train.txt contains the features for the training data
y_train.txt contains the activity labels for the training data
subject_train.txt contains the training subjects for the training data

The script

The script will complete the steps described in the overview above. It assumes that the UCI HAR Dataset has been extracted (unzipped) into a directory with the same name ("UCI HAR Dataset"). 

First, all datasets are read in: training data, testing data, activity labels and features. The field names are normalized, then the training and testing data is merged (using rbind). Since only columns that represent the mean or standard variation for a variable are needed, all other columns are then eliminated. Replace the activity ids with the activity names. Then create a dataset named tidy with the average computed by activity by subject. This file is written to tidy.txt in the working directory. The tidy.txt file is tab delimited and written to the "UCI HAR Dataset" folder. 


Description of Variables

trainingData, testingData, and activityLabels are for the original files in the data provided. 

mergedData combines trainingData and testingData

features holds the cleaned up column names

colsStddevMean holds all the column names that refer to a mean or standard deviation

tidy is the final data set


