#
# Plot3.R
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

#subset to select Baltimore City, Maryland
baltimore_pm <- NEI[NEI$fips=="24510",]

#group by year and type
baltimore_pm_y_t <- aggregate(Emissions ~ year + type, data=baltimore_pm, FUN=sum)

#@PLOT DATA

library(ggplot2)

png(
	"plot3.png",
	height=480,
	width=880
)

ggplot(
	baltimore_pm_y_t,
	aes(x=year, y=Emissions, colour=type)
) +
geom_point(stat="identity", size=4) +
geom_smooth(method = "lm", se=F) +
facet_grid(. ~ type) +
xlab("Years") +
ylab(expression('Total Emissions (PM'[2.5]*') ')) +
ggtitle(expression('Total Emissions (PM'[2.5]*') in Baltimore City, Maryland by Source Type'))

dev.off()