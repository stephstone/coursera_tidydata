#This file contains two functions: 
#1) combine_data combines subject ID, activity ID and name, and accelerometer data for both test and train data. outputs flat file
#2) tidy_means uses the flat file from combine_data, summarizes by subject and activity, and outputs the tidy data set for submission 

combine_data <- function(){

#load table with activity_id and activity_name mapping
features <- read.table("UCI HAR Dataset/features.txt",header=FALSE)

#load training data files from samsung repository, using descriptive variable titles from features file
xtrain <- read.table("UCI HAR Dataset/train/x_train.txt",header=FALSE,col.names=features[,2])

#reduce file to only columns containing mean and standard deviation data
matches <- c(grep("std",names(xtrain)),grep("mean",names(xtrain)))
xtrain <- xtrain[,matches]

#load activity_id and subject ID for training data set
ytrain <- read.table("UCI HAR Dataset/train/y_train.txt",header=FALSE,col.names="activity_id")
subtrain <- read.table("UCI HAR Dataset/train/subject_train.txt",header=FALSE,col.names="subj_id")

#combine data, subject_id and activity_id
traindata <- cbind(xtrain,ytrain,subtrain)

#load test data files from samsung repository, using descriptive variable titles from features file
xtest <- read.table("UCI HAR Dataset/test/x_test.txt",header=FALSE,col.names=features[,2])
matches2 <- c(grep("std",names(xtest)),grep("mean",names(xtest)))
xtest <- xtest[,matches2]

#load activity_id and subject ID for test data set
ytest <- read.table("UCI HAR Dataset/test/y_test.txt",header=FALSE,col.names="activity_id")
subtest <- read.table("UCI HAR Dataset/test/subject_test.txt",header=FALSE,col.names="subj_id")

#combine data, subject_id and activity_id
testdata <- cbind(xtest,ytest,subtest)

#combine training and test data into single file
superset <- rbind(testdata,traindata)

#map activity name to activity id, add to data set
activity_name <- read.table("UCI HAR Dataset/activity_labels.txt",header=FALSE,col.names=c("id","activity_name"))
bigdata <- merge(superset,activity_name,by.x="activity_id",by.y="id",all.x=TRUE,sort=FALSE)

#output the combined file to text for use by subsequent functions
write.table(bigdata,file="UCI HAR Dataset/bigdata.txt",row.name=FALSE)

}

tidy_means <- function(){

#read in data file output from combine_data function
newdf <- read.table("UCI HAR Dataset/bigdata.txt",header=TRUE)

#group data by subject and activity, and report mean of each group for each variable in file
aggdf <- aggregate(newdf,by=list(newdf$activity_name,newdf$activity_id,newdf$subj_id),FUN=mean,na.rm=TRUE)

#reduce file to exclude variables associated with grouping functions.  redundant and confusing, so eliminating.
aggdf <- aggdf[,!(colnames(aggdf) %in% c("activity_name","activity_id","subj_id"))]

#change descriptive names of variables to include the word 'mean'
colname_new <- colnames(aggdf)
for(i in seq_along(colname_new)){colname_new[i] <- paste(colname_new[i],"_mean")}

#change descriptive names of groups to reflect the underlying variable names used in the group
colname_new[1:3] <- c("activity_name","activity_id","subject_id")
colnames(aggdf) <- colname_new

#output the resulting tidy data file
write.table(aggdf,file="UCI HAR Dataset/tidydata.txt",row.name=FALSE)


}
