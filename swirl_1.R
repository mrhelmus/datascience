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
cran
?manip

#select

select(cran,ip_id,package, country)  #selcts particular columns in the order specified
5:20
select(cran,r_arch:country)          #selects columns between the two column headers
select(cran,country:r_arch)          #selects columns between the two column headers
cran
select(cran, -time)                  #removes a particular column
-(5:20)
select(cran,-(X:size))

#filter

filter(cran,package == "swirl")      #selects particular rows with a particular value
filter(cran,r_version=="3.1.1",country=="US")
?Comparison
filter(cran,r_version <="3.0.2",country=="IN")
filter(cran,country=="US"|country=="IN")
filter(cran,size > 100500,r_os == "linux-gnu")
 is.na(c(3, 5, NA, 10))
 !is.na(c(3, 5, NA, 10))
filter(cran,!is.na(r_version ))                   #remove all rows with an NA in a particular column

#arrange

cran2<-select(cran,size:ip_id)
arrange(cran2,ip_id)              #order by ascending
arrange(cran2,desc(ip_id))              #order by descending
arrange(cran2,package,ip_id)              #order by multiple variables
arrange(cran2,country,desc(r_version),ip_id)              #order by multiple variables

#mutate

cran3<-select(cran,ip_id,package,size)      #adds columns
cran3
mutate(cran3,size_mb=size/2^20)
mutate(cran3,size_mb=size/2^20,size_gb=size_mb/2^10)
mutate(cran3,correct_size=size+1000)

#summarize

summarize(cran,avg_bytes=mean(size))

#################################################################################
#################################################################################

library(dplyr)
cran<-tbl_df(mydf)
rm("mydf")
cran
?group_by
by_package<-group_by(cran,package)
by_package
summarize(by_package,mean(size))
pack_sum
quantile(pack_sum$count,probs=0.99)
top_counts<-filter(pack_sum,count>679)
top_counts
head(top_counts,20)
arrange(top_counts,desc(count))
 quantile(pack_sum$unique, probs = 0.99)
top_unique<-filter(pack_sum,unique>465)
top_unique
arrange(top_unique,desc(unique))
 
############################################################################
############################################################################
library(tidyr)
students
?gather
gather(students, sex, count, -grade)
students2 
res<-gather(students2, sex_class, count, -grade)
res
?separate
separate(res,sex_class,c("sex","class"))
students3
students3 %>% gather( class, grade, class1:class5 , na.rm= TRUE) %>% print
?spread
extract_numeric("class5")
students4
passed
failed
passed<-mutate(passed,status="passed")
failed<-mutate(failed,status="failed")
rbind_list(passed,failed)
sat

###########################################################################################################################################
############# lubridate

Sys.getlocale("LC_TIME")
library(lubridate)
help(package=lubridate)
this_day<-today()
this_day
day(this_day)
wday(this_day)
wday(this_day,label=TRUE)
this_moment<-now()
this_moment
hour(this_moment)
my_date<-ymd("1989-05-17")
my_date
class(my_date)
ymd("1989 May 17")
mdy("March 12, 1975")
dmy(25081985)
ymd("192012")
ymd("1920-1-2")
dt1
ymd_hms(dt1)
hms("03:22:14") #(hh:mm:ss)
dt2
ymd(dt2)
update(this_moment, hours = 8, minutes = 34, seconds = 55)
this_moment
this_moment<-update(this_moment,hours=5,minutes=22,seconds=0)
this_moment
nyc<-now("America/New_York")
nyc
depart<-nyc+days(2)
depart
depart<-update(depart,hours=17,minutes=34)
depart
arrive<-depart + hours(15)+minutes(50)
?with_tz
arrive<-with_tz(arrive,"Asia/Hong_Kong")
arrive
last_time<-mdy("June 17, 2008",tz="Singapore")
last_time
?new_interval
how_long<-new_interval(last_time,arrive)
as.period(how_long)
stopwatch()