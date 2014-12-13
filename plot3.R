## Examine the change of PCM25 yearly totals from 1999 - 2008

## load ggplot system
library(ggplot2)

## Read in the data
SCC <- readRDS("Source_Classification_Code.rds")
NEI <- readRDS("summarySCC_PM25.rds")

## create year labels
years <- unique(NEI$year)
sources <- c("NON-ROAD", "NONPOINT", "ON-ROAD", "POINT")
## creae matrix of data group sums with each tears data in a col and each types data in a row
datagroups <- sapply(split(NEI, NEI$year), function (grp) split(grp, grp$type))
datapoints <- sapply(datagroups, function (grp) sum(grp$Emissions))
dim(datapoints) <- c(4, 4)
dimnames(datapoints) <- list(sources, years)


## create plot
##dev <- png("plot2.png")
par(mfrow = c(2,2))
plot(years, datapoints[1,], pch = 7, main = "Total PCM25 by NON-Road sources", xlab = "Year", ylab = "Total PCM25")
lines(years, datapoints[1,], col = "red")
plot(years, datapoints[2,], pch = 7, main = "Total PCM25  by NONPOINT sources", xlab = "Year", ylab = "Total PCM25")
lines(years, datapoints[2,], col = "green")
plot(years, datapoints[3,], pch = 7, main = "Total PCM25  by ON-Road sources", xlab = "Year", ylab = "Total PCM25")
lines(years, datapoints[3,], col = "blue")
plot(years, datapoints[4,], pch = 7, main = "Total PCM25 by POINT sources", xlab = "Year", ylab = "Total PCM25")
lines(years, datapoints[4,], col = "black")
##dev.off()

