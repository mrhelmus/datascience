#M.R. Helmus Quiz 3 in Getting and Cleaning Data Coursera
#https://class.coursera.org/getdata-007

library(data.table)
library(stringr)
library(jpeg)
library(lubridate)
setwd("C:\\Users\\matt\\Google Drive 2\\Google Drive\\2014_Data_Science_Coursera")

#Q1
#url<-"http://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Fss06hid.csv"
#download.file(url,destfile="./data/idho.csv")
acs<-fread("./data/idho.csv",header=TRUE)
k<-strsplit(names(acs),"wgtp")

#Q2
gdp<-read.csv("./data/gdp.csv",skip=5,header=FALSE,as.is=TRUE)
head(gdp)
kk<-gsub(",","",gdp[,5])
sort(str_trim(kk))->kk
kk[1:122]<-0
mean(as.numeric(kk))




gdp<-gdp[-191:-dim(gdp)[1],]


#url<-"http://d396qusza40orc.cloudfront.net/getdata%2Fjeff.jpg"
#download.file(url,destfile="./data/ad.jpg")
k<-readJPEG("./data/ad.jpg",native=TRUE)
quantile(k,c(.30,.80))



#Q2
acs[,table(FES)]

#Q3

url<-"http://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FGDP.csv" 
download.file(url,destfile="./data/gdp.csv",mode="wb")
url<-"http://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FEDSTATS_Country.csv" 
download.file(url,destfile="./data/cnt.csv",mode="wb")

gdp<-read.csv("./data/gdp.csv",skip=5,header=FALSE,as.is=TRUE)
cnt<-read.csv("./data/cnt.csv",header=TRUE,as.is=TRUE)
head(gdp)
head(cnt)
gdp<-gdp[-191:-dim(gdp)[1],]
length(intersect(gdp$V1,cnt$CountryCode))
colnames(gdp)[1]<-"CountryCode"# $V1
cnt$CountryCode

df<-merge(gdp,cnt,by="CountryCode",all=FALSE)#by.y="CountryCode",by.x="V1")
#rownames(df)<-df$CountryCode
#df<-df[intersect(gdp$CountryCode,cnt$CountryCode),]
g<-df$V5
g<-gsub(" ","",g)
g<-gsub(",","",g)
df$gdp<-as.numeric(g)
df<-df[order(df$gdp,decreasing=TRUE),]
head(df,13)

grep("^United",df$Table.Name)

kk<-grep("[Ff]iscal [Yy]ear",df$Special.Notes,value=TRUE)
grep("[Jj]une",kk,value=TRUE)


#Q5
library(quantmod)
amzn = getSymbols("AMZN",auto.assign=FALSE)
sampleTimes = index(amzn) 
kk<-ymd(sampleTimes)
length(grep("2012",kk))
sum(wday(kk[grep("2012",kk)])==2)

#Q4
df$V2<-as.numeric(df$V2)
aggregate(V2~Income.Group,df,FUN=mean)

#Q5
k<-cut(df$gdp,breaks=quantile(df$gdp,c(0,.2,.4,.6,.8,1)))
table(df$Income.Group,k)

