library(dplyr)

# Download the dataset

filename <- "UCI_HAR_Dataset.zip"
fileURL <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"

if (!file.exists(filename)){
  download.file(fileURL, filename, method="curl")
  unzip(filename) 
}
# Varibale Assignment

features <- read.table("features.txt",col.names = c('id','feature'))
activities <- read.table('activity_labels.txt',col.names = c('id','activity'))
subject_test <- read.table("/Users/condenast/Documents/Data Science/R/Assigment/UCI HAR Dataset/test/subject_test.txt",col.names = 'subject_class')
x_test <- read.table('./test/X_test.txt',col.names = features$feature)
y_test <- read.table('./test/y_test.txt',col.names = activities$id)
subject_train <- read.table("/Users/condenast/Documents/Data Science/R/Assigment/UCI HAR Dataset/train/subject_train.txt",col.names = 'subject_class')
x_train <- read.table('./train/X_train.txt',col.names = features$feature)
y_train <- read.table('./train/y_train.txt',col.names = 'code')

#Merging DataSet

x <- rbind(x_test,x_train)
y <- rbind(y_test,y_train)
subject <- rbind(subject_test,subject_train)
merged_dataset <- cbind(x,y,subject)

#Extracting Info

extract_info <- merged_dataset %>% select(subject_class,code,contains("mean"),contains("std"))
extract_info$code <-factor(activities[extract_info$code,2])

#Changing Names

names(extract_info)[2]='activity'
names(extract_info)<-gsub("Acc", "Accelerometer", names(extract_info))
names(extract_info)<-gsub("Gyro", "Gyroscope", names(extract_info))
names(extract_info)<-gsub("-mean()", "Mean", names(extract_info), ignore.case = TRUE)
names(extract_info)<-gsub("-std()", "STD", names(extract_info), ignore.case = TRUE)
names(extract_info)<-gsub("BodyBody", "Body", names(extract_info))
names(extract_info)<-gsub("Mag", "Magnitude", names(extract_info))
names(extract_info)<-gsub("^t", "Time", names(extract_info))
names(extract_info)<-gsub("^f", "Frequency", names(extract_info))
names(extract_info)<-gsub("tBody", "TimeBody", names(extract_info))
names(extract_info)<-gsub("angle", "Angle", names(extract_info))
names(extract_info)<-gsub("gravity", "Gravity", names(extract_info))

#Preparing Tidy Dataset

tidy_dataset <- extract_info %>%
             group_by(subject_class,activity) %>%
             summarise_all(list(~ mean(., trim = .2)))

#Writing Final File

write.table(tidy_dataset, "tidy_dataset.txt", row.name=FALSE)

