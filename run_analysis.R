##The first step that yo should consider is to unzip the UCI HAR Dataset 
##folder in your working directory, this will allow you to run the script 
##with no problems

##The firs step is to load and read the databases

load("./UCI HAR Dataset/test/X_test.txt")
x_test=read.table("./UCI HAR Dataset/test/X_test.txt")
load("./UCI HAR Dataset/test/subject_test.txt")
subject_test=read.table("./UCI HAR Dataset/test/subject_test.txt")
load("./UCI HAR Dataset/test/y_test.txt")
y_test=read.table("./UCI HAR Dataset/test/y_test.txt", 
	colClasses = "character")
load("./UCI HAR Dataset/features.txt")
features=read.table("./UCI HAR Dataset/features.txt", 
	colClasses = "character")
load("./UCI HAR Dataset/activity_labels.txt")
activity_labels=read.table("./UCI HAR Dataset/activity_labels.txt",
	colClasses = "character")
load("./UCI HAR Dataset/train/X_train.txt")
x_train=read.table("./UCI HAR Dataset/train/X_train.txt")
load("./UCI HAR Dataset/train/subject_train.txt")
subject_train=read.table("./UCI HAR Dataset/train/subject_train.txt")
load("./UCI HAR Dataset/train/y_train.txt")
y_train=read.table("./UCI HAR Dataset/train/y_train.txt", 
	colClasses = "character")

## at this point you have several vectorized files, so we will create two ID 
## databases, one for TEST and another for TRAIN, with their respective
## variable labels.

merge1=cbind(seq(1,1, length.out=2947), subject_test, y_test)
colnames(merge1)=unlist(rbind("Dataset", "ID", "Activity"))
merge1$Dataset="TEST"

mergetrain=cbind(seq(2,2, length.out=7352 ), subject_train, y_train)
colnames(mergetrain)=unlist(rbind("Dataset", "ID", "Activity"))
mergetrain$Dataset="TRAIN"

##The next step we will take is to insert the variable labels in the datasets
## containing the measured variables for TEST AND TRAIN, and also we proceed
## to extracts only the variables containing the mean and standard deviation 
## for each measurement, using the function "grep".

colnames(x_train)=unlist(rbind(features[2]))
x_train=x_train[ grep("mean|std",colnames(x_train))]
colnames(x_test)=unlist(rbind(features[2]))
x_test=x_test[ grep("mean|std",colnames(x_test))]

##At this point we have four databases, two for TEST (one database contains ID
## and the other contains measured variables) and two for training (one 
## database contains ID and the other contains measured variables). 
##In this step we will merge the four databases, using the functions "cbind"
## and "rbind". 

testdata=cbind(merge1, x_test);traindata=cbind(mergetrain, x_train)
finaldata<-rbind(testdata, traindata)

##This will allow us to label each activity in our merged data set.

finaldata$Activity[mergetrain$Activity=="1"]="WALKING"
finaldata$Activity[mergetrain$Activity=="2"]="WALKING_UPSTAIRS"
finaldata$Activity[mergetrain$Activity=="3"]="WALKING_DOWNSTAIRS"
finaldata$Activity[mergetrain$Activity=="4"]="SITTING"
finaldata$Activity[mergetrain$Activity=="5"]="STANDING"
finaldata$Activity[mergetrain$Activity=="6"]="LAYING"

##The last step is to create a data files containing the dataset containing
## every TEST and TRAIN observations.

write.table(finaldata, "finaldata.txt", row.name=FALSE)


load("finaldata.txt")
read.table("finadata.txt", header=TRUE)


##para crear la base con los promedios por participante y actividad.

secondbase=aggregate(x=finaldata, by=list(finaldata$ID, finaldata$Activity), 
	 FUN = mean )
secondbase=secondbase[,-3:-5]
secondnames=unlist(dimnames(secondbase)[2])
colnames(secondbase)=rbind(c("id", "activity", secondnames[3:81]))
##Para crear el archivo.

write.table(secondbase, "secondbase.txt", row.name=FALSE)
