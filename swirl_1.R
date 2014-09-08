library(swirl)
# 
# When you are at the R prompt (>):
#   | -- Typing skip() allows you to skip the current question.
# | -- Typing play() lets you experiment with R on your own; swirl will ignore what you do...
# | -- UNTIL you type nxt() which will regain swirl's attention.
# | -- Typing bye() causes swirl to exit. Your progress will be saved.
# | -- Typing main() returns you to swirl's main menu.
# | -- Typing info() displays these options again.
# 

#install_from_swirl("Getting and Cleaning Data")
swirl()

mydf<-read.csv(path2csv,stringsAsFactors=FALSE)
dim(mydf)
head(mydf)
library(dplyr)
packageVersion("dplyr")
cran<-tbl_df(mydf)
rm("mydf")

#select

select(cran,ip_id,package, country)  #selcts particular columns in the order specified
select(cran,r_arch:country)          #selects columns between the two column headers
select(cran, -time)                  #removes a particular column
select(cran,-(X:size))

#filter

filter(cran,package == "swirl")      #selects particular rows with a particular value
filter(cran,r_version=="3.1.1",country=="US")
filter(cran,r_version <="3.0.2",country=="IN")
filter(cran,country=="US"|country=="IN")
filter(cran,size > 100500,r_os == "linux-gnu")
filter(cran,!is.na(r_version ))                   #remove all rows with an NA in a particular column

#arrange

cran2<-select(cran,size:ip_id)
arrange(cran2,ip_id)              #order by ascending
arrange(cran2,desc(ip_id))              #order by descending
arrange(cran2,package,ip_id)              #order by multiple variables
arrange(cran2,country,desc(r_version),ip_id)              #order by multiple variables

#mutate

cran3<-select(cran,ip_id,package,size)      #adds columns
mutate(cran3,size_mb=size/2^20)
mutate(cran3,size_mb=size/2^20,size_gb=size_mb/2^10)
mutate(cran3,correct_size=size+1000)

#summarize

summarize(cran,avg_bytes=mean(size))







