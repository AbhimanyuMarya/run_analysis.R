#------QUESTION-1
#LOADING DATA
SubjectTrain=(read.table("C:/Users/ABHIMANYU MARYA/Desktop/a1/UCI HAR Dataset/train/subject_train.txt"))
SubjectTest=(read.table("C:/Users/ABHIMANYU MARYA/Desktop/a1/UCI HAR Dataset/test/subject_test.txt"))
x_train=(read.table("C:/Users/ABHIMANYU MARYA/Desktop/a1/UCI HAR Dataset/train/X_train.txt"))
y_train=(read.table("C:/Users/ABHIMANYU MARYA/Desktop/a1/UCI HAR Dataset/train/y_train.txt"))

y_test=(read.table("C:/Users/ABHIMANYU MARYA/Desktop/a1/UCI HAR Dataset/test/y_test.txt"))
  x_test=(read.table("C:/Users/ABHIMANYU MARYA/Desktop/a1/UCI HAR Dataset/test/X_test.txt"))
  
  
  features= read.table("C:/Users/ABHIMANYU MARYA/Desktop/a1/UCI HAR Dataset/features.txt")
  
  activity_labels= read.table("C:/Users/ABHIMANYU MARYA/Desktop/a1/UCI HAR Dataset/activity_labels.txt")
  
  #Changing names, becz names are not unique after Column Bind, ,so error generates
  colnames(SubjectTrain)="SubjectID"
  colnames(x_train)=features[,2]
  colnames(y_train)="ID"  # ACTIVITY ID either walking standing etc.
  #Give exactly same name to Test dataset
  colnames(SubjectTest)="SubjectID"
  colnames(x_test)=features[,2]
  colnames(y_test)="ID"
  #First column binding, then binding by similar rows
  training_data=cbind(x_train,y_train,SubjectTrain)
  testing_data=cbind(x_test,y_test,SubjectTest)
  
dataSet <- rbind(training_data,testing_data)


#-------QUESTION 2
#in this question it is asked to extract only those measurements which has mean | std in name
# we have not to find mean or STD seperately
dataSet=dataSet[grepl("mean|std",colnames(dataSet))]
 

#-------QUESTION 3

library(plyr)
#remember gsub and sub is for replacement from one to other not to join
#for that use "join" keyword

#first change the name of activuty_labels, for JOIN colnames must be same

colnames(activity_labels)=c("ID","Type")
(join(dataSet,activity_labels,by="ID"))
activity_labels$Type




#-------QUESTION 4

colnames(dataSet)=gsub("^t","time",colnames(dataSet))
colnames(dataSet)=gsub("^f","frequency domain signals",colnames(dataSet))
colnames(dataSet)=gsub("Mag"," Magnitute ",colnames(dataSet))
colnames(dataSet)=gsub("Acc"," Acceleration ",colnames(dataSet))
colnames(dataSet)=gsub("Gyro"," gyroscope ",colnames(dataSet))
head(dataSet)


#-------QUESTION 5



library(plyr);
dataSet=aggregate(. ~SubjectID + ID, dataSet, mean)
dataSet<-dataSet[order(dataSet$SubjectID,dataSet$ID),]
write.table(dataSet, file = "C:/Users/ABHIMANYU MARYA/Desktop/a1/UCI HAR Dataset/tidydata.txt",row.name=FALSE)

