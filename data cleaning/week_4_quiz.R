library(quantmod)
#download.file(url='https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Fss06hid.csv',destfile = 'housingdata.csv')
#download.file(destfile = 'edudata.csv',url='https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FEDSTATS_Country.csv')
housingdata<-read.csv(file='housingdata.csv')
test<-strsplit(names(housingdata),'wgtp')[123]

gdpdata<-read.csv(file='gdpdata.csv',skip = 3,blank.lines.skip = TRUE,strip.white=TRUE)
gdpdata<-filter(gdpdata,Ranking!=''&X!='')
gdpdata$Ranking<-as.numeric(as.character(gdpdata$Ranking))
gdpdata$US.dollars.<-as.numeric(gsub(",","",gdpdata$US.dollars.))
edudata<-read.csv(file='edudata.csv')

merged_data<-merge(edudata,gdpdata,by.x = 'CountryCode',by.y = 'X')
table(grepl('end: [jJ]un', merged_data$Special.Notes))


amzn = getSymbols("AMZN",auto.assign=FALSE)
sampleTimes = index(amzn)
table(format(sampleTimes,"%Y"),format(sampleTimes,"%A"))
