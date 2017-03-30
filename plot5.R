# Name: plot5.R
# Author: Joe Logan
# Date 29-March 2017
# Assignment: Exploratory Data Analysis - Course Project

# Load the data if it does not already exist
if(!exists("dataNEI")){
        dataNEI <- readRDS("./data/summarySCC_PM25.rds")
} 
if(!exists("dataSCC")){
        dataSCC <- readRDS("./data/Source_Classification_Code.rds")
}

# How have emissions from motor vehicle sources changed from 1999-2008 in Baltimore City?

# Requirement > ggplot2
library(ggplot2)

# First lets grab only the data within subsetBaltimore (fips = 24510)
subsetBaltimore <- subset(dataNEI, fips == "24510")

# Now lets grab only motor vehicle sectors that we can merge with the NEI data
emissionSource <- dataSCC[grepl("Vehicle", dataSCC$EI.Sector),]

# Now find only the subsetBaltimore data within the vehicle sectors
baltimoreVehicleEmissions <- subset(subsetBaltimore, subsetBaltimore$SCC %in% emissionSource$SCC)

png("plot5.png", width=840, height=480)
thePlot <- ggplot(baltimoreVehicleEmissions, aes(factor(year), Emissions))

# Will use qplot here
thePlot <- thePlot + geom_bar(stat="identity") + xlab("year") +
        ylab(expression("PM2.5 Emissions")) +
        ggtitle('Baltimore Vehicle Emissions from 1999 - 2008')

# Print it to the device
print(thePlot)

dev.off()

