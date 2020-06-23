## Make sure the ggplot2 library is loaded.
library(ggplot2)

## Read in RDS data files, storing all data into NEI and SCC objects.
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

## Grab all vehicle emissions data from Baltimore City (FIPS 24510).
baltmoreEmissions <- NEI[(NEI$fips=="24510") & (NEI$type=="ON-ROAD"),]

## Aggregate total emissions by year.
baltimoreAggEmissions <- aggregate(Emissions ~ year, data=baltmoreEmissions, FUN=sum)


## We want to create a png named "plot5.png".
png("plot5.png",width=640,height=480)

## Create bar plots (using ggplot2) of total cooal pm2.5 emissions
## for years 1999, 2002, 2005, and 2008.
bmoreCarEmissionsPlot <- ggplot(baltimoreAggEmissions, aes(x=factor(year), y=Emissions)) +
  geom_bar(aes(fill=year),stat="identity", lwd=2) +
  xlab("year") +
  ylab("total PM2.5 emissions (tons)") +
  ggtitle("Emissions from motor vehicle sources in Baltimore City")

## Write output of the ggplot function to plot3.png file.
print(bmoreCarEmissionsPlot)

## Kill handle to open file.
dev.off()