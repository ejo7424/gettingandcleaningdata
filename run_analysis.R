# Getting and Cleaning Data Course Project
# by Eduardo Osorio, Sydney, Australia

# To produce tidy data from data collected from 
# the accelorometers of Samsung Galaxy S II smartphone
# Source: Human Activity Recognition Using Smartphones Data Set
# Center for Machine Learning and Intelligent Systems, UCI
# http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones

library(dplyr)


# Download and unzip data as provided by the course
# Original data source: http://archive.ics.uci.edu/ml/machine-learning-databases/00240/UCI%20HAR%20Dataset.zip
download.file("https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip", 
                destfile = "UCI HAR Dataset.zip")
unzip(zipfile = "UCI HAR Dataset.zip")

# README.txt in the UCI HAR Dataset specifies:

# 'features.txt': List of all features.
features <- read.table("UCI HAR Dataset/features.txt", stringsAsFactors = TRUE)

# 'activity_labels.txt': Links the class labels with their activity name.
activity_labels <- read.table("UCI HAR Dataset/activity_labels.txt", 
                              col.names = c("ActivityID" , "ActivityDesc"))

# subject_train.txt
subject_train <- read.table("UCI HAR Dataset/train/subject_train.txt", 
                            col.names = "SubjectID")

# 'train/X_train.txt': Training set.
x_train <- read.table("UCI HAR Dataset/train/X_train.txt")
colnames(x_train) <- features[,2]

# 'train/y_train.txt': Training labels.
y_train <- read.table("UCI HAR Dataset/train/y_train.txt", col.names = "ActivityID")

# Merge Training set and labels
train <- cbind(y_train, x_train)

#subject_test.txt
subject_test <- read.table("UCI HAR Dataset/test/subject_test.txt", 
                            col.names = "SubjectID")

# 'test/X_test.txt': Test set.
x_test <- read.table("UCI HAR Dataset/test/X_test.txt")
colnames(x_test) <- features[,2]

# 'test/y_test.txt': Test labels.
y_test <- read.table("UCI HAR Dataset/test/y_test.txt", col.names = "ActivityID")

# Merge Test set and labels
test <- cbind(y_test, x_test)

#1. Merge the training and the test sets to create one data set.
merged_dataset <- rbind(train, test)
merged_dataset <- cbind(rbind(subject_train, subject_test), merged_dataset)

#2. Extract only the measurements on the mean and standard deviation for each measurement. 
# Column names
column_names <- colnames(merged_dataset)
mean_std_dataset <- merged_dataset[ ,(grepl("ActivityID", column_names) |
                                        grepl("SubjectID", column_names) |
                                        grepl("mean", column_names) |
                                        grepl("std", column_names))]

#3. Use descriptive activity names to name the activities in the data set
tidy_dataset1 <- merge(activity_labels, mean_std_dataset, by="ActivityID")

#4. Appropriately label the data set with descriptive variable names.
# Done above

#5. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.
tidy_dataset2 <- tidy_dataset1 %>%
  group_by(ActivityID, ActivityDesc, SubjectID) %>%
    summarise_all(mean)

# Write tidy data sets 1 and 2
write.csv(tidy_dataset1, file = "tidy_dataset1.csv", row.names = FALSE)
write.csv(tidy_dataset2, file = "tidy_dataset2.csv", row.names = FALSE)
