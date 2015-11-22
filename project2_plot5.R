library(dplyr)
library(plyr)
sccPM25 <- readRDS("/home/biffster/Dropbox/Work/Training/Data science/Coursera/Exploratory Data Analysis/summarySCC_PM25.rds")
sourcesPM25 <- readRDS("/home/biffster/Dropbox/Work/Training/Data science/Coursera/Exploratory Data Analysis/Source_Classification_Code.rds")
sccPM25balt <- sccPM25[which(sccPM25$fips == 24510),]
lookupbalt <- sourcesPM25[grep("ighway",sourcesPM25$SCC.Level.Two),]
coalFullbalt <- join(lookupbalt, sccPM25balt, by="SCC")
coalYearsbalt <- group_by(coalFullbalt, year)
coalTotalbalt <- dplyr::summarise(coalYearsbalt, count = sum(Emissions, na.rm = TRUE))
plot(coalTotalbalt$year, coalTotalbalt$count, type = "l", main = "Vehicle combustion sources in Baltimore City", ylab = "PM25 Emissions (tons)", xlab = "")
dev.copy(png,"project2_plot5.png")
dev.off()
