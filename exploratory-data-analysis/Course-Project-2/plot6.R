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

# Selecting the emissions data for motor vehicles in Los Angeles
emissions_motor_vehicles_la<-subset(NEI, SCC %in%  scc_motor_vehicles$SCC & fips=="06037")

# Aggregating total emissions for Baltimore City and Los Angeles
emissions_motor_vehicles_bc_by_year<-aggregate(emissions_motor_vehicles_bc$Emissions,FUN=sum,by = list(Year = emissions_motor_vehicles_bc$year))
emissions_motor_vehicles_LA_by_year<-aggregate(emissions_motor_vehicles_la$Emissions,FUN=sum,by = list(Year = emissions_motor_vehicles_la$year))
names(emissions_motor_vehicles_bc_by_year) <- c("Year", "Emissions")
names(emissions_motor_vehicles_LA_by_year) <- c("Year", "Emissions")

# plot the data to png
png(filename = "plot6.png", width=960)
print(ggplot(NULL,aes(Year,Emissions)) + 
          geom_point(data=emissions_motor_vehicles_bc_by_year, aes(color="Baltimore City")) + 
          geom_line(data=emissions_motor_vehicles_bc_by_year, aes(color="Baltimore City")) + 
          geom_point(data=emissions_motor_vehicles_LA_by_year, aes(color="Los Angeles")) +
          geom_line(data=emissions_motor_vehicles_LA_by_year, aes(color="Los Angeles")) +
          labs(y = "PM2.5 Emissions in Tons", title="Total Emissions from Motor Vehicles Onroad and Nonroad in Baltimore City Vs. Los Angeles")
      )
dev.off()
