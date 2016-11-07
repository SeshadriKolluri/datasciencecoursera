library(dplyr)
library(ggplot2)

#Define a file name
filename<-"data_for_peer_assessement.zip"

#Check if the file already exists, and download if it doesn't exist already
if(!file.exists(filename)){
    download.file(destfile = filename,method='curl',url='https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2FNEI_data.zip')
}

#Unzip the file if not done already
if(!file.exists("summarSCC_PCM25.rds")){
    unzip(filename)
}

## This first line will likely take a few seconds. Be patient!
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

#Subset emissions for Baltimore City
emissions_for_baltimore_city <- subset(NEI,fips=="24510")

#Aggregate total emissions by both Year and Type
emissions_by_year_and_type_bc<-aggregate(emissions_for_baltimore_city$Emissions,FUN=sum,by = list(emissions_for_baltimore_city$year,emissions_for_baltimore_city$type))
names(emissions_by_year_and_type_bc) <- c("Year", "Type", "Emissions")


# plot the data to png - Overlay Plot in ggplot2
png(filename = "plot3.png")
print(ggplot(data=emissions_by_year_and_type_bc,aes(Year,Emissions)) + 
    geom_point(aes(color=Type)) + 
    geom_line(aes(color=Type)) +
    labs(y = "PM2.5 Emissions in Tons", title = "Total Emissions in Baltimore City by Type"))
dev.off()
