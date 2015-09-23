combine_data <- function(){
features <- read.table("UCI HAR Dataset/features.txt",header=FALSE)
xtrain <- read.table("UCI HAR Dataset/train/x_train.txt",header=FALSE,col.names=features[,2])
matches <- c(grep("std",names(xtrain)),grep("mean",names(xtrain)))
xtrain <- xtrain[,matches]

ytrain <- read.table("UCI HAR Dataset/train/y_train.txt",header=FALSE,col.names="activity_id")
subtrain <- read.table("UCI HAR Dataset/train/subject_train.txt",header=FALSE,col.names="subj_id")
traindata <- cbind(xtrain,ytrain,subtrain)


xtest <- read.table("UCI HAR Dataset/test/x_test.txt",header=FALSE,col.names=features[,2])
matches2 <- c(grep("std",names(xtest)),grep("mean",names(xtest)))
xtest <- xtest[,matches2]

ytest <- read.table("UCI HAR Dataset/test/y_test.txt",header=FALSE,col.names="activity_id")
subtest <- read.table("UCI HAR Dataset/test/subject_test.txt",header=FALSE,col.names="subj_id")
testdata <- cbind(xtest,ytest,subtest)


superset <- rbind(testdata,traindata)
activity_name <- read.table("UCI HAR Dataset/activity_labels.txt",header=FALSE,col.names=c("id","activity_name"))
bigdata <- merge(superset,activity_name,by.x="activity_id",by.y="id",all.x=TRUE,sort=FALSE)
write.table(bigdata,file="UCI HAR Dataset/bigdata.txt",row.name=FALSE)

}

tidy_means <- function(){
newdf <- read.table("UCI HAR Dataset/bigdata.txt",header=TRUE)
aggdf <- aggregate(newdf,by=list(newdf$activity_name,newdf$activity_id,newdf$subj_id),FUN=mean,na.rm=TRUE)
aggdf <- aggdf[,!(colnames(aggdf) %in% c("activity_name","activity_id","subj_id"))]

colname_new <- colnames(aggdf)
for(i in seq_along(colname_new)){colname_new[i] <- paste(colname_new[i],"_mean")}
colname_new[1:3] <- c("activity_name","activity_id","subject_id")
print(colname_new)
colnames(aggdf) <- colname_new
write.table(aggdf,file="UCI HAR Dataset/tidydata.txt",row.name=FALSE)


}
