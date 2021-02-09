# Required Libraries

library(dplyr)
library(lubridate)
library(chron)

#Reading txt file into R, subsetting for the required dates

data1 <- read.table("household_power_consumption.txt", skip = 66637, nrow = 2880, sep = ";", na.strings = "?")

names(data1) <- c("Date", "Time", "Global_active_power", "Global_reactive_power",
                  "Voltage", "Global_intensity", "Sub_metering_1", "Sub_metering_2",
                  "Sub_metering_3")

# Transforming from character to Date & Time formats

data1$Date <- as.Date(data1$Date, "%d/%m/%Y")
data1$Time <- times(data1$Time)

# Creating first plot and setting up graphical device

png(filename = "plot1.png", width = 480, height = 480)

hist(data1$Global_active_power, main = "Global Active Power", 
     xlab = "Global Active Power (Kilowatts)", col = "red")

dev.off()
