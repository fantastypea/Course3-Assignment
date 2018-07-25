## load data
path_rf <- file.path("assignment3" , "UCI HAR Dataset")
Y_test  <- read.table(file.path(path_rf, "test" , "Y_test.txt" ),header = FALSE)
Y_train <- read.table(file.path(path_rf, "train" , "Y_train.txt" ),header = FALSE)
x_test <- read.table(file.path(path_rf, "test" , "X_test.txt" ),header = FALSE)
x_train <- read.table(file.path(path_rf, "train" , "X_train.txt" ),header = FALSE)
subtrain <- read.table(file.path(path_rf, "train", "subject_train.txt"),header = FALSE)
subtest <- read.table(file.path(path_rf, "test", "subject_test.txt"),header = FALSE)
feature <- read.table(file.path(path_rf, "features.txt"),head=FALSE)
activitylabel <- read.table(file.path(path_rf, "activity_labels.txt"),header = FALSE)
## bind the data to one data set
data1 <- rbind(x_test,x_train)
data2 <- rbind(subtest,subtrain)
data3 <- rbind(Y_test,Y_train)
data <- cbind(data1,data2,data3)
names(data) <- as.character(feature$V2)
names(data)[562]<- "subject"
names(data)[563] <- "activity"
## Extract only mean and std
sub <- grep("mean\\(\\)|std\\(\\)",feature$V2)
subnew <- c(sub,562,563)
subdata <- data[subnew]
## descriptive activity name to name activities
subdata$activity <- factor(subdata$activity)
levels(subdata$activity) <- as.character(activitylabel$V2)
## use descriptive variable names
names(subdata) <- gsub("^t","time",names(subdata))
names(subdata) <- gsub("^f","frequency",names(subdata))
names(subdata) <- gsub("Acc","acceleration",names(subdata))
names(subdata) <- gsub("Gyro","gyroscope",names(subdata))
names(subdata) <- gsub("Mag","magnitude",names(subdata))
## generate new dataset
newdata <- aggregate(. ~subject + activity, subdata, mean)
newdata<-newdata[order(newdata$subject,newdata$activity),]
write.table(newdata, file = "newtidy.txt",row.name=FALSE)






