<<<<<<< HEAD
library(dplyr)
sccPM25 <- readRDS("/home/biffster/Dropbox/Work/Training/Data science/Coursera/Exploratory Data Analysis/summarySCC_PM25.rds")
years <- group_by(sccPM25, year)
totalemission <- summarise(years,count = sum(Emissions))
plot(totalemission$year,totalemission$count, type = "l", main="", ylab = "PM25 Emissions (tons)", xlab = "")
dev.copy(png,"project2_plot1.png")
dev.off()
||||||| merged common ancestors
=======
library(dplyr)
sccPM25 <- readRDS("summarySCC_PM25.rds")
years <- group_by(sccPM25, year)
totalemission <- summarise(years,count = n())
plot(totalemission$year,totalemission$count, type = "l", main="", ylab = "PM25 Emissions (tons)", xlab = "")
dev.copy(png,"project2_plot1.png")
dev.off()
>>>>>>> ae63e1d650067f1d6ecf80b4cf1ef479c1465ec0
