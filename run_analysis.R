#script for course project

#1.Merge the training and the test sets to create one data set.
#Merge measurements
data_train <- read.table("./UCI HAR Dataset/train/X_train.txt")
data_test <- read.table("./UCI HAR Dataset/test/X_test.txt")
data <- rbind(data_train,data_test)
#merge activity labels
label_train <- read.table("./UCI HAR Dataset/train/y_train.txt",col.names=c("Activity"))
label_test <- read.table("./UCI HAR Dataset/test/y_test.txt",col.names=c("Activity"))
label <- rbind(label_train,label_test)
#merge subject IDs
subject_train <- read.table("./UCI HAR Dataset/train/subject_train.txt",col.names=c("ID"))
subject_test <- read.table("./UCI HAR Dataset/test/subject_test.txt",col.names=c("ID"))
subject <- rbind(subject_train,subject_test)
#read in "features": variable names of measurements
features <- read.table("./UCI HAR Dataset/features.txt",stringsAsFactors = FALSE, col.names=c("FeatureID", "Feature"))

#2.Extract measurements on the mean and standard deviation for each measurement.
indexes <- grep(".*mean\\()|.*std\\()", features$Feature)
data_subset <- data[,indexes]
#Add the  variable names of those measurents as columb names in subset
colnames(data_subset) <- features[indexes,2]
#Add activity labels
data_subset$ActivityID <- factor(label$Activity) 
#Add subject labels
data_subset$ID <- factor(subject$ID)

#3.Use descriptive activity names to name the activities in the data set
activities <- read.table("./UCI HAR Dataset/activity_labels.txt",col.names=c("ActivityID", "ActivityName"))

#4.Appropriately label the data set with descriptive activity names.
data_merged <- merge(data_subset,activities)
#Remove number labels for activities
data_merged <- data_merged[,2:length(data_merged)]

#5.Create a second, independent tidy data set with the average of each variable for each activity and each subject.
#Aggregate data using melt and dcast
library(reshape2)
id_vars <- c("ActivityName","ID")
measure_vars <- setdiff(colnames(data_merged), id_vars)
melted_data <- melt(data_merged, id=id_vars, measure.vars=measure_vars)
data_tidy <- dcast(melted_data, ActivityName + ID ~ variable, mean)
#Write into text file
write.table(data_tidy, "data_tidy.txt")
