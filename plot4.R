#
# Plot4.R
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
#create list of coal sources
coal_sources <- SCC[grepl("Fuel Comb.*Coal", SCC$EI.Sector),]

#subset data to contain only coal sources
emissions <- NEI[(NEI$SCC %in% coal_sources$SCC), ]

#group by year
emissions_year <- aggregate(Emissions ~ year, data=emissions, FUN=sum)

#@PLOT DATA
library(ggplot2)

png(
	"plot4.png",
	height=480,
	width=480
)

ggplot(
	emissions_year,
	aes(x=year, y=Emissions)
) +
geom_point(stat="identity", size=4) +
geom_smooth(method = "lm", se=F, colour="red") +
xlab("Years") +
ylab(expression('Total Emissions (PM'[2.5]*') ')) +
ggtitle(expression('Total Emissions (PM'[2.5]*') in the US From Coal-Combustion Sources'))

dev.off()
