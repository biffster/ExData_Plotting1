library(dplyr)
fulltable <- read.csv("household_power_consumption.txt", sep=";", stringsAsFactors = FALSE, header = TRUE, na.strings = "?")
febDataRows <- grep("^[1|2]{1}/2/2007", fulltable$Date)
febData <- fulltable[febDataRows,]
febMutated <- mutate(febData, DateAndTime = as.POSIXct(strptime(paste(febData$Date,febData$Time), "%d/%m/%Y %T")))
par(mfrow=c(1,1))
plot(febMutated$DateAndTime,febMutated$Sub_metering_1,type="l", xlab="",ylab = "Energy sub metering")
lines(febMutated$DateAndTime, febMutated$Sub_metering_2, col="red")
lines(febMutated$DateAndTime, febMutated$Sub_metering_3, col="blue")
legend("topright", col=c("black", "red","blue"), c("Sub_Metering_1","Sub_metering_2","Sub_metering_3"), lty=c(1,1), lwd=c(1,1), cex = .75)

dev.copy(png,"plot3.png")
dev.off()