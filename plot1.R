plot1 <-  function() {
	
	
	require(sqldf)
	
	fileurl <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
	filename1 <- "exdata%2Fdata%2Fhousehold_power_consumption.zip"
	if (!file.exists(filename1)) download.file(fileurl, destfile = filename1, method = "curl")
	filename2 <- "household_power_consumption.txt"
	if (!file.exists(filename2)) unzip(filename1)
	
	## Read the data
	data <- read.csv.sql("household_power_consumption.txt",sql = "select * from file where Date = '1/2/2007' or Date = '2/2/2007'", header = TRUE, sep = ";")
	data <- cbind(strptime(paste(data$Date,data$Time, sep =":"), format = '%d/%m/%Y:%H:%M:%S'),data[,3:9])
	names(data)[1] <- "Date"
	
	png(filename = "plot1.png", width = 480, height = 480, units = "px")
	with(data, hist(Global_active_power, col = "red", xlab = "Global Active Power (kilowatts)", main = "Global Active Power"))
	dev.off(which = dev.cur())
	
}
