## Load relevant packages
library(dplyr)
library(lubridate)

## Set-up
setwd("../JHU EDA")
data <- read.table("household_power_consumption.txt", skip = 1, sep = ";")
names(data) <- c("Date", "Time", "Global_active_power", "Global_reactive_power", 
                 "Voltage", "Global_intensity", "Sub_metering_1", "Sub_metering_2", "Sub_metering_3")

## Correcting format
data <- data %>% mutate_at(c(3:9), as.numeric)
data <- data %>% mutate(DateTime = paste(Date, Time))
data$DateTime <- dmy_hms(data$DateTime)
data$Date <- dmy(data$Date)
data$Time <- hms::hms(as.numeric(data$Time))

## Subsetting
mydata <- data[data$Date >= "2007-02-01" & data$Date <= "2007-02-02",]

## Plot 2
attach(mydata)
plot(DateTime, Global_active_power, type = "l", xlab = "", ylab = "Global Active Power (kilowatts)")
dev.copy(png, file="plot2.png", height=480, width=480)
dev.off()
