library(lubridate)
library(dplyr)
read.table("hp",header=TRUE,sep = ";",colClasses = "character")
date<-dmy(c("01-02-2007","02-02-2007"))
final<-filter(hp,ymd(hp$date)==date)
final$datetime<-paste(final$Date,final$Time)
final$datetime<-strptime(final$datetime,"%d/%m/%Y %H:%M:%S")
hist(as.numeric(final$Global_active_power),col="red",xlab = "Global_active_power")

plot(final$datetime,final$Global_active_power,pch=20,type = "l")

