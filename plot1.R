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

#calculate total
total_pm <- aggregate(Emissions ~ year, NEI, sum)

#@PLOT DATA
png(
	"plot1.png",
	width = 480,
	height = 480
)

with(total_pm,{
  plot(
    main=expression('Total Emissions (tons of PM'[2.5]*') in the USA (1999-2008)'),
    year,
    Emissions,
    xlab = "Years",
    lwd=10,
    ylab = expression('Total Emissions (tons of PM'[2.5]*') ')
  )
	fit <- lm(total_pm$Emissions ~ total_pm$year)
	abline(
	  fit,
	  lwd = 3,
	  col = "red"
	)
})

dev.off()