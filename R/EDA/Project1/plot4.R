## Load data.table package for fast performance
library("data.table")
## Load lubridate package for parse_date_time function
library("lubridate")
## Read data from text file
data <- fread("household_power_consumption.txt", sep = ";", na.strings = c("?"))
## Convert Date column to R's Date format
data[,1] <- as.Date(data[,Date], "%d/%m/%Y")
## Subset data to relevant dates
data <- data[which(data[,Date] == "2007-02-01" | data[,Date] == "2007-02-02"),]
## Combine Date and Time into one variable and add it as a new column
data[,DateTime:= { tmp <- paste(Date, Time); parse_date_time(tmp, "ymd HMS")}]
## Convert other variables to numeric class
data[,3] <- as.numeric(data[,Global_active_power])
data[,4] <- as.numeric(data[,Global_reactive_power])
data[,5] <- as.numeric(data[,Voltage])
data[,6] <- as.numeric(data[,Global_intensity])
data[,7] <- as.numeric(data[,Sub_metering_1])
data[,8] <- as.numeric(data[,Sub_metering_2])
data[,9] <- as.numeric(data[,Sub_metering_3])
## Create a new PNG file            
fileName <- "plot4.png"
if(!file.exists(fileName)) { file.create(fileName) }
## Set new PNG file as graphical output device
png(fileName)
## Set the graphics to create two rows of two plots
par(mfrow = c(2,2))
## Create a connected line plot of the Global Active Power between 2007-02-01 and 2007-02-02
plot(data[,DateTime],data[, Global_active_power], xlab = "", ylab = "Global Active Power", 
     type = "l")
## Create a connected line plot of the Voltage use between 2007-02-01 and 2007-02-02
plot(data[,DateTime],data[, Voltage], xlab = "datetime", ylab = "Voltage", 
     type = "l")
## Create a connected line plot of the Energy sub metering between 2007-02-01 and 2007-02-02
plot(data[,DateTime],data[, Sub_metering_1], xlab = "", ylab = "Energy sub metering", 
     type = "l")
## Add a line for the second sub metering
lines(data[,DateTime],data[, Sub_metering_2], col = "red")
## Add a line for the third sub metering
lines(data[,DateTime],data[, Sub_metering_3], col = "blue")
## Create a legend to indicate the color associated with each sub metering line
legend("topright", col = c("black","red","blue"), lwd = 1,
       legend = c("Sub_metering_1", "Sub_metering_2","Sub_metering_3"), bty = "n")
## Create a connected line plot of the Global Reactive Power between 2007-02-01 and 2007-02-02
plot(data[,DateTime],data[, Global_reactive_power], xlab = "datetime", ylab = "Global_reactive_power", 
     type = "l", lwd = 0.5)
## Close the connection to the PNG file
dev.off()