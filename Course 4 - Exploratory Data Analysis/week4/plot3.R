## Make sure the ggplot2 library is loaded.
library(ggplot2)

## Read in RDS data files, storing all data into NEI and SCC objects.
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

## Grab all data from Baltimore City (FIPS 24510).
baltmoreEmissions <- NEI[NEI$fips=="24510",]

## Aggregate total emissions by year.
baltimoreAggEmissions <- aggregate(Emissions ~ year + type, baltmoreEmissions, sum)

## We want to create a png named "plot3.png".
png("plot3.png",width=640,height=480)

## Create bar plots (using ggplot2) of total pm2.5 emissions by source type
## for Baltimore City (FIPS 24510) for years 1999, 2002, 2005, and 2008.
baltimoreEmissionsPlot <- ggplot(baltimoreAggEmissions, aes(x=factor(year), y=Emissions, fill=type)) +
  geom_bar(stat="identity") +
  facet_grid(. ~ type) +
  xlab("year") +
  ylab("total PM2.5 emissions (tons)") +
  ggtitle("PM2.5 emissions in Baltimore City by source type")

## Write output of the ggplot function to plot3.png file.
print(baltimoreEmissionsPlot)

## Kill handle to open file.
dev.off()