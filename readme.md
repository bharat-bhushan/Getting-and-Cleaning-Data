This repository cotains the following files:
    run_analysis.R
    codebook.md
    output.txt
    readme.md
The 'run_analysis.R' file contains the R code that can be used to achieve the following:
* download the zipped data files from https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip
* unzip the data files in the working directory
* read features - this will be used to label the columns
* read y_train, x_train and subject_train data
* read y_test, x_test and subject_test data
* identify the mean and std variables from 561 variables in x_train and x_test and subset. This is achived using a regex. Total 66 variables (contain 'mean ()' or 'std ()') in both x_train and x_test data.
* First merge train data
** 1 column form y_train renamed it to 'y'
** 1 column from subject_train renamed it to 'subject'
** followed be 66 columns for mean and std variables. All these variables are also renamed using feature.txt file
* Then in same way merge test data 
* Then combined train and test data. The merged data now contain 10299 rows, 68 cols
* Decoded the activities (the numbers in column y) using "activity_labels.txt" file
* To get the independent tidy data set with the average of each variable for each activity and each subject, melt and dcast functions are used and mean is used in the dcast function to get the averages.
* Finally export the tidy data: 1(header) + 180=181 rows, 1+1+66=68 columns as 'output.txt' using write.table command. The columns are separated by space and the text is enclosed using quote.


The codebook.md file describes the ouput file 'output.txt' of run_analysis.R. The file also explains diffrent steps done by 'run_analysis.R' to get the desired ouput file 'output.txt' 


The data used to generate the files in this repository was downloaded from https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip on 2014 04 15. For detailed information about the data see http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones


[1] Davide Anguita, Alessandro Ghio, Luca Oneto, Xavier Parra and Jorge L. Reyes-Ortiz. Human Activity Recognition on Smartphones using a Multiclass Hardware-Friendly Support Vector Machine. International Workshop of Ambient Assisted Living (IWAAL 2012). Vitoria-Gasteiz, Spain. Dec 2012
