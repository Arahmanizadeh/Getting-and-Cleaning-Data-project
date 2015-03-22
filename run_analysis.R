setwd("C:/phd & Research/e-learning/Data Science/Getting and Cleaning Data/week3/UCI HAR Dataset")

library(plyr)
# load train Data files
x_train <- read.table('train/X_train.txt')
y_train <- read.table('train/y_train.txt')
subject_train <- read.table('train/subject_train.txt')

# load test Data files
x_test <- read.table('test/X_test.txt')
y_test <- read.table('test/y_test.txt')
subject_test <- read.table('test/subject_test.txt')

# load features and activity_labels files
features <- read.table("features.txt")

activity_labels <- read.table("activity_labels.txt")
# merge loaded files
x_merged <- rbind(x_train, x_test)
y_merged <- rbind(y_train, y_test)
subject_merged <- rbind(subject_train, subject_test)

# Extracts only the measurements on the mean and standard deviation for each measurement

features_with_mean_or_std <- grep("-(mean|std)\\(\\)", features[, 2])

x_merged <- x_merged[, features_with_mean_or_std]
names(x_merged) <- features[features_with_mean_or_std, 2]
y_merged[, 1] <- activity_labels[y_merged[, 1], 2]
names(y_merged) <- "activity"
names(subject_merged) <- "subject"

# merge columns
columns_merged_data <- cbind(x_merged, y_merged, subject_merged)
tidy_data <- ddply(columns_merged_data, .(subject, activity), function(x) colMeans(x[, 1:66]))

write.table(tidy_data, "tidy_data.txt", row.name=FALSE)
