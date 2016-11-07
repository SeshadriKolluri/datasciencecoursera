library(dplyr)
library(ggplot2)

#Define a file name
filename<-"data_for_peer_assessement.zip"

#Check if the file already exists, and download if it doesn't exist already
if(!file.exists(filename)){
    download.file(destfile = filename,method='curl',url='https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2FNEI_data.zip')
}

# unzip the file if not done already
if(!file.exists("summarSCC_PCM25.rds")){
    unzip(filename)
}

## This first line will likely take a few seconds. Be patient!
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

#Aggregating the sum of all the emissions by year
emissions_by_year<-aggregate(NEI$Emissions,FUN=sum,by = list(Year = NEI$year))
names(emissions_by_year) <- c("Year", "Total PM2.5 Emissions in Tons")


# plot the data to plot1.png
png(filename = "plot1.png")
plot(emissions_by_year$Year,emissions_by_year$`Total PM2.5 Emissions in Tons`,xlab = names(emissions_by_year)[1],ylab=names(emissions_by_year)[2],type = "b", col = "blue", main="Total PM2.5 Emissions in Tons by Year")
dev.off()
