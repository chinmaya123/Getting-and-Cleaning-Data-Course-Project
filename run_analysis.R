x <- rbind(x_test,x_train)
y <- rbind(y_test,y_train)
subject <- rbind(subject_test,subject_train)
merged_dataset <- cbind(x,y,subject)
extract_info <- merged_dataset %>% select(subject_class,code,contains("mean"),contains("std"))
extract_info$code <-factor(activities[extract_info$code,2])
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
tidy_dataset <- extract_info %>%
             group_by(subject_class,activity) %>%
             summarise_all(list(~ mean(., trim = .2)))
write.table(tidy_dataset, "tidy_dataset.txt", row.name=FALSE)

