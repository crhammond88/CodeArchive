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
## Create a connected line plot of the Global Active Power between 2007-02-01 and 2007-02-02
plot(data[,DateTime],data[, Global_active_power], xlab = "", ylab = "Global Active Power (kilowatts)", 
     type = "l")
## Create a new PNG file
fileName <- "plot2.png"
if(!file.exists(fileName)) { file.create(fileName) }
## Save the plot to the PNG file, default size is 480x480
dev.copy(png, file = fileName)
## Close the connection to the PNG file
dev.off()
