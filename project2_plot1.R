# This script will generate a plot showing the trend of PM2.5 Emissions over
# the decade from 1999 to 2008.

# I use dplyr to use the groupby() and summarise() functions
library(dplyr)

# Import data from the RDS file into a dataframe
sccPM25 <- readRDS("/home/biffster/Dropbox/Work/Training/Data science/Coursera/Exploratory Data Analysis/summarySCC_PM25.rds")

# Group the datafiles by year, and then summarise the resulting dataset
# to get the total emissions by year.
years <- group_by(sccPM25, year)
totalemission <- dplyr::summarise(years,count = sum(Emissions))

# Simple line plot using the base graphics system. Note: I chose to
# express the emissions in log(tons) to better highlight the scale of
# the trends over the years.
plot(totalemission$year,log(totalemission$count), type = "l", main="Fine particular matter emission trends", ylab = "PM25 Emissions (log(tons))", xlab = "")

# Export the plot to a PNG file.
dev.copy(png,"project2_plot1.png")
dev.off()
