# Required Libraries

library(dplyr)
library(lubridate)
library(chron)

#Reading txt file into R, subsetting for the required dates

data1 <- read.table("household_power_consumption.txt", skip = 66637, 
                    nrow = 2880, sep = ";", na.strings = "?")

# Transforming from character to Date & Time formats

data1$V1 <- as.Date(data1$V1, "%d/%m/%Y")
data1$V2 <- times(data1$V2)

Date_Time <- as.data.frame(as.POSIXct(paste(data1$V1, data1$V2), 
                                      format="%Y-%m-%d %H:%M:%S"))
data1$V1 <- NULL
data1$V2 <- NULL
data1 <- cbind(Date_Time, data1)


names(data1) <- c("Date_Time", "Global_active_power", "Global_reactive_power",
                  "Voltage", "Global_intensity", "Sub_metering_1", 
                  "Sub_metering_2",
                  "Sub_metering_3")


# Creating third plot and setting up graphical device

png(filename = "plot3.png", width = 480, height = 480)

with(data1, plot(Date_Time, Sub_metering_1, type = "l", xlab = "", 
                 ylab = "Energy Sub Metering"))
with(data1, lines(Date_Time, Sub_metering_2, col = "red"))
with(data1, lines(Date_Time, Sub_metering_3, col = "blue"))
legend("topright", pch = "-" , col = c("black", "red", "blue"), 
       legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))
dev.off()
