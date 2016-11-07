library(dplyr)
library(ggplot2)

#Define a file name
filename<-"data_for_peer_assessement.zip"

#Check if the file already exists, and download if it doesn't exist already
if(!file.exists(filename)){
    download.file(destfile = filename,method='curl',url='https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2FNEI_data.zip')
}

#Check if the unzipped file exists or else do the unzip
if(!file.exists("summarSCC_PCM25.rds")){
    unzip(filename)
}

## This first line will likely take a few seconds. Be patient!
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

# Selecting data from both "On-Road" and "Non-Road" Motor Vehicles
scc_motor_vehicles<-subset(SCC, Data.Category=="Onroad" | Data.Category=="Nonroad")
# Selecting the emissions data for motor vehicles in baltimore city
emissions_motor_vehicles_bc<-subset(NEI, SCC %in%  scc_motor_vehicles$SCC & fips=="24510")


emissions_motor_vehicles_bc_by_year<-aggregate(emissions_motor_vehicles_bc$Emissions,FUN=sum,by = list(Year = emissions_motor_vehicles_bc$year))
names(emissions_motor_vehicles_bc_by_year) <- c("Year", "Total PM2.5 Emissions in Tons")


# plot the data to png
png(filename = "plot5.png")
plot(emissions_motor_vehicles_bc_by_year$Year,emissions_motor_vehicles_bc_by_year$`Total PM2.5 Emissions in Tons`,xlab = names(emissions_motor_vehicles_bc_by_year)[1],ylab=names(emissions_motor_vehicles_bc_by_year)[2],type = "b", col = "blue", main="Total PM2.5 Emissions in Tons by Year")
dev.off()
