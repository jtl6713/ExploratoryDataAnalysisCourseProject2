# Name: plot4.R
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

# Across the United States, how have emissions from coal combustion-related 
# sources changed from 1999-2008?

# Requirement > ggplot2
library(ggplot2)

# First lets get only the coal related sources by looking at the Short.Name field
onlyCoalRelated <- dataSCC[grepl("[Cc]oal", dataSCC$Short.Name),]

# Now let's marry this up with the NEI data to find the coal related data
# select NEI data based on coal sources
coalRelatedNEI <- subset(dataNEI, dataNEI$SCC %in% onlyCoalRelated$SCC)

aggregatedTotalByYear <- aggregate(Emissions ~ year, coalRelatedNEI, sum)

# Now lets set the plot name
png("plot4.png", width=640, height=480)

# Will use qplot here per requirement
g <- ggplot(aggregatedTotalByYear, aes(factor(year), Emissions))
g <- g + geom_bar(stat="identity") + xlab("year") +
        ylab(expression("PM2.5 Emissions")) +
        ggtitle('Coal source emissions from 1999 to 2008')

print(g)

dev.off()

