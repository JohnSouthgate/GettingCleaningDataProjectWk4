
# Tidy Data R code

## John Southgate, Getting and Cleaning Data Project Week 4

# Preliminary

## Setup working folder
setwd("C:/Users/go2/_my/CourseraDataSci/Assignments/GCD Week 4/")
projectPath<-getwd()
projectPath

## Output directory and filename of the clean/tidy data:
cleanDataSetFile <- "cleanData.txt"
cleanDataSetAvgFile <- "cleanDataAvg.txt"

## Load Input data
dataUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
dataFile <- "Dataset.zip"
download.file(dataUrl, file.path(projectPath, dataFile))

## Unzip just the files needed
unzip(file.path(projectPath, dataFile),list = TRUE)
unzip(file.path(projectPath, dataFile),files="UCI HAR Dataset/README.txt")

# Merge the training and the test sets to create one data set
# -- from the information in README.txt, I have interpreted this to mean merge each of 3 pairs files 

# test/X_test.txt and train/X_train.txt
# test/y_test.txt and train/Y_train.txt
# test/subject_test.txt and train/subject_train.txt

# Get only the required files
unzip(file.path(projectPath, dataFile),files="UCI HAR Dataset/test/X_test.txt")
unzip(file.path(projectPath, dataFile),files="UCI HAR Dataset/train/X_train.txt")
unzip(file.path(projectPath, dataFile),files="UCI HAR Dataset/test/y_test.txt")
unzip(file.path(projectPath, dataFile),files="UCI HAR Dataset/train/y_train.txt")
unzip(file.path(projectPath, dataFile),files="UCI HAR Dataset/train/subject_train.txt")
unzip(file.path(projectPath, dataFile),files="UCI HAR Dataset/test/subject_test.txt")

# and a few more that will be useful later
unzip(file.path(projectPath, dataFile),files="UCI HAR Dataset/activity_labels.txt")
unzip(file.path(projectPath, dataFile),files="UCI HAR Dataset/features_info.txt")
unzip(file.path(projectPath, dataFile),files="UCI HAR Dataset/features.txt")

## load
s_train <- read.table("UCI HAR Dataset/train/subject_train.txt", header = FALSE)
s_test <- read.table("UCI HAR Dataset/test/subject_test.txt", header = FALSE)
y_train <- read.table("UCI HAR Dataset/train/y_train.txt", header = FALSE)
y_test <- read.table("UCI HAR Dataset/test/y_test.txt", header = FALSE)
x_train <- read.table("UCI HAR Dataset/train/X_train.txt", header = FALSE)
x_test <- read.table("UCI HAR Dataset/test/X_test.txt", header = FALSE)

### 1. Create one set
sSet<-rbind(s_train, s_test)
ySet<-rbind(y_train, y_test)
xSet<-rbind(x_train, x_test)

# Have a look
str(sSet)
str(ySet)
str(xSet)

### 2. Get mean and standard deviation measurements only
features <- read.table("UCI HAR Dataset/features.txt")
str(features)
unique(features$V1)
unique(features$V2)

# Provide meaningful column names
names(features) <- c('feature_id', 'feature_name')
str(features)

# Scan column names to find those for mean and standard deviation (srd)  
features_i <- grep("-mean\\(\\)|-std\\(\\)", features$feature_name) 
features[features_i, "feature_name"]
xMeanStd <- xSet[, features_i] 

# all columns that have mean or std
head(xMeanStd)

# Provide better names for mean/std features 
names(xMeanStd) <- gsub("\\(|\\)", "", (features[features_i, 2]))
str(xMeanStd)
nrow(xMeanStd)
ncol(xMeanStd)

### 3. Use descriptive activity names to name the activities in the data set:
activities <- read.table("UCI HAR Dataset/activity_labels.txt")
names(activities) <- c('activity_id', 'activity_name')

# Subject Labels
names(sSet) <- "subject_id"
head(sSet)

### 4. Label the data set with descriptive activity names:

activities
ySet[, 1]
ySet[, 1] <- activities[ySet[, 1], "activity_name"]
names(ySet) <- "activity_name"
str(ySet)

# Produce the labelled the dataset
cleanDataSet <- cbind(sSet, ySet, xMeanStd)
head(cleanDataSet)

dim(cleanDataSet) # 10299 68
head(cleanDataSet,100,4)
dim(cleanDataSet)[2] # 68
head(cleanDataSet[, 3:dim(cleanDataSet)[2]])

### 5. Create a 2nd, independent clean data set with the average of each variable for each activity and each subject:
observations <- cleanDataSet[, 3:dim(cleanDataSet)[2]] 
cleanDataSetAvg <- aggregate(observations,list(cleanDataSet$subject_id, cleanDataSet$activity_name), mean)

# Activity and Subject name for columns 
names(cleanDataSetAvg)[1] <- "subject_id"
names(cleanDataSetAvg)[2] <- "activity_name"
head(cleanDataSetAvg)

# Save as text files, without row-names

write.table(cleanDataSet, cleanDataSetFile, row.name=FALSE)
write.table(cleanDataSetAvg, cleanDataSetAvgFile, row.name=FALSE)
dir()








