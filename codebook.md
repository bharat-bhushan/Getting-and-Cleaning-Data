The file ‘output.txt’ (present in the repository) is the output file for the project.
About output.txt:
* The file contains the tidy data set with the average of each variable (all the mean and std variables listed below) for each activity (6 different activities: WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING, STANDING, LAYING) and each subject (total 30 subjects), melt and dcast functions are used and mean is used in the dcast function to get the averages.
* File structure 1(header)+ 180=181 rows,1+1+66=68 columns
* Columns/variables
1. activity: WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING, STANDING, LAYING
2. subject: the id for the subject ranges from 1 to 30.
3. Column 3 to 68 contains average values for mean and std variables. for the activity in column 1 for the subject in column 2. Here are the details for these 66 variables

About ‘run_analysis.R’ file:
As part of the project script file – ‘run_analysis.R’ (present in the repository) has been created. The script file does the following
* download the zipped data files from https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip
* unzip the data files in the working directory
* read features - this will be used to label the columns
* read y_train, x_train and subject_train data
* read y_test, x_test and subject_test data
* identify the mean and std variables from 561 variables in x_train and x_test and subset. This is achived using a regex. Total 66 variables (contain ‘mean ()' or ‘std ()') in both x_train and x_test data.
* First merge train data
** 1 column form y_train renamed it to 'y'
** 1 column from subject_train renamed it to 'subject'
** followed be 66 columns for mean and std variables. All these variables are also renamed using feature.txt file
* Then in same way merge test data 
* Then combined train and test data. The merged data now contain 10299 rows, 68 cols
* Decoded the activities (the numbers in column y) using "activity_labels.txt" file
* To get the independent tidy data set with the average of each variable for each activity and each subject, melt and dcast functions are used and mean is used in the dcast function to get the averages.
* Finally exported the tidy data: 1(header) + 180=181 rows, 1+1+66=68 columns as 'output.txt' using write.table command. The columns are separated by space and the text is enclosed using quote.

Source of the original data: https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip
Original description: http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones

