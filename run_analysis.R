## The following function reads 8 files, combines them, and organized the data to be
## easily readable

run_analysis <- function(){
	## Reads all data needed to merge the data
	## ***The following requires you to be one directory outside of the "UCI HAR Dataset" directory***
	sub_test <- read.table("UCI HAR Dataset/test/subject_test.txt")		## Reads the subjects who performed the activities; Range 1-30
	xtest <- read.table("UCI HAR Dataset/test/X_test.txt")			## Reads the test set
	ytest <- read.table("UCI HAR Dataset/test/y_test.txt")			## Reads the test labels

	sub_train <- read.table("UCI HAR Dataset/train/subject_train.txt")	## Reads the subjects who performed the activities; Range 1-30
	xtrain <- read.table("UCI HAR Dataset/train/X_train.txt")			## Reads the train test
	ytrain <- read.table("UCI HAR Dataset/train/y_train.txt")			## Reads the test labels

	feat <- read.table("UCI HAR Dataset/features.txt")				## Reads the list of features
	act_lbls <- read.table("UCI HAR Dataset/activity_labels.txt")		## Reads the class labels with their activity name


	## Assigns column names to the data sets
	## Makes merging much simpler if done prior
	colnames(sub_train) <- "SubjectNum"							## Matches column names for sub_train & sub_test
	colnames(sub_test) <- "SubjectNum"

	colnames(xtrain) <- feat[,2]								## Matches column names for xtrain & xtest with
	colnames(xtest) <- feat[,2]								## the features in "features.txt"

	colnames(ytrain) <- "ActivityNum"							## Matches column names of the training & test
	colnames(ytest) <- "ActivityNum"							## labels

	colnames(act_lbls) <- c("ActivityNum", "Activity")				## Matches act_lbls with the ytest & ytrain labels	
													## Used to match activities with data later

	## Now to merge all of the data
	xdata <- rbind(xtest, xtrain)								## Merges the data for test & train
	ydata <- rbind(ytest, ytrain)								## Merges the lest labels for test & train
	sub_data <- rbind(sub_test, sub_train)						## Merges the subjects for test & train

	data <- cbind(xdata, ydata, sub_data)						## Merges all the data

	## Extracts only the mean and standard deviation for each measurement
	ext_data <- extract_data(data)							## View extract_data function below...

	subset <- data[,ext_data == TRUE]							## Returns the TRUE values of the
													## extract_data function

	## Uses descriptive activity names to name the activities in the data set
	data <- merge(subset, act_lbls)							## Merges the activity labels with
													## the data set
	data <- data[,c(81,1,82,2:80)]


	## Creates a tidy data set with the average of each variable for each activity and each subject
	SubjectNum <- data[,1]									## Places "SubjectNUM" into an object
	Activity <- data[,3]									## Places "Activity" into an object

	data <- aggregate(. ~ SubjectNum + Activity , data[,c(2,4:82)], mean)	## Finds the mean of each variable in terms of the subject number and the activity
	data <- data[,c(1,3,2,4:82)]								## Sorts columns to look pretty
	data <- data[order(data[,2],data[,1]),]						## Sorts activity number and subject number rows to look pretty


	## Labels the data set with descriptive variable names
	colnames(data) <- clean_variables(data)						## View clean_variables function below...

	##Now to write the file
	write.csv(data, "Tidy_Data.csv", row.names = FALSE)				## I like csv files, because they tend to look nicer
}													## in my opinion


##Extracts needed data for the function, including the mean and std, and places it into an object
extract_data <- function(data){
	mean <- grepl("mean..", colnames(data))		## Searches for a column match for each of 
	std <- grepl ("std..", colnames(data))		## the column names, and returns TRUE/FALSE
	act <- grepl("ActivityNum", colnames(data))	## depending on whether or not there is a match
	sub <- grepl("SubjectNum", colnames(data))	##	"	"

	ext_data <- (mean | std | act | sub)		## Combines all of the grepl functions into one
	ext_data							## logical function
}

## Cleans the variables, making them descriptive and lower case for easy calling
clean_variables <- function(data){
	variables <- names(data)	

	variables <- gsub("-", " ", variables,)				## Replaces "-" with a space
	variables <- gsub("fBody", "Body", variables,)			## Removes the "f"
	variables <- gsub("tBody", "Body", variables,)			## Removes the "t"
	variables <- gsub("BodyBody", "Body", variables)		## Removes extra "Body"
	variables <- gsub("tGravity", "Gravity", variables)		## Removes the "t"				
	
	variables <- make.names(variables)					## Turns characters into valid names
											## (Gets rid of the "()")
	variables <- gsub("([A-Z])", " \\1", variables,)		## Adds a space before the capital letters

	variables <- gsub("Acc", "accelerometer", variables,)		## Turns the abbrevations of each word into
	variables <- gsub("Gyro", "gyroscope", variables,)		## their full names
	variables <- gsub("Mag", "magnitude", variables,)		##	" 	"
	variables <- gsub("Freq", "frequency", variables,)		##	"	"
	variables <- gsub("Num", "number", variables,)			##	"	"

	variables <- gsub("\\."," ", variables,)				## Removes periods
	variables <- gsub("^\\s+|\\s+$","", variables,)			## Removes leading and trailing spaces
	variables <- gsub("\\s+"," ", variables,)				## Removes excess spaces

	variables <- tolower(variables)					## Makes all variables lower case
	variables
}
