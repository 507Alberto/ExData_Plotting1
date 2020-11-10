library(dplyr)
library(reshape2)

# Checking if folder exists
if (!file.exists("exdata_data_household_power_consumption")) { 
    unzip("exdata_data_household_power_consumption.zip") 
}

data <- read.table("./household_power_consumption.txt"
                   , quote="\""
                   , comment.char=""
                   , sep = ";"
                   , header = TRUE
                   , na.strings = "?"
                   , colClasses = c("character","character"
                                    ,"numeric","numeric"
                                    ,"numeric","numeric"
                                    ,"numeric","numeric"
                                    ,"numeric"))
data <- data %>% filter(Date %in% c("1/2/2007","2/2/2007"))
data <- data %>% mutate(Date = as.Date(Date, "%e/%m/%Y"),DateTime = paste(Date, Time))
data$DateTime <- strptime(data$DateTime,format = "%Y-%m-%d %H:%M:%S")


# Plot 1
hist(data$Global_active_power, col = "red",
     main = "Global Active Power",
     xlab = "Global Active Power (kilowatts)")
dev.copy(png,filename = "./plot1.png",width = 480, height = 480)
dev.off()

# Plot 2
plot(x = data$DateTime,y = data$Global_active_power, type = "l",
     ylab = "Global Active Power (kilowatts)",
     xlab = "")
dev.copy(png,filename = "./plot2.png",width = 480, height = 480)
dev.off()

# Plot 3
plot(x = data$DateTime,y = data$Sub_metering_1, type = "l",
     ylab = "Energy sub metering",
     xlab = "")
lines(x = data$DateTime,y = data$Sub_metering_2, col = "red")
lines(x = data$DateTime,y = data$Sub_metering_3, col = "blue")
legend("topright", lty = 1, lwd = 2,
       legend = c("Sub_metering_1","Sub_metering_2","Sub_metering_3"),
       col = c("black","red","blue"))

dev.copy(png,filename = "./plot3.png",width = 480, height = 480)
dev.off()

# Plot 4
par(mfrow = c(2,2))

plot(x = data$DateTime,y = data$Global_active_power, type = "l",
     ylab = "Global Active Power (kilowatts)",
     xlab = "")

plot(x = data$DateTime,y = data$Voltage, type = "l",
     ylab = "Voltage",
     xlab = "datetime")

plot(x = data$DateTime,y = data$Sub_metering_1, type = "l",
     ylab = "Energy sub metering",
     xlab = "")
lines(x = data$DateTime,y = data$Sub_metering_2, col = "red")
lines(x = data$DateTime,y = data$Sub_metering_3, col = "blue")
legend("topright", lty = 1, lwd = 2, cex = 0.6, bty = "n",xjust = 1, yjust = 1,
       legend = c("Sub_metering_1","Sub_metering_2","Sub_metering_3"),
       col = c("black","red","blue"))

plot(x = data$DateTime,y = data$Global_reactive_power, type = "l",
     ylab = "Global_reactive_power",
     xlab = "datetime")

dev.copy(png,filename = "./plot4.png",width = 480, height = 480)
dev.off()