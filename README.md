Code explanations


```R 
##Reading features and activity lables
features<-read.table("features.txt")
activity_label<-read.table("activity_labels.txt")

##Reading set of training data
train<-read.table("train/X_train.txt",col.names=label[,2])

##Reading labels for training set and renaming in "Label"
label_train<-read.table("train/y_train.txt")
label_train_name<-rename(label_train,"Label"="V1")

##Reading PersonID for training data and renaming in "Subject"
subject_train<-read.table("train/subject_train.txt")
subject_train_name<-rename(subject_train,"Subject"="V1")

##Adding header in set of trainin data
train_headed<-rbind(features[0,2],train)

##Reading set of test data
test<-read.table("test/X_test.txt",col.names=label[,2])
##Reading labels for test set and renaming in "Label"
label_test<-read.table("test/y_test.txt")
label_test_name<-rename(label_test,"Label"="V1")
##Reading PersonID for test data and renaming in "Subject"
subject_test<-read.table("test/subject_test.txt")
subject_test_name<-rename(subject_test,"Subject"="V1")

##Merging training and test data
data<-rbind(train_headed,test)

##Selecting columns with "mean" or "std"
sel_data<-select(data,contains("Mean"),contains("std"))

##Merging lables for training and test data in one vector
label<-rbind(label_train_name,label_test_name)

##Merging PersonalID for training and test data in one vector
subject<-rbind(subject_train_name,subject_test_name)

##Collecting label, personal ID and movment data
data_set<-cbind(label,subject,sel_data)

##Renaming activity ID on names, grouping data by Label and Subject, summarising all data by mean
txt<-data_set%>%
  merge(activity_label,by.x = "Label",by.y = "V1")%>%
  mutate(Label=V2)%>%
  select(1:88)%>%
  group_by(Label,Subject)%>%
  summarise_all(mean)

##Writing txt file
write.table(txt,file="tidy_data.txt",row.name=FALSE)
```
