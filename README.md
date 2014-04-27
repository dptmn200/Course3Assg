This document provides a list of all the assumptions made for all the sections of the assignment

Please note that, through out the script, some steps have been included which are relevant only for validation of the previous steps and might not be very useful to achive the goal itself


########## Part 1 - Merges the training and the test sets to create one data set - Start ##########
Assumptions: 
1. X_test, Y_test and subject_test are considered to be the cleaned datasets while Inertial signals datasets are considered to be raw forms of the same datasets. Hence only X_test, Y_test and subject_test datasets are considered for analysis
2. An assumption that X_test, subject_test, y_test are in the same order has been made for merging purposes
3. All the other datasets such as activity_labels, features, features_info are used as per requirement
4. Row binding is considered to be merging in this exercise
########## Part 1 - Merges the training and the test sets to create one data set - End ##########


########## Part 2 - Extracts only the measurements on the mean and standard deviation for each measurement - Start ##########
Assumption: 
1. Only those columns that specifially mentions "mean()" or "std()" are considered here
########## Part 2 - Extracts only the measurements on the mean and standard deviation for each measurement - End ##########


########## Part 3 - Uses descriptive activity names to name the activities in the data set - Start ##########
Assumptions: 
1.Here I've assumed that we need to Map the activity code 1 to 6 with corresponding activity name
########## Part 3 - Uses descriptive activity names to name the activities in the data set - End ##########


########## Part 4 - Appropriately labels the data set with descriptive activity names - Start ##########
Assumptions:
1. Here I've assumed that we need to Map the activity name to activity code in the combined dataset (with all the variables not the subset obtained in part 2)
2. Data set refers to master dataset with all the columns and not the subset with just mean and std
########## Part 4 - Appropriately labels the data set with descriptive activity names - End ##########


########## Part 5 - Creates a second, independent tidy data set with the average of each variable for each activity and each subject - Start ##########
Assumptions:
1. A tidy dataset with average of all the variables (not restricted to those with only mean and std obtained in part 2) has been created for all possible combinations of activity and subject
########## Part 5 - Creates a second, independent tidy data set with the average of each variable for each activity and each subject - End ##########
