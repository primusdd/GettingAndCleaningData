# GettingAndCleaningData
This repository contains files as requested for the programming exercise for week 4 of the Getting and cleaning data course on Coursera.

The assignment is to create an R script that does the following:

1. Merges the training and the test sets to create one data set.
2. Extracts only the measurements on the mean and standard deviation for each measurement.
3. Uses descriptive activity names to name the activities in the data set
4. Appropriately labels the data set with descriptive variable names.
5. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.

Files contained are:

* run_analysis.R: the R script to create the results as specified
* CodeBook.md: the codebook for the created tidy datasets
* README.md: this file

## How it works

To get the results as requested just run the run_analysis.R script and the two datasets as described in 4 and 5 will be shown on screen and a separate .txt file to submit to Coursera. When running the script the follwoing steps are performed:

1. Read the feature labels
2. Read the train data and add all labels, add the subjects and activity ID's
3. Read the test data and add all labels, add the subjects and activity ID's
4. Join the two datasets to form one
5. Select only the mean and std measurements from this set (including the data on subject and activity)
6. Read the activity names overview and merge this with the created dataset to make it more readable, and show it
7. Summarize the data into only the average for all meeasurements, grouped by subject and activity, and show it
8. Write the last set to a text file

