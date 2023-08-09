## Course Project "Getting and Cleaning Data"
## Date: 9-8-2023

# Load required packages
library(dplyr)

# Load data
filename <- "Coursera_Week4_FinalAssignment.zip"

  # Checking if the file already exists.
if (!file.exists(filename)){
  fileURL <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
  download.file(fileURL, filename, method="curl")
}  

  # Checking if folder exists
if (!file.exists("UCI HAR Dataset")) { 
  unzip(filename) 
}

  # Reading test and training and assigning all datasets
features <- read.table("UCI HAR Dataset/features.txt", col.names = c("n","functions"))

x_train <- read.table("UCI HAR Dataset/train/X_train.txt", col.names = features$functions)
y_train <- read.table("UCI HAR Dataset/train/y_train.txt", col.names = "label")
subject_train <- read.table("UCI HAR Dataset/train/subject_train.txt", col.names = "subject")

x_test <- read.table("UCI HAR Dataset/test/X_test.txt", col.names = features$functions)
y_test <- read.table("UCI HAR Dataset/test/y_test.txt", col.names = "label")
subject_test <- read.table("UCI HAR Dataset/test/subject_test.txt", col.names = "subject")

activities <- read.table("UCI HAR Dataset/activity_labels.txt", col.names = c("label", "activity"))

## Step 1. Merge training and test sets to create one data set.
df_train <- cbind(subject = subject_train, label = y_train, x_train)
df_test <- cbind(subject = subject_test, label = y_test, x_test)
df_merged <- merge(df_train, df_test, by.x = "subject", by.y = "label")

## Step 2. Extracts only the measurements on the mean and standard deviation for each measurement.
df_tidy <- df_merged %>%
  select(subject, label, contains("mean"), contains("std"))

## Step 3. Uses descriptive activity names to name the activities in the data set
df_tidy$label <- activities[df_tidy$label, 2]

## Step 4. Appropriately labels the data set with descriptive variable names.
names(df_tidy)[2] <- "activity"
names(df_tidy) <- gsub("Acc", "accelerometer", names(df_tidy))
names(df_tidy) <- gsub("Gyro", "gyroscope", names(df_tidy))
names(df_tidy) <- gsub("BodyBody", "body", names(df_tidy))
names(df_tidy) <- gsub("Mag", "magnitude", names(df_tidy))
names(df_tidy) <- gsub("^t", "time", names(df_tidy))
names(df_tidy) <- gsub("^f", "frequency", names(df_tidy))
names(df_tidy) <- gsub("tBody", "timebody", names(df_tidy))
names(df_tidy) <- gsub("-mean()", "mean", names(df_tidy), ignore.case = TRUE)
names(df_tidy) <- gsub("-std()", "std", names(df_tidy), ignore.case = TRUE)
names(df_tidy) <- gsub("-freq()", "frequency", names(df_tidy), ignore.case = TRUE)
names(df_tidy) <- gsub("angle", "angle", names(df_tidy))
names(df_tidy) <- gsub("gravity", "gravity", names(df_tidy))
names(df_tidy) <- tolower(names(df_tidy_mean))

## Step 5. From the data set in step 4, creates a second, independent tidy 
## data set with the average of each variable for each activity and each subject.

df_tidy_mean <- df_tidy %>%
  group_by(subject, activity) %>%
  summarise_all(funs(mean))

write.table(df_tidy_mean, "TidyDataMean.txt", row.names = FALSE)



  