library(dplyr)
features<-read.table("features.txt")
activity_label<-read.table("activity_labels.txt")

train<-read.table("train/X_train.txt",col.names=label[,2])
label_train<-read.table("train/y_train.txt")
label_train_name<-rename(label_train,"Label"="V1")
subject_train<-read.table("train/subject_train.txt")
subject_train_name<-rename(subject_train,"Subject"="V1")
train_headed<-rbind(features[0,2],train)

test<-read.table("test/X_test.txt",col.names=label[,2])
label_test<-read.table("test/y_test.txt")
label_test_name<-rename(label_test,"Label"="V1")
subject_test<-read.table("test/subject_test.txt")
subject_test_name<-rename(subject_test,"Subject"="V1")

data<-rbind(train_headed,test)


sel_data<-select(data,contains("Mean"),contains("std"))

label<-rbind(label_train_name,label_test_name)
subject<-rbind(subject_train_name,subject_test_name)

data_set<-cbind(label,subject,sel_data)
txt<-data_set%>%
  merge(activity_label,by.x = "Label",by.y = "V1")%>%
  mutate(Label=V2)%>%
  select(1:88)%>%
  group_by(Label,Subject)%>%
  summarise_all(mean)

write.table(txt,file="tidy_data.txt",row.name=FALSE)