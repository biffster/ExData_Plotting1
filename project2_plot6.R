library(plyr)
library(dplyr)
sccPM25 <- readRDS("/home/biffster/Dropbox/Work/Training/Data science/Coursera/Exploratory Data Analysis/summarySCC_PM25.rds")
sourcesPM25 <- readRDS("/home/biffster/Dropbox/Work/Training/Data science/Coursera/Exploratory Data Analysis/Source_Classification_Code.rds")

sccPM25balt <- sccPM25[which(sccPM25$fips == 24510),]
lookupbalt <- sourcesPM25[grep("ighway",sourcesPM25$SCC.Level.Two),]
coalFullbalt <- join(lookupbalt, sccPM25balt, by="SCC")
coalYearsbalt <- group_by(coalFullbalt, year)
coalTotalbalt <- dplyr::summarise(coalYearsbalt, count = sum(Emissions, na.rm = TRUE))

sccPM25lac <- sccPM25[which(sccPM25$fips == "06037"),]
lookuplac <- sourcesPM25[grep("ighway",sourcesPM25$SCC.Level.Two),]
coalFulllac <- join(lookuplac, sccPM25lac, by="SCC")
coalYearslac <- group_by(coalFulllac, year)
coalTotallac <- dplyr::summarise(coalYearslac, count = sum(Emissions, na.rm = TRUE))

par(mfrow=c(2,1))
plot(coalTotalbalt$year, coalTotalbalt$count, type = "l", main = "Vehicle combustion sources in Baltimore City", ylab = "PM25 Emissions (tons)", xlab = "", col = "blue", lwd = 2.5)
plot(coalTotallac$year, coalTotallac$count, type = "l", main = "Vehicle combustion sources in Los Angeles County", ylab = "PM25 Emissions (tons)", xlab = "", col = "red", lwd = 2.5)

dev.copy(png,"project2_plot6.png")
dev.off()