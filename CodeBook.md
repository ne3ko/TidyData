==================================================================
'run_analysis.R' Code Book
==================================================================
Nicholas Alexander
Corsera - Getting and Cleaning Data
===================================
The following functions and variables can be found in 'run_analysis.R' in the following 
format:
-FUNCTION
	-VARIABLE
==================================================================
- 'run_analysis()': Reads the 8 files (refer to README.md), combines them, organizes the data to be easily readable, then writes the tidy data into a csv file: 'Tidy_Data.csv'.
	- 'sub_test': Reads and stores 'UCI HAR Dataset/test/subject_test.txt'.
	- 'xtest': Reads and stores 'UCI HAR Dataset/test/X_test.txt'.
	- 'ytest': Reads and stores 'UCI HAR Dataset/test/y_test.txt'.
	- 'sub_train': Reads and stores 'UCI HAR Dataset/train/subject_train.txt'.
	- 'xtrain': Reads and stores 'UCI HAR Dataset/train/X_train.txt'.
	- 'ytrain': Reads and stores 'UCI HAR Dataset/train/y_train.txt'.
	- 'feat': Reads and stores 'UCI HAR Dataset/features.txt'.
	- 'act_lbls': Reads and stores 'UCI HAR Dataset/activity_labels.txt'.

	- 'xdata': Merges the test and train data.
	- 'ydata': Merges the test and train labels
	- 'sub_data': Merges test and train subjects
	- 'data': Merges 'xdata', 'ydata', and 'sub_data'

	- 'ext_data': Stores the extracted mean and standard deviation of each measurement as logical objects (refer to extract_data() below).
	- 'subset': Stores a subset of 'data' using the logical objects from 'ext_data'

	- 'data': Stores the updated data frame every time it is changed

	- 'SubjectNum': Stores the SubjectNum column from 'data'
	- 'Activity': Stores the Activity column from 'data'
***'SubjectNum' and 'Activity' needed to match the column names, because they are placed into the dataframe under these names after using them in 'aggregate()'***


- 'extract_data()': Changes the class of each element of the data frame to a logical object and returns a logical data frame.
	- 'mean': Searches for a column match for all means and returns TRUE/FALSE for each column.
	- 'std': Searches for a column match for all standard deviations and returns TRUE/FALSE for each column.
	- 'act': Searches for a colomn match for "ActivityNum" and returns TRUE/FALSE for each column.
	- 'sub': Searches for a colomn name for "SubjectNum" and returns TRUE/FALSE for each column.

	- 'ext_data': Combines the logical arguments from the above variables, defaults to TRUE.


- 'clean_variables()': Cleans up the variables in each column names using g_sub. Makes the variables descriptive and lower case for easy access.
	- 'variables': Stores the updated column names thoughout each modification.
