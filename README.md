# Getting-Cleaning-Data-Course
Course Project Getting and Cleaning Data

# Used files
In the r script 'FinalAssignment_GettingCleaningData.R' are multiple files used to create a tidy data set of inertial data.
The following files are used:
- 'features.txt': List of all features.
- 'activity_labels.txt': Links the class labels with their activity name
- 'train/X_train.txt': Training set.
- 'train/y_train.txt': Training labels.
- 'test/X_test.txt': Test set.
- 'test/y_test.txt': Test labels.

All those files are gathered from the internet:
https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip

# How the script 'run_analysis.R' works
1. The script reads Samsung data (from zip-file)
2. It merges training and test data sets
3. Mean of the values are calculated and gathered in a tidy dataset
4. Variables names are made comprehensive to understand

   
