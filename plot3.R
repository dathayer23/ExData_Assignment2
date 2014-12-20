## Examine the change of PCM25 yearly totals from 1999 - 2008

## load ggplot system
library(ggplot2)

## Read in the data
SCC <- readRDS("Source_Classification_Code.rds")
NEI <- readRDS("summarySCC_PM25.rds")

## flag all data from Baltimore
baltimoreData <- NEI$fips == 24510

baltdata <- data.frame(NEI$Emissions[baltimoreData], NEI$type[baltimoreData], NEI$year[baltimoreData])
names(baltdata) <- c("Emissions","type","year")



## create matrix of data group sums with each years data in a col and each types data in a row
datagroups <- split(baltdata, baltdata$type)

createSourceGroup <- function(df) {
  rawdata <- split(df, df$year)
  sumdata <- sapply(rawdata, sum)
  dfdata <- data.frame(names(sumdata), sumdata)
  names(dfdfdata) <- c("year","emissions")
  dfdata
}

nonroadData <- split(datagroups[[1]], datagroups[[1]]$year)
nonRoadData <- sapply(nonroadData, function(grp) sum(grp$Emissions))
dfNonRoad <- data.frame(names(nonRoadData), nonRoadData)
names(dfNonRoad) <- c("year","emissions")

nonpointData <- split(datagroups[[2]], datagroups[[2]]$year)
nonPointData <- sapply(nonpointData, function(grp) sum(grp$Emissions))
dfNonPoint <- data.frame(names(nonPointData), nonPointData)
names(dfNonPoint) <- c("year","emissions")

onroadData <- split(datagroups[[3]], datagroups[[3]]$year)
onRoadData <- sapply(onroadData, function(grp) sum(grp$Emissions))
dfOnRoad <- data.frame(names(onRoadData), onRoadData)
names(dfOnRoad) <- c("year","emissions")

pointData <- split(datagroups[[4]], datagroups[[4]]$year)
PointData <- sapply(pointData, function(grp) sum(grp$Emissions))
dfPoint <- data.frame(names(PointData), PointData)
names(dfPoint) <- c("year","emissions")


## dim(datapoints) <- c(4, 4)
## dimnames(datapoints) <- list(sources, years)


## create plot
## dev <- png("plot3.png")
p <- ggplot(dfNonRoad, aes(x=year, y = emissions, group = 1))
p + geom_line(color = "red", size = 1)  + geom_line(data=dfNonPoint, color = "green", size = 1) +
       geom_line(data = dfOnRoad, color = "blue", size = 1) +
       geom_line(data = dfPoint, color = "black", size = 1) +
       annotate("text", x = 4, y = 2200, color = "red", label = "Non Road Emissions") +
       annotate("text", x = 4, y = 2100, color = "blue", label = "On Road Emissions") +
       annotate("text", x = 4, y = 1900, color = "green", label = "Non Point Emissions") +       
       annotate("text", x = 3.9, y = 1800, color = "black", label = "Point Emissions")
ggsave("plot3.png")
## dev.off()

## dev <- png("plot2.png")
## par(mfrow = c(2,2))
## plot(years, datapoints[1,], pch = 7, main = "Total PCM25 by NON-Road sources", xlab = "Year", ylab = "Total PCM25")
## lines(years, datapoints[1,], col = "red")
## plot(years, datapoints[2,], pch = 7, main = "Total PCM25  by NONPOINT sources", xlab = "Year", ylab = "Total PCM25")
## lines(years, datapoints[2,], col = "green")
## plot(years, datapoints[3,], pch = 7, main = "Total PCM25  by ON-Road sources", xlab = "Year", ylab = "Total PCM25")
## lines(years, datapoints[3,], col = "blue")
## plot(years, datapoints[4,], pch = 7, main = "Total PCM25 by POINT sources", xlab = "Year", ylab = "Total PCM25")
## lines(years, datapoints[4,], col = "black")
## dev.off()

