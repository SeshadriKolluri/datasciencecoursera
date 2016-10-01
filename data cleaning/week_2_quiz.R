#download.file(url='https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Fss06pid.csv',destfile='localfile.csv',method='curl')
#acs<-read.csv(file='localfile.csv')
#sqldf("select distinct AGEP from acs")
library(httr)
url<-"http://biostat.jhsph.edu/~jleek/contact.html"
html2<-GET(url)
content2<-content(html2,as="text")
lines<-strsplit(content2,"\n")
#ParsedHTML<-htmlParse(content2,asText=TRUE)
cat(sprintf("%d %d %d %d\n",nchar(lines[[1]][10]),nchar(lines[[1]][20]),nchar(lines[[1]][30]),nchar(lines[[1]][100])))

#url<-"https://d396qusza40orc.cloudfront.net/getdata%2Fwksst8110.for"
#download.file(url,destfile='fort.for',method='curl')

test<-read.fwf(file='fort.for',skip=4,header=FALSE,widths=c(10,5,4,1,3,5,4))