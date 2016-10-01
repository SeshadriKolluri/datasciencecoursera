#download.file(url='https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Fss06hid.csv',destfile='idaho_housing.csv',method='curl')
idaho_housing_data<-read.csv(file='idaho_housing.csv')
households<-idaho_housing_data$ACR==3 & idaho_housing_data$AGS==6
which(households)

#download.file(url='https://d396qusza40orc.cloudfront.net/getdata%2Fjeff.jpg',destfile = 'instructor.jpeg',method='curl')
img<-readJPEG(source='instructor.jpeg',native=TRUE)
quantile(img,c(0.3,0.8))

#download.file(url='https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FGDP.csv',destfile = 'gdpdata.csv')
#download.file(destfile = 'edudata.csv',url='https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FEDSTATS_Country.csv')
gdpdata<-read.csv(file='gdpdata.csv',skip = 3,blank.lines.skip = TRUE,strip.white=TRUE)
gdpdata<-filter(gdpdata,Ranking!=''&X!='')
gdpdata$Ranking<-as.numeric(as.character(gdpdata$Ranking))
gdpdata$US.dollars.<-as.numeric(gsub(",","",gdpdata$US.dollars.))
edudata<-read.csv(file='edudata.csv')

merged_data<-merge(edudata,gdpdata,by.x = 'CountryCode',by.y = 'X')

merged_data<-arrange(merged_data,desc(Ranking))

summarise(group_by(merged_data,Income.Group),mean(Ranking))
table(merged_data$Income.Group,cut(merged_data$Ranking,5))