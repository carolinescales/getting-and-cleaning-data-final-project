########################################################################
some initial set up steps
########################################################################
setwd("~/Caroline/Getting & Cleaning Data/Final Project/UCI HAR Dataset")
library(plyr)

########################################################################
read in the training data
########################################################################
trainingData = read.csv("train/X_train.txt", sep="", header=FALSE)
trainingData[,562] = read.csv("train/Y_train.txt", sep="", header=FALSE)
trainingData[,563] = read.csv("train/subject_train.txt", sep="", header=FALSE)

########################################################################
read in the testing data
########################################################################
testingData = read.csv("test/X_test.txt", sep="", header=FALSE)
testingData[,562] = read.csv("test/Y_test.txt", sep="", header=FALSE)
testingData[,563] = read.csv("test/subject_test.txt", sep="", header=FALSE)

########################################################################
read in the activity labels
########################################################################
activityLabels = read.csv("activity_labels.txt", sep="", header=FALSE)

########################################################################
Read in features file and clean up field names
########################################################################
features = read.csv("features.txt", sep="", header=FALSE)
features[,2] = gsub('-mean', 'Mean', features[,2])
features[,2] = gsub('-std', 'Std', features[,2])
features[,2] = gsub('[-()]', '', features[,2])

########################################################################
Merge trainingData & testingData
########################################################################
mergedData = rbind(trainingData, testingData)

########################################################################
Keep only the mean and stddev fields, don't need any others
########################################################################
colsStddevMean <- grep(".*Mean.*|.*Std.*", features[,2])

########################################################################
same for the features, keep only mean & stddev, don't need any others
########################################################################
features <- features[colsStddevMean,]

########################################################################
append the subject and activity columns 
########################################################################
colsStddevMean <- c(colsStddevMean, 562, 563)

########################################################################
eliminate the columsn that aren't needed 
########################################################################
mergedData <- mergedData[,colsStddevMean]

########################################################################
Add the column names from features to mergedData.
Replace the activity ids with the activity names
########################################################################
colnames(mergedData) <- c(features$V2, "Activity", "Subject")
colnames(mergedData) <- tolower(colnames(mergedData))

currentActivity = 1
for (currentActivityLabel in activityLabels$V2) {
  mergedData$activity <- gsub(currentActivity, currentActivityLabel, mergedData$activity)
  currentActivity <- currentActivity + 1
}

mergedData$subject <- as.factor(mergedData$subject)
mergedData$activity <- as.factor(mergedData$activity)

tidy = aggregate(mergedData, by=list(activity = mergedData$activity, subject=mergedData$subject), mean)

########################################################################
Remove the subject and activity columns, output the tidy data set
########################################################################
tidy[,90] = NULL
tidy[,89] = NULL
write.table(tidy, "tidy.txt", sep="\t")