## Make sure the ggplot2 library is loaded.
library(ggplot2)

## Read in RDS data files, storing all data into NEI and SCC objects.
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

## Grab all coal data.
coalData <- SCC[grepl("Fuel Comb.*Coal", SCC$EI.Sector),]

## Grab coal emissions.
coalEmissions <- NEI[(NEI$SCC %in% coalData$SCC), ]

## Aggregate coal emissions by year.
coalAggEmissions <- aggregate(Emissions ~ year, data=coalEmissions, FUN=sum)

## We want to create a png named "plot4.png".
png("plot4.png",width=640,height=480)

## Create bar plots (using ggplot2) of total cooal pm2.5 emissions
## for years 1999, 2002, 2005, and 2008.
coalEmissionsPlot <- ggplot(coalAggEmissions, aes(x=factor(year), y=Emissions)) +
  geom_bar(aes(fill=year),stat="identity", lwd=2) +
  xlab("year") +
  ylab("total PM2.5 emissions (tons)") +
  ggtitle("Emissions from coal sources")

## Write output of the ggplot function to plot3.png file.
print(coalEmissionsPlot)

## Kill handle to open file.
dev.off()