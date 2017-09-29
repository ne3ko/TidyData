==================================================================
Tidy Data - Getting and Cleaning Data Course Project
Version 1.0
==================================================================
Nicholas Alexander
Corsera - Getting and Cleaning Data
===================================
- The following R file, run_analysis.R, reads in 8 files from 3 folders:
- ./UCI HAR Dataset
	- activity_labels.txt
	- features.txt
- ./UCI HAR Dataset/test
	- subject_test.txt
	- X_test.txt
	- y_test.txt
- ./UCI HAR Dataset/train
	- subject_train.txt
	- X_train.txt
	- y_train.txt

- The program then merges the files into one large file, using the activity_labels.txt as column names.
- From here, it extracts the mean and the standard deviation from the data, and creates a subset.
- Lastly, is averages all the excess data, and sorts it into a readable format.
- It is then written into a csv file (personally, I like the look better than a txt file)

The dataset includes the following files:
=========================================
- 'README.md'
- 'CodeBook.md': Explains the variables and functions in 'run_analysis.R'.
- 'Tidy_Data.csv': Shows the clean data as a result of 'run_analysis.R'.
- 'run_analysis.R': Reads the following files, merges them, and organizes the data to be easily readable.
	- './UCI HAR Dataset/activity_labels.txt': Links the class labels with their activity name.
	- './UCI HAR Dataset/features.txt': List of all features.
	- './UCI HAR Dataset/test/subject_test.txt': The subject who performed the activity.
	- './UCI HAR Dataset/test/X_test.txt': Test set.
	- './UCI HAR Dataset/test/y_test.txt': Test labels.
	- './UCI HAR Dataset/train/subject_train.txt': The subject who performed the activity.
	- './UCI HAR Dataset/train/X_train.txt': Train set.
	- './UCI HAR Dataset/train/y_train.txt': Train labels.
- './UCI HAR Dataset/features_info.txt': Explains the features
- './UCI HAR Dataset/README.txt': Explains the experiment and data collection.

