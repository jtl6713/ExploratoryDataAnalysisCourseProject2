# Name: plot3.R
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

# Of the four types of sources indicated by the type (point, nonpoint, 
# onroad, nonroad) variable, which of these four sources have seen decreases   
# in emissions from 1999-2008 for Baltimore City? Which have seen 
# increases in emissions from 1999-2008? Use the ggplot2 plotting system to 
# make a plot answer this question.

# Requirement > ggplot2
library(ggplot2)

# First lets grab only the data within Baltimore (fips = 24510)
baltimoreNEI24510  <- dataNEI[dataNEI$fips=="24510", ]

# Now lets get group the Baltimore data by year from from the NEI data and store the sum
baltimoreEmissionsByYear <- aggregate(Emissions ~ year + type, baltimoreNEI24510, sum)

# Now lets set the plot name
png('plot3.png')

# Will use qplot here
qplot(year, Emissions, data = baltimoreEmissionsByYear, group = baltimoreEmissionsByYear$type, color = baltimoreEmissionsByYear$type, 
      geom = c("point", "line"), ylab = expression("PM2.5 Emissions"), 
      xlab = "Year", main = "Emissions in Baltimore by Pollutant Type")

dev.off()