---
title: "<u>CodeBook</u>"
---

## *run_analysis.R* script performs the data cleaning and preparation.

# Download dataset
  Dataset downloaded as zip and extracted under the folder called **UCI HAR Dataset**.

# Variables Assignment
  * activities <- activity_labels.txt
  * features   <- features.txt
  * x_test     <- x_test.txt
  * y_test     <- y_test.txt
  * subject_test <-subject_test.txt
  * subject_train <-subject_train.txt
  * x_train     <- X_train.txt
  * y_train     <- y_train.txt

# Merges the training and the test sets to create one data set

  * x <- rbind(x_test,x_train)
  * y <- rbind(y_test,y_train)
  * subject <- rbind(subject_test,subject_train)
  * merged_dataset <- cbind(x,y,subject)

# Extracts only the measurements on the mean and standard deviation for each measurement.

  Creating extract_info by selecting subject_class,code,columns containing mean,columns   containing std

# Uses descriptive activity names to name the activities in the data set

  Entire code column of extract info is replaced with their respective activities from   2nd column of activity.

# Appropriately labels the data set with descriptive variable names

  * 2nd column of extract_info is replaced by activity
  * Acc is replaced by Accelerometer
  * Gyro is replaced by Gyroscope
  * BodyBody is replaced by Body
  * Mag is replaced by Magnitude
  * All column names start with F is replaced by Frequency
  * All column names start with t is replaced by Time
  * tBody is replaced by TimeBody
  * -mean() is replaced by Mean
  * -std() is replaced by STD 
  * angle is replaced by Angle
  * gravity is replaced by Gravity

# From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.

  * tidy_dataset is the final dataset that is created with the average of each variable for each activity and each subject
  
  * Written tidy_datset to **tidy_dataset.txt**