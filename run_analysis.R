#download the zipped data files
fileURL="https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
destfile <- "data.zip"
download.file(fileURL, destfile)
#unzip the data files in the working directory
unzip("data.zip", files = NULL, list = FALSE, overwrite = TRUE,junkpaths = FALSE, exdir = ".", unzip = "internal",setTimes = FALSE)
# read features - this will will be used to label the columns
features <- read.table("UCI HAR Dataset/features.txt", header=FALSE, sep="")
#read y_train, x_train and subject_train data
y_train <- read.table("UCI HAR Dataset/train/y_train.txt", header=FALSE, sep="")
x_train <- read.table("UCI HAR Dataset/train/x_train.txt", header=FALSE, sep="")
subject_train <- read.table("UCI HAR Dataset/train/subject_train.txt", header=FALSE, sep="")
# rename column(s)? in y_train, x_train and subject_train data 
names(y_train) <- "y"
names(x_train) <- features[,2]
names(subject_train) <- "subject"
#read y_test, x_test and subject_test data
y_test <- read.table("UCI HAR Dataset/test/y_test.txt", header=FALSE, sep="")
x_test <- read.table("UCI HAR Dataset/test/x_test.txt", header=FALSE, sep="")
subject_test <- read.table("UCI HAR Dataset/test/subject_test.txt", header=FALSE, sep="")
# rename column(s)? in y_test, x_test and subject_test data 
names(y_test) <- "y"
names(x_test) <- features[,2]
names(subject_test) <- "subject"
#Extract only the measurements on the mean and standard deviation for each measurement.
## here the assumption is that we only need thoese variables which either contain 'mean()' or 'std()'
toMatch <- c(".*mean\\(\\).*$", ".*std\\(\\).*$")
## to do this I have used a grep command on features data set and the variable 'matches' contain indices for all the veriables of interest.
matches <- grep(paste(toMatch,collapse="|"),features$V2, value=FALSE)
#step 2 -extract only the variable of interest from x_train (mean and std variables): 66 variables 
x_train_sub <- x_train[matches]
#step 2 -extract only the variable of interest from x_test (mean and std variables): 66 variables 
x_test_sub <- x_test[matches]
#step 1-merge train and test dataset
#merge training data - first column is y train, followed by the subject variable followed by x_train mean and std veriables
train<-cbind(y_train,subject_train,x_train_sub)
#merge test data - first column is y test, followed by the subject variable followed by x_test mean and std veriables
test<-cbind(y_test,subject_test,x_test_sub)
data<-rbind(train,test)
#merged data contains 10299 rows, 68 cols
#read activities encoding file
activity <- read.table("UCI HAR Dataset/activity_labels.txt", header=FALSE, sep="")
#rename activity data
names(activity) <- c("y","activity")
#step 3/4-decode the activities
data_with_activity<-merge(data,activity,by.x="y",by.y="y",all=TRUE)
#remove the encoded activity variable
data_with_activity_minus_y<-data_with_activity[,-c(1)] 
#step 5-Creates a second, independent tidy data set with the average of each variable for each activity and each subject. 
# install and load reshape2 package
install.packages("reshape2")
library(reshape2)
#melt and dcast
#melt is used to reshape the data along "activity","subject" variables.
#followed by dcast to rearrange: mean is used to get the averages
#for 30 subject and 6 different activities we get 30X6=180 rows.
#first column is activity
#second column is subject
#follwed by 66 columns for avaerage mean and avaergae std variables for activity and subject in first two colum
#so overall 180 rows,1+1+66=68 columns
data_melt<-melt(data_with_activity_minus_y,id=c("activity","subject"))
data_casted<-dcast(data_melt,activity+subject~variable,mean)
#export the tidy data: 1(header)+ 180=181 rows,1+1+66=68 columns
write.table(data_casted, file = "output.txt",row.names=FALSE)
    