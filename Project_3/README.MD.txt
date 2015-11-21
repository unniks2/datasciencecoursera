Q1.

##  Read Tables

First of all the required datasets are uploaded using read.table function.

xtest<-read.table("X_test.txt")
xtrain<-read.table("X_train.txt")
fea<-read.table("features.txt")
subject<-read.table("subject_test.txt")
subject2<-read.table("subject_train.txt")
label_test<-read.table("y_test.txt")
label_train<-read.table("y_train.txt")
actlabel<-read.table("activity_labels.txt")



##  Appending

The training and test data sets are appended using rbind function.
The subjects and labels dataset are appended as well. These correspond to the individual readings of test& training data.



final1<-rbind(xtrain,xtest)
subfinal<-rbind(subject2,subject)
label_final<-rbind(label_train,label_test)

## Coloumn addition etc 

There are 561 coloumns in both x_test & x_train datasets. Again 561 rows are present in features dataset.
These rows are extracted and inserted as coloumn names in the appended dataset(Traing and test data)
 


colnames(actlabel)<-c("label","Activity")
rname<-as.character(fea$V2)
colnames(final1)<-rname
final1$label=label_final$V1
final1$subject=subfinal$V1

## Q2.

The appended dataset is then merged with activity-Label dataset to get the corresponding activities for every label.
All the colomns names which are either standard dev or mean of variables are extracted using Grep function
This is then extracted out along with activity,subject-(563,564 field no) and stored in result1

final2<-merge(final1,actlabel,by = "label")
gp3<-c(grep("mean",names(final2)),grep("std",names(final2)),563,564)## 
result1<-final2[,gp3]

## Q3-5

It is aggregated by Subject and activity with function mean. 

This gives the average of all the fields for every single person(subject) and their corresponding activity.(30*6=180 obs)
Please note that I have interpreted the question in this manner and not by taking just the average of the variables of the 30 people and 6 activities seperately(36 obs)

names<-colnames(result1)
names<-names[1:(length(names)-2)]
final_result<-aggregate(result1[names],by = result1[c("subject","Activity")], FUN=mean)

write.table(x = final_result,file = "Result.txt",row.name = FALSE)


