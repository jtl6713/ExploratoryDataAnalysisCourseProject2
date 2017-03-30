# Name: plot6.R
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

# Compare emissions from motor vehicle sources in Baltimore City with emissions 
# from motor vehicle sources in Los Angeles County, California (fips == "06037").
# Which city has seen greater changes over time in motor vehicle emissions?

# Requirement > ggplot2
library(ggplot2)

# First lets grab only the data within subsetBaltimore (fips = 24510)
subsetBaltimoreLA <- subset(dataNEI, fips == "24510" | fips == "06037")

# Now lets grab only motor vehicle sectors that we can merge with the NEI data
emissionSource <- dataSCC[grepl("Vehicle", dataSCC$EI.Sector),]

# Now find only the subsetBaltimore data within the vehicle sectors
baltimorLAVehicleEmissions <- subset(subsetBaltimoreLA, subsetBaltimoreLA$SCC %in% emissionSource$SCC)

# Now lets get the emissions by year + zipcode
twoCityYearlyEmissions <- aggregate(Emissions ~ year + fips, baltimorLAVehicleEmissions, sum)
# Replace the zipcode with the city name
twoCityYearlyEmissions$fips[twoCityYearlyEmissions$fips=="24510"] <- "Baltimore"
twoCityYearlyEmissions$fips[twoCityYearlyEmissions$fips=="06037"] <- "LA COunty"

# Prepare the data for plotting by combining the data for a single chart
plotdata <- aggregate(twoCityYearlyEmissions[c("Emissions")], 
                      list(fips = twoCityYearlyEmissions$fips, 
                           year = twoCityYearlyEmissions$year), sum)

png("plot6.png", width=840, height=480)

# Will use qplot here
thePlot <- ggplot(plotdata, aes(x=year, y=Emissions, colour=fips)) +
        geom_point(alpha=0.1) + geom_smooth(method="loess") +
        ggtitle("PM2.5 Motor Vehicle Emissions in Baltimore and LA from 1999 - 2008")

# Print it to the device
print(thePlot)

dev.off()
