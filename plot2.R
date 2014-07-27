#
# Plot2.R
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
#only Baltimore City, Maryland
baltimore_pm <- NEI[NEI$fips=="24510",]

#group by year
baltimore_pm_year <- aggregate(Emissions ~ year, baltimore_pm, sum)

#@PLOT DATA
png(
	"plot2.png",
	width = 580,
	height = 480
)

with(baltimore_pm_year,{
  plot(
    main=expression('Total Emissions (tons of PM'[2.5]*') in Baltimore City, Maryland (1999-2008)'),
    year,
    Emissions,
    xlab = "Years",
    lwd=10,
    ylab = expression('Total Emissions (tons of PM'[2.5]*') ')
  )
	fit <- lm(baltimore_pm_year$Emissions ~ baltimore_pm_year$year)
	abline(
	  fit,
	  lwd = 3,
	  col = "red"
	)
})

dev.off()