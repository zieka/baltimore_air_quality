#
# Plot5.R
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
#only balitmore and on-road emmisions
subset_emissions <- NEI[(NEI$type=="ON-ROAD") & (NEI$fips=="24510"),]
subset_emissions <- aggregate(Emissions ~ year, data=subset_emissions, FUN=sum)

#@PLOT DATA
library(ggplot2)

png(
	"plot5.png",
	height=480,
	width=680
)

ggplot(
	subset_emissions,
	aes(x=year, y=Emissions)
) +
geom_point(stat="identity", size=4) +
geom_smooth(method = "lm", se=F, colour="red") +
xlab("Years") +
ylab(expression('Total Emissions (tons of PM'[2.5]*') ')) +
ggtitle(expression('Total Emissions (tons of PM'[2.5]*') in the Baltimore From Motor Vehicle Sources (1999-2008)'))

dev.off()