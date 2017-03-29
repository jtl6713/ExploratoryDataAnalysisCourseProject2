# Name: plot1.R
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

# Have total emissions from PM2.5 decreased in the United States from 1999 to 
# 2008? Using the base plotting system, make a plot showing the total PM2.5 
# emission from all sources for each of the years 1999, 2002, 2005, and 2008.

# First lets get group the data by year from from the NEI data and store the sum
# EZ PZ
emissionsByYear <- aggregate(Emissions ~ year, dataNEI, sum)

# Now lets set the plot name
png('plot1.png')

# I'm using the base plotting system here since this is straing forward.
# 
barplot(height=emissionsByYear$Emissions, names.arg=emissionsByYear$year, 
        xlab="Year", ylab=expression('PM2.5 Emission'),
        main=expression('Total PM2.5 for 1999, 2002, 2005 & 2008'))

dev.off()