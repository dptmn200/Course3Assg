This is a Code book describing different variables and transformations at different levels. I've used the pieces of code for convenience of description.

I have also included a few assumptions wherever necessary. A set of all the assumptions has been detailed in README.md


########## Part 1 - Merges the training and the test sets to create one data set - Start ##########

## Test data sets - Start ##
        
                # Extract Test datasets
                X_test : Imported data
                Y_test : Imported data
                subject_test : Imported data
                features : imported data
                
                              
                # To clean the data and rename columns appropriately
                colnames(X_test) <- features$V2
                colnames(Y_test) <- "type"
                colnames(subject_test) <- "subject"
                
                # Create an index to merge different datasets on.
		# Here the Assumption is that data in all the datasets is in the same order
                index <- 1:nrow(X_test)
                
                # Include index into corresponding datasets
                X_test <- cbind(X_test,index)
                Y_test <- cbind(Y_test,index)
                subject_test <- cbind(subject_test,index)
                
                # Merge Files files on index created
                sub_test <- merge(Y_test,subject_test,by="index", all = TRUE )
                test <- merge(sub_test,X_test,by="index",all=TRUE)
                
                # Include Test flag to identify test from trial. This will be useful when test and trial datasets are merged
                test <- cbind(test,"test")
                head(test)
        
        
## Test data sets - End ##
        
        
        ## Train data sets - Start ##
        
	## Same process as with test datasets has been followed here.
    
        ## Train data sets - End ##
        
        
        
        ## Bind test and train datasets - Start##
    
		## rename the variables test and trials as flag so that the two datasets can be merged	    
                names(test)[565]<-"flag"
                head(test,1)
                names(train)[565]<-"flag"
                head(train,1)
                
		## Merge the two datasets - test and train
                combined_data <- rbind(test,train)
                
      
        ## Bind test and train datasets - End##

########## Part 1 - Merges the training and the test sets to create one data set - End ##########



########## Part 2 - Extracts only the measurements on the mean and standard deviation for each measurement - Start ##########

## Assumption: Only those columns that specifially mentions "mean()" or "std()" are considered here

        ## Create a temp object with all the column names
        temp3 <- colnames(combined_data)
        temp3
        
        ## Subset for column names with mean()
        mean_set <- grepl("mean()",temp3,fixed=TRUE)
        temp3[mean_set]
        
        ## Subset for column names with std()
        std_set <- grepl("std()",temp3,fixed=TRUE)
        temp3[std_set]
        
        
        ## Subset data with mean and std
        mean_std_data <- combined_data[c("index","type","subject","flag",temp3[mean_set],temp[std_set])]
        
        ## Check output columns
        colnames(mean_std_data)


########## Part 2 - Extracts only the measurements on the mean and standard deviation for each measurement - End ##########


########## Part 3 - Uses descriptive activity names to name the activities in the data set - Start ##########

## Interpretation and Assumption: Here I've assumed that we need to Map the activity code 1 to 6 with corresponding activity name


        # Import activity name file
        activity <- read.table("C:/Location/UCI HAR Dataset/activity_labels.txt")
        
        # Label columns
        names(activity)[1]<-"type"
        names(activity)[2]<-"activity"


########## Part 3 - Uses descriptive activity names to name the activities in the data set - End ##########


########## Part 4 - Appropriately labels the data set with descriptive activity names - Start ##########

        ## Interpretation and Assumption 1: Here I've assumed that we need to Map the activity name to activity code in the combined dataset
        ## Interpretation and Assumption 2: Data set refers to master dataset with all the columns and not the subset with just mean and std
        
        ## Merge combined_data and activity
        
        combined_activity <- merge(combined_data, activity, by = "type", all = TRUE)

########## Part 4 - Appropriately labels the data set with descriptive activity names - End ##########



########## Part 5 - Creates a second, independent tidy data set with the average of each variable for each activity and each subject - Start ##########


        # List the numeric variables
        Data <- combined_activity
        numericvars <- NULL
        for (Var in names(Data)) {
                if(class(Data[,Var]) == 'integer' | class(Data[,Var]) == 'numeric') {
                        numericvars <- c(numericvars,Var)
                }
        }
        numericvars
        
        
        # Remove Subject, index and type variables as average of these variables do not make sense in the analysis
        col_name <- numericvars[4:564]
        
        # Split the data and calculate column mean 
        split_data <- split(combined_activity,list(combined_activity$subject,combined_activity$activity))
        
        # Output
        check_av <- sapply(split_data,function(x) colMeans(x[col_name],na.rm=TRUE))
        
        
        write.table(check_av, "C:/Location/UCI HAR Dataset/final_tidy_data.txt", sep="\t")
        
        
        # Check output sample
        head(check_av,1)
        colnames(check_av)


########## Part 5 - Creates a second, independent tidy data set with the average of each variable for each activity and each subject - End ##########
