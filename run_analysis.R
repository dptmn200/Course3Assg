
########## Part 1 - Merges the training and the test sets to create one data set - Start ##########

        ## Test data sets - Start ##
        
                # Extract Test datasets
                X_test <- read.table("C:/Location/UCI HAR Dataset/test/X_test.txt")
                Y_test <- read.table("C:/Location/UCI HAR Dataset/test/Y_test.txt")
                subject_test <- read.table("C:/Location/UCI HAR Dataset/test/subject_test.txt")
                features <- read.table("C:/Location/UCI HAR Dataset/features.txt")
                
                # Check imported files
                head(X_test,1)
                head(Y_test,1)
                head(subject_test,1)
                head(features,1)
                
                # Get column names 
                colnames(X_test) <- features$V2
                colnames(Y_test) <- "type"
                colnames(subject_test) <- "subject"
                
                # create a key
                index <- 1:nrow(X_test)
                
                # Include index
                X_test <- cbind(X_test,index)
                Y_test <- cbind(Y_test,index)
                subject_test <- cbind(subject_test,index)
                
                # Merge Files
                sub_test <- merge(Y_test,subject_test,by="index", all = TRUE )
                test <- merge(sub_test,X_test,by="index",all=TRUE)
                
                # check merge
                head(test)
                
                # Include Test flag
                test <- cbind(test,"test")
                head(test)
        
        
        ## Test data sets - End ##
        
        
        ## Train data sets - Start ##
        
                # Extract Test datasets
                X_train <- read.table("C:/Location/UCI HAR Dataset/train/X_train.txt")
                Y_train <- read.table("C:/Location/UCI HAR Dataset/train/Y_train.txt")
                subject_train <- read.table("C:/Location/UCI HAR Dataset/train/subject_train.txt")
                ##features <- read.table("C:/Location/UCI HAR Dataset/features.txt")
                
                # Check imported files
                head(X_train,1)
                head(Y_train,1)
                head(subject_train,1)
                ##head(features,1)
                
                # Get column names 
                colnames(X_train) <- features$V2
                colnames(Y_train) <- "type"
                colnames(subject_train) <- "subject"
                
                # create a key
                index <- 1:nrow(X_train)
                
                # Include index
                X_train <- cbind(X_train,index)
                Y_train <- cbind(Y_train,index)
                subject_train <- cbind(subject_train,index)
                
                # Merge Files
                sub_train <- merge(Y_train,subject_train,by="index", all = TRUE )
                train <- merge(sub_train,X_train,by="index",all=TRUE)
                
                # check merge
                head(train)
                
                
                # Include Test flag
                train <- cbind(train,"train")
                head(train)
        
        ## Train data sets - End ##
        
        
        
        ## Bind test and train datasets - Start##
        
                names(test)[565]<-"flag"
                head(test,1)
                names(train)[565]<-"flag"
                head(train,1)
                
                combined_data <- rbind(test,train)
                
        
        ## Bind test and train datasets - End##


########## Part 1 - Merges the training and the test sets to create one data set - End ##########


########## Part 2 - Extracts only the measurements on the mean and standard deviation for each measurement - Start ##########

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
