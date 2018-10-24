plot3 <-  function() {
	
	
	require(sqldf)
	fileurl <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
	filename1 <- "exdata%2Fdata%2Fhousehold_power_consumption.zip"
	if (!file.exists(filename1)) download.file(fileurl, destfile = filename1, method = "curl")
	filename2 <- "household_power_consumption.txt"
	if (!file.exists(filename2)) unzip(filename1)
	
	## Read the data only at selected dates
	data <- read.csv.sql("household_power_consumption.txt",sql = "select * from file where Date = '1/2/2007' or Date = '2/2/2007'", header = TRUE, sep = ";")
	data <- cbind(strptime(paste(data$Date,data$Time, sep =":"), format = '%d/%m/%Y:%H:%M:%S'),data[,3:9])
	names(data)[1] <- "Date"
	
	png(filename = "plot3.png", width = 480, height = 480, units = "px")
	with(data, plot(Date, Sub_metering_1, "l", xlab = "", ylab = "Energy sub metering", main = ""))
	with(data, lines(Date, Sub_metering_2, col = "red"))
	with(data, lines(Date, Sub_metering_3, col = "blue"))
	legend(x="topright", legend = names(data)[6:8], col = c("black", "red", "blue"), lty = c(1,1,1))
	dev.off(which = dev.cur())

}
