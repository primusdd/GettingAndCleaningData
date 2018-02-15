## Submission for the programming assignment from week 4 of the "Getting and cleaning data" course on Coursera
## Created by Daniel Hubbeling, February 2017

## The code in this file will:
## 1. Merges the training and the test sets to create one data set.
## 2. Extracts only the measurements on the mean and standard deviation for each measurement.
## 3. Uses descriptive activity names to name the activities in the data set
## 4. Appropriately labels the data set with descriptive variable names.
## 5. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.

##Load the dplyr package, because we need it
library(dplyr)

##If the folder with data doesn't exist download and unzip it
if (!file.exists("UCI HAR Dataset")) { 
  
  print("Getting the data...")
  
  ##Get the file from the assignment and put in the current working directory
  download.file("https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip", "week4-dataset.zip")

  ##Unzip the file we got into the current working directory
  unzip("week4-dataset.zip")
}


  ##read the feature labels into a vector, we will use these as colum names when reading the data files
  feature_labels<-read.table("UCI HAR Dataset/features.txt", header=FALSE, sep="")
  feature_labels_vector<-as.vector(unlist(feature_labels[,2], use.names=FALSE))
  
  ## for the "train" dataset
  ##Read the x values from the source file
  input_train<-read.table("UCI HAR Dataset/train/X_train.txt", header=FALSE, sep="", col.names=feature_labels_vector)

  ##Add subject info to the train dataset
  input_train_subjects<-read.table("UCI HAR Dataset/train/subject_train.txt", header=FALSE, col.names=c("subject"))
  input_train["Subject"]<-input_train_subjects

  ##Add activity data to the train dataset
  input_train_activities<-read.table("UCI HAR Dataset/train/Y_train.txt", header=FALSE, col.names=c("activity"))
  input_train["Activity"]<-input_train_activities
  
  ##And add a column specifying which dataset (train or test) this data comes from
  input_train["Dataset"]<-"train"
  
  ## ... and for the "test" dataset
  ##Read the x values from the source file
  input_test<-read.table("UCI HAR Dataset/test/X_test.txt", header=FALSE, sep="", col.names=feature_labels_vector)
  
  ## Add subject info to the train dataset
  input_test_subjects<-read.table("UCI HAR Dataset/test/subject_test.txt", header=FALSE, col.names=c("subject"))
  input_test["Subject"]<-input_test_subjects
  
  ## Add activity data to the train dataset
  input_test_activities<-read.table("UCI HAR Dataset/test/Y_test.txt", header=FALSE, col.names=c("activity"))
  input_test["Activity"]<-input_test_activities
  
  ## And add a column specifying which dataset (train or test) this data comes from
  input_test["Dataset"]<-"test"
  
  ## Now that we have both datasets loaded, merge both datasets into one
  all_data<-rbind(input_test, input_train)
  print("1. Merges the training and the test sets to create one data set......Completed")
  
  
  
  ## From the entire data get only the mean and standard deviation for each measurement, including the Activity and Subject which is measurement metadata
  mean_and_std <- select(all_data, Subject, Activity, contains(".mean."), contains(".std."))
  print("2. Extracts only the measurements on the mean and standard deviation for each measurement.....Completed")
  
  
  
  ## Now read the activity labels to make sense of the numbers currently in the dataset
  activity_labels<-read.table("UCI HAR Dataset/activity_labels.txt", header=FALSE, col.names=c("activity_id","activity_name"))
  
  ## and merge this with the data set, the result will have an additional column "activity_name" that shows the name of the activity
  mean_and_std_named <- merge(mean_and_std, activity_labels, by.x="Activity", by.y="activity_id")
  
  print("3. Uses descriptive activity names to name the activities in the data set....Completed")
  
  
  
  ## ....actually already used appropriate labels from the start for all data sets so just show it
  View(mean_and_std_named)
  print("4. Appropriately labels the data set with descriptive variable names......Completed") 
  
  
  
  ## Using chaining, group the measurements by activity and subject and get the mean for all variables
  avg_activity_subject <- mean_and_std_named %>% group_by(Activity, activity_name, Subject) %>% summarise_all(mean)
  
  View(avg_activity_subject)
  print("5. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.")
  
  ## Write the table to a text file to submit it
  write.table(avg_activity_subject, "week4_data.txt", row.names = FALSE)
  
  
  
