#
# Plot6.R
#
# Copyright (C) 2014 Kyle Scully
#
# Author(s)/Maintainer(s):
# Kyle Scully
#
#


#@READ DATA
NEI <- readRDS("data/summarySCC_PM25.rds")
SCC <- readRDS("data/Source_Classification_Code.rds")

#@SUBSET DATA
# Baltimore emissions from motor vehicle sources
baltimore <- NEI[(NEI$fips=="24510") & (NEI$type=="ON-ROAD"),]
baltimore <- aggregate(Emissions ~ year, data=baltimore, FUN=sum)

# Los Angeles emissions from motor vehicle sources
la <- NEI[(NEI$fips=="06037") & (NEI$type=="ON-ROAD"),]
la <- aggregate(Emissions ~ year, data=la, FUN=sum)

#add new column Location to make bind easier
baltimore$Location <- "Baltimore City, MD"
la$Location <- "Los Angeles County, CA"

combined_data <- rbind(baltimore, la)

#@PLOT DATA
library(ggplot2)

png(
	"plot6.png",
	height=480,
	width=980
)

ggplot(
	combined_data,
	aes(x=year, y=Emissions, colour=Location)
) +
facet_grid(. ~ Location,) +
geom_point(stat="identity", size=4) +
geom_smooth(method = "lm", se=F) +
xlab("Years") +
ylab(expression('Total Emissions (tons of PM'[2.5]*') ')) +
ggtitle(expression('Total Emissions (tons of PM'[2.5]*') From Motor Vehicle Sources in Balitmore and LA (1999-2008)'))

dev.off()