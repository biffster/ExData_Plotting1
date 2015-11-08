library(dplyr)
fulltable <- read.csv("household_power_consumption.txt", sep=";", stringsAsFactors = FALSE, header = TRUE, na.strings = "?")
febDataRows <- grep("^[1|2]{1}/2/2007", fulltable$Date)
febData <- fulltable[febDataRows,]
febMutated <- mutate(febData, DateAndTime = as.POSIXct(strptime(paste(febData$Date,febData$Time), "%d/%m/%Y %T")))
par(mfrow=c(2,2))
# This creates the first plot (upper-left)
plot(febMutated$DateAndTime, febData$Global_active_power, type="n", main="", ylab = "Global Active Power", xlab = "")
lines(febMutated$DateAndTime, febMutated$Global_active_power, type="l")

# This creates the second plot (upper-right)
plot(febMutated$DateAndTime, febData$Voltage, type="n", main="", ylab = "Voltage", xlab = "datetime")
lines(febMutated$DateAndTime, febMutated$Voltage, type="l")

# This creates the third plot (lower-left)
plot(febMutated$DateAndTime,febMutated$Sub_metering_1,type="l", xlab="",ylab = "Energy sub metering")
lines(febMutated$DateAndTime, febMutated$Sub_metering_2, col="red")
lines(febMutated$DateAndTime, febMutated$Sub_metering_3, col="blue")
legend("topright", col=c("black", "red","blue"), c("Sub_Metering_1","Sub_metering_2","Sub_metering_3"), lty=c(1,1), lwd=c(1,1), cex=0.4)

# This creates the fourth plot (lower-right)
plot(febMutated$DateAndTime,febMutated$Global_reactive_power,type="l", xlab="datetime",ylab = "Global_reactive_power")

# Export the chart to a png
dev.copy(png,"plot4.png")
dev.off()
