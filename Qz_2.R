#M.R. Helmus Quiz 2 in Getting and Cleaning Data Coursera
#https://class.coursera.org/getdata-007

library(data.table)
library(xlsx)
library(httr)
library(jsonlite)
library(sqldf)
library(XML)
setwd("C:\\Users\\matt\\Google Drive 2\\Google Drive\\2014_Data_Science_Coursera")

#Q1
myapp = oauth_app("github",key="7af44733ea7e276f7033",secret="6c29c78f8e7fcab9f022ecc8a1b5436e84885734")
github_token <- oauth2.0_token(oauth_endpoints("github"), myapp)
gtoken <- config(token = github_token)
homeTL = GET("https://api.github.com/users/jtleek/repos", gtoken)
json1<-content(homeTL)
json2 = jsonlite::fromJSON(toJSON(json1))

url<-"https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Fss06hid.csv"
dir.create("data")
download.file(url,destfile="./data/acs.csv")
acs<-read.csv("./data/acs.csv",header=TRUE)
acs<-data.table(acs)
sum(acs$VAL==24,na.rm=TRUE)

#Q2
url<-"https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Fss06pid.csv "
download.file(url,destfile="./data/acs.csv")
acs<-read.csv("./data/acs.csv",header=TRUE)
acs<-fread("./data/acs.csv",header=TRUE)

sqldf("select pwgtp1 from acs where AGEP < 50")

#Q3
unique(acs$AGEP)
sqldf("select distinct AGEP from acs")


#Q4
url<-"http://biostat.jhsph.edu/~jleek/contact.html"
html <- htmlTreeParse(url, useInternalNodes=T)
xpathSApply(html, "//title", xmlValue)
sapply(html,nchar())
obj<-readlines(url)
sapply(obj[c(10,20,30,100)],nchar)

#Q5
url<-"https://d396qusza40orc.cloudfront.net/getdata%2Fwksst8110.for"
download.file(url,destfile="./data/811.for")
fwf<-read.fwf(file="./data/811.for",c(28,4),skip=4)
head(fwf)



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




