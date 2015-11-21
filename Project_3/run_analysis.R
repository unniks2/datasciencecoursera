xtest<-read.table("X_test.txt")
xtrain<-read.table("X_train.txt")
final1<-rbind(xtrain,xtest)
fea<-read.table("features.txt")
rname<-as.character(fea$V2)
subject<-read.table("subject_test.txt")
subject2<-read.table("subject_train.txt")
subfinal<-rbind(subject2,subject)
label_test<-read.table("y_test.txt")
label_train<-read.table("y_train.txt")
label_final<-rbind(label_train,label_test)
actlabel<-read.table("activity_labels.txt")

colnames(actlabel)<-c("label","Activity")
colnames(final1)<-rname
final1$label=label_final$V1
final1$subject=subfinal$V1

final2<-merge(final1,actlabel,by = "label")
gp3<-c(grep("mean",names(final2)),grep("std",names(final2)),563,564)
result1<-final2[,gp3]
names<-colnames(result1)
names<-names[1:(length(names)-2)]
final_result<-aggregate(result1[names],
          by = result1[c("subject","Activity")], FUN=mean)

write.table(x = final_result,file = "Result.txt",row.name = FALSE)


