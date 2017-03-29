# Name: plot2.R
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

# Have total emissions from PM2.5 decreased in the Baltimore City, 
# Maryland (fips == "24510") from 1999 to 2008? Use the base plotting  
# system to make a plot answering this question.


# First lets grab only the data within Baltimore (fips = 24510)
baltimoreNEI24510  <- dataNEI[dataNEI$fips=="24510", ]

# Now lets get group the Baltimore data by year from from the NEI data and store the sum
baltimoreEmissionsByYear <- aggregate(Emissions ~ year, baltimoreNEI24510, sum)

# Now lets set the plot name
png('plot2.png')

# Base plotting system required.
barplot(height=emissionsByYear$Emissions, names.arg=emissionsByYear$year, 
        xlab="Year", ylab=expression('PM2.5 Emission'),
        main=expression('Total Baltimore PM2.5 from 1999 - 2008'))

dev.off()