#
# Plot1.R
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

total.pm <- aggregate(Emissions ~ year, NEI, sum)

png(
	"plot1.png",
	width = 480,
	height = 480
)

barplot(
	main=expression('Total Emissions (PM'[2.5]*') in the United States from 1999 to 2008'),
	height=total.pm$Emissions,
	names.arg=total.pm$year,
	xlab="Years",
	ylab=expression('Total Emissions (PM'[2.5]*') ')
)

dev.off()