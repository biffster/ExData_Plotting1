library(dplyr)
fulltable <- read.csv("household_power_consumption.txt", sep=";", stringsAsFactors = FALSE, header = TRUE, na.strings = "?")
febDataRows <- grep("^[1|2]{1}/2/2007", fulltable$Date)
febData <- fulltable[febDataRows,]
febMutated <- mutate(febData, DateAndTime = as.POSIXct(strptime(paste(febData$Date,febData$Time), "%d/%m/%Y %T")))
plot(febMutated$DateAndTime, febData$Global_active_power, type="n", main="", ylab = "Global Active Power (kilowatts)", xlab = "")
lines(febMutated$DateAndTime, febMutated$Global_active_power, type="l")

dev.copy(png,"plot2.png")
dev.off()