pwd <- "/Users//martin/Dev/datasciencecoursera-repos/datasciencecoursera-cleaning-w3"
#setwd(pwd)

data <- "data"

# -------------------------------
# Load them all
s1 <- read.table(paste(data, "/test/subject_test.txt", sep="")) # who
x1 <- read.table(paste(data, "/test/X_test.txt", sep="")) # features
y1 <- read.table(paste(data, "/test/Y_test.txt", sep="")) # category

s2 <- read.table(paste(data, "/train/subject_train.txt", sep="")) # who
x2 <- read.table(paste(data, "/train/X_train.txt", sep="")) # features
y2 <- read.table(paste(data, "/train/Y_train.txt", sep="")) # category

features <- read.table(paste(data, "/features.txt", sep=""))
activities <- read.table(paste(data, "/activity_labels.txt", sep=""))

# -------------------------------
# Merges the training and the test sets to create one data set.
s <- rbind(s1,s2)
x <- rbind(x1,x2)
y <- rbind(y1,y2)
sxy <- cbind(s, x,y)

# set column names
names(sxy)[1] <- "subject"
names(sxy)[2:562] <- as.character(features[,2])
names(sxy)[563] <- "activityId"

# -------------------------------
#Extracts only the measurements on the mean and standard deviation for each measurement.   
cols <- grep("mean|std", names(sxy), ignore.case=T)

# -------------------------------
#Uses descriptive activity names to name the activities in the data set

# ? diff with next question?

# -------------------------------
#Appropriately labels the data set with descriptive activity names. 
ylabels <- lapply(y, function(v) activities[v,2])
#dim(ylabels)
sxyl <- cbind(sxy,ylabels)
names(sxyl)[564] <- "activity"
#sxyl$activity

# should remove activityId column
#drops <- c("x","z")
#DF[,!(names(DF) %in% drops)]

# -------------------------------
#Creates a second, independent tidy data set with the average of each variable for each activity and each subject. 
library(reshape2)

# Melt dataset to have a key/value columns
sxylMeltAll <- melt(sxyl, 
                 id = c("subject", "activity"), 
                 measures.var = features,
                 variable.name = "variable",
                 value.name = "value");

# DCast melted to:
# subject1, activity1, value1, value2...
# s1, a2, v1, v2...
# s2, a1, v1, v2...
subjectMeanVars <- dcast(sxylMeltAll, subject ~ variable, mean)
activityMeanVars <- dcast(sxylMeltAll, activity ~ variable, mean)
meanVars <- dcast(sxylMeltAll, subject+activity ~ variable, mean)

# show format
head(meanVars[,1:4], n=20)

#write.csv(meanVars, file = paste(data, "/sensor-mean-vars.csv", sep=""));#, sep = ";")
write.table(meanVars, file = paste(data, "/sensor-mean-vars.txt", sep=""));#, sep = ";")

# TODO : have number format compatible with default XL (, and not .)



# ############################
# DCast format:
# subject1, activity1, value1, value2...
# s1, a2, v1, v2...
# s2, a1, v1, v2...
#
# to
#      a1
# s1 f(v)  f is?
#
#dcast(sxyl, subject ~ activity)
#dcast(sxyl, subject ~ activity, mean)
# dcast(sxylMelt, subject ~ activity, mean)
# dcast(sxylMelt, subject ~ "tBodyAcc-mean()-X", mean)

