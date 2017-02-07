setwd('/Users/sydneytemple/Documents/Coursera/Data_Science_Specialization/Getting and Cleaning Data')

##read all text files in the zip folder
allFilesMain<-c("./UCI HAR Dataset/activity_labels.txt", "./UCI HAR Dataset/features.txt") #file names in "UCI HAR dataset"
allFilesTrain<-list.files("./UCI HAR Dataset/Train", pattern = "*.txt", full.names = TRUE) #file names in "train" folder
allFilesTrainInert<-list.files("./UCI HAR Dataset/Train/Inertial Signals", pattern = "*.txt", full.names = TRUE) #file names in "train/Inertial signals" folder
allFilesTest<-list.files("./UCI HAR Dataset/Test", pattern = "*.txt", full.names = TRUE) #file names in "test" folder
allFilesTestInert<-list.files("./UCI HAR Dataset/Test/Inertial Signals", pattern = "*.txt", full.names = TRUE) #file names in "test/Inertial signals" folder

allFiles<-c(allFilesMain, allFilesTest, allFilesTestInert, allFilesTrain, allFilesTrainInert) #all files in directory

allData<-sapply(allFiles, FUN = read.table, USE.NAMES = TRUE) #read all files into R

#create data frames for train and test data - 
#first column in each is the activity label (from "y_train.txt" or "y_test.txt")
#last column in each is the subject label of the person performing the activity (from 'subject_train.txt' or subject_test.txt')
#rest of columns are each of the features (561 of them to make 563 total columns)
#train set has 7352 observations, test set has 2947
train<-cbind(allData$`./UCI HAR Dataset/Train/y_train.txt`, allData$`./UCI HAR Dataset/Train/X_train.txt`, allData$`./UCI HAR Dataset/Train/subject_train.txt`)
test<-cbind(allData$`./UCI HAR Dataset/Test/y_test.txt`, allData$`./UCI HAR Dataset/Test/X_test.txt`, allData$`./UCI HAR Dataset/Test/subject_test.txt`)

#combine train and test set into one data frame
trainAndTest<-rbind(train, test)

# rename columns 1 and 563
colnames(trainAndTest)[c(1, 563)]<-c("activity_number", "subject_number")

# rename columns 2-562 using "features.txt"
allData$`./UCI HAR Dataset/features.txt`$V2<-as.character(allData$`./UCI HAR Dataset/features.txt`$V2)
colnames(trainAndTest)[2:562]<- allData$`./UCI HAR Dataset/features.txt`$V2


#extract only variables for mean and std for each measurement
trainAndTest2<-trainAndTest  #make copy

neededNames<-grep("mean()", colnames(trainAndTest2), value = TRUE, fixed = TRUE) #col names for means
neededNames2<-grep("std()", colnames(trainAndTest2), value = TRUE, fixed = TRUE) #col names for stds

trainAndTest2<-subset(trainAndTest2, select = c( "activity_number",neededNames, neededNames2, "subject_number")) #required subset


#new column for activity names
allData$`./UCI HAR Dataset/activity_labels.txt`<-rename(allData$`./UCI HAR Dataset/activity_labels.txt`, c("V1" = "activity_number", "V2"="activity_name"))
trainAndTest3<-merge(trainAndTest2, allData$`./UCI HAR Dataset/activity_labels.txt`, by = "activity_number", all = TRUE)

#rearrange to make subject number and activity number the first columns
trainAndTest4<-trainAndTest3[,c(1, 68, 69, 2:67)]

#create data frame with average of each variable for each activity
trainAndTest5<-trainAndTest4[,-3] # same data set without "subject number" column

averages<-aggregate(trainAndTest5, by = list(trainAndTest5$activity_number, 
                                             trainAndTest5$subject_number), FUN = mean) #new data frame with one row for each subject for each activity - average of each variable

# add activity labels and reorder by activity and subject number within each activity
averages2<-averages[,-c(1,2)]  
averages3<-merge(allData$`./UCI HAR Dataset/activity_labels.txt`, averages2, by = "activity_number", all = TRUE)
averages4<-averages3[order(averages3$activity_number, averages3$subject_number), ]


#write table of averages to a text file
write.table(averages4, "Subject and activity averages.txt", row.names = FALSE)

