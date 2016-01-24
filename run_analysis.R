library(dplyr)
setwd("/Users/Steffen/Desktop/coursera/R Working Dir")

#Read features
features <- read.table("UCI HAR Dataset/features.txt")

#Read train data
train_x <- read.table("UCI HAR Dataset/train/X_train.txt")
train_y <- read.table("UCI HAR Dataset/train/y_train.txt")
train_sub <- read.table("UCI HAR Dataset/train/subject_train.txt")
#Apply names on train data
names(train_x) <- features[,2]
#Mean and std from train data
train_x_ms <- train_x[,grep("mean|std", colnames(train_x), ignore.case=TRUE)]
#Add subject to train data
train_x_ms <- mutate(train_x_ms, subject = train_sub$V1)
#Add training labels
train_x_ms <- mutate(train_x_ms, label = train_y$V1)
#names(train_x_ms)


#Read test data
test_x <- read.table("UCI HAR Dataset/test/X_test.txt")
test_y <- read.table("UCI HAR Dataset/test/y_test.txt")
test_sub <- read.table("UCI HAR Dataset/test/subject_test.txt")
#Apply names on test data
names(test_x) <- features[,2]
#Mean and std from train data
test_x_ms <- test_x[,grep("mean|std", colnames(test_x), ignore.case=TRUE)]
#Add subject to train data
test_x_ms <- mutate(test_x_ms, subject = test_sub$V1)
#Add training labels
test_x_ms <- mutate(test_x_ms, label = test_y$V1)


#Merge train and test
merge_train_test <- rbind(train_x_ms, test_x_ms)

#Read activity labels
activity_labels <- read.table("UCI HAR Dataset/activity_labels.txt")
names(activity_labels) <- c("label", "activity")
#Join activities
merge_train_test_act <- merge(merge_train_test, activity_labels, all = TRUE, by = c("label"))

#Replace existing variable names with more descriptive ones
names(merge_train_test_act)<-gsub("Acc", "Accelerometer", names(merge_train_test_act))
names(merge_train_test_act)<-gsub("Gyro", "Gyroscope", names(merge_train_test_act))
names(merge_train_test_act)<-gsub("BodyBody", "Body", names(merge_train_test_act))
names(merge_train_test_act)<-gsub("Mag", "Magnitude", names(merge_train_test_act))
names(merge_train_test_act)<-gsub("^t", "Time", names(merge_train_test_act))
names(merge_train_test_act)<-gsub("^f", "Frequency", names(merge_train_test_act))
names(merge_train_test_act)<-gsub("tBody", "TimeBody", names(merge_train_test_act))
names(merge_train_test_act)<-gsub("-mean()", "Mean", names(merge_train_test_act), ignore.case = TRUE)
names(merge_train_test_act)<-gsub("-std()", "STD", names(merge_train_test_act), ignore.case = TRUE)
names(merge_train_test_act)<-gsub("-freq()", "Frequency", names(merge_train_test_act), ignore.case = TRUE)
names(merge_train_test_act)<-gsub("angle", "Angle", names(merge_train_test_act))
names(merge_train_test_act)<-gsub("gravity", "Gravity", names(merge_train_test_act))

#Extract tidy data set
merge_train_test_act$subject <- as.factor(merge_train_test_act$subject)
merge_train_test_act$activity <- as.factor(merge_train_test_act$activity)
aggr_tidy <- aggregate(. ~subject+activity,merge_train_test_act,mean)
aggr_tidy <- aggr_tidy[order(aggr_tidy$subject,aggr_tidy$activity),]
write.table(x = aggr_tidy,file = "tidy.txt")
write.table(x = aggr_tidy,file = "tidy_no_rowname.txt", row.name=FALSE)
