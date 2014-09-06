#M.R. Helmus Quiz 1 in Getting and Cleaning Data Coursera
#https://class.coursera.org/getdata-007

library(data.table)
library(xlsx)
setwd("C:\\Users\\matt\\Google Drive 2\\Google Drive\\2014_Data_Science_Coursera")

#Q1
url<-"https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Fss06hid.csv"
dir.create("data")
download.file(url,destfile="./data/acs.csv")
acs<-read.csv("./data/acs.csv",header=TRUE)
acs<-data.table(acs)
sum(acs$VAL==24,na.rm=TRUE)

#Q2
acs[,table(FES)]

#Q3
url<-"https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FDATA.gov_NGAP.xlsx"
download.file(url,destfile="./data/FDATA.gov_NGAP.xlsx",mode="wb")
dat<-read.xlsx("./data/FDATA.gov_NGAP.xlsx",sheetIndex=1,header=TRUE,colIndex=7:15,rowIndex=18:23)
sum(dat$Zip*dat$Ext,na.rm=T) 

#Q4
library(XML)  #note change of https to http
url<-"http://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Frestaurants.xml"
doc<-xmlTreeParse(url,useInternal=TRUE)
rootNode<-xmlRoot(doc)
sum(xpathSApply(doc,"//zipcode",xmlValue)==21231)

#Q5
url<-"https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Fss06pid.csv"
download.file(url,destfile="./data/2Fss06pid.csv")
DT<-fread("./data/2Fss06pid.csv")
system.time(tapply(DT$pwgtp15,DT$SEX,mean))
system.time(sapply(split(DT$pwgtp15,DT$SEX),mean))
system.time(DT[,mean(pwgtp15),by=SEX])
system.time(mean(DT$pwgtp15,by=DT$SEX))
system.time(mean(DT[DT$SEX==1,]$pwgtp15);mean(DT[DT$SEX==2,]$pwgtp15))
system.time(rowMeans(DT)[DT$SEX==1]; rowMeans(DT)[DT$SEX==2])

DT[,mean(pwgtp15),by=SEX]




