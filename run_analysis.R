run_analysis <- function() {
  
  library(reshape2)

  data_train <- read.table("./UCI HAR Dataset/train/X_train.txt")
  data_test <- read.table("./UCI HAR Dataset/test/X_test.txt")

  data <- rbind(data_train,data_test)

  label_train <- read.table("./UCI HAR Dataset/train/y_train.txt",col.names=c("Activity"))
  label_test <- read.table("./UCI HAR Dataset/test/y_test.txt",col.names=c("Activity"))
  
  label <- rbind(label_train,label_test)
  
  subject_train <- read.table("./UCI HAR Dataset/train/subject_train.txt",col.names=c("ID"))
  subject_test <- read.table("./UCI HAR Dataset/test/subject_test.txt",col.names=c("ID"))
  
  subject <- rbind(subject_train,subject_test)
  
  features <- read.table("./UCI HAR Dataset/features.txt",stringsAsFactors = FALSE, col.names=c("FeatureID", "Feature"))
  indexes <- grep(".*mean\\()|.*std\\()", features$Feature)
  
  data_subset <- data[,indexes]
  colnames(data_subset) <- features[indexes,2]
  
  data_subset$ActivityID <- factor(label$Activity)
  data_subset$ID <- factor(subject$ID)
  
  activities <- read.table("./UCI HAR Dataset/activity_labels.txt",col.names=c("ActivityID", "ActivityName"))
  
  data_merged <- merge(data_subset,activities)
  
  data_merged <- data_merged[,2:length(data_merged)]
  
  id_vars <- c("ActivityName","ID")
  measure_vars <- setdiff(colnames(data_merged), id_vars)
  melted_data <- melt(data_merged, id=id_vars, measure.vars=measure_vars)
  
  data_tidy <- dcast(melted_data, ActivityName + ID ~ variable, mean)
  
  write.table(data_tidy, "data_tidy.txt")

}
