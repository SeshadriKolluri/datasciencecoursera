library(dplyr)
library(ggplot2)

#Define a file name
filename<-"data_for_peer_assessement.zip"

#Check if the file already exists, and download if it doesn't exist already
if(!file.exists(filename)){
    download.file(destfile = filename,method='curl',url='https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2FNEI_data.zip')
}

#Check if the directory exists, and unzip the file if the directory doesn't exist already
if(!file.exists("summarSCC_PCM25.rds")){
    unzip(filename)
}

## This first line will likely take a few seconds. Be patient!
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

#Identifying SCC tags related Coal Combustion
scc_combustion_coal<-filter(SCC, grepl("Coal",SCC.Level.Three,ignore.case = TRUE),grepl("Combustion",SCC.Level.One,ignore.case = TRUE))
#Subsetting emissions related to Coal combustion
emissions_coal<-subset(NEI, SCC %in%  scc_combustion_coal$SCC)

#Aggregating total coal emissions by year
coal_emissions_by_year<-aggregate(emissions_coal$Emissions,FUN=sum,by = list(Year = emissions_coal$year))
names(coal_emissions_by_year) <- c("Year", "Total PM2.5 Emissions in Tons")


# plot the data to png
png(filename = "plot4.png")
plot(coal_emissions_by_year$Year,coal_emissions_by_year$`Total PM2.5 Emissions in Tons`,xlab = names(coal_emissions_by_year)[1],ylab=names(coal_emissions_by_year)[2],type = "b", col = "blue", main="Total PM2.5 Emissions in Tons by Year")
dev.off()
