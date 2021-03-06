#------  DownLoad archive and create table  -------
temp <- tempfile()
download.file("https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip",temp)
data <- read.csv(unz(temp, "household_power_consumption.txt"), header=T, sep=';', na.strings="?", 
                nrows=2075259, check.names=F, stringsAsFactors=F, comment.char="", quote='\"')
unlink(temp)

#------   Formatting date and get subset  -------
data$Date <- as.Date(data$Date, format="%d/%m/%Y")
data <- subset(data, subset=(Date >= "2007-02-01" & Date <= "2007-02-02"))
data$Datetime <- as.POSIXct(paste(as.Date(data$Date), data$Time))

#------   To get space for our Histogram and draw it  -------
dev.new()
par(mfcol = c(1,1))
hist(data$Global_active_power, main="Global Active Power",
     xlab="Global Active Power (kilowatts)", ylab="Frequency", col="Red")

#------   Save our picture  -------
dev.copy(png, file="plot1.png", height=480, width=480)
dev.off()
#------   Choose next screen  -------
dev.new()

#------   Draw our plot  -------
par(mfcol = c(1,1))
plot(data$Global_active_power~data$Datetime, type="l",
     ylab="Global Active Power (kilowatts)", xlab="")

#------   Save our picture  -------
dev.copy(png, file="plot2.png", height=480, width=480)
dev.off()
#------   Choose next screen  -------
dev.new()

#------   Draw next chart  -------
par(mfcol = c(1,1))
with(data, {
  plot(Sub_metering_1~Datetime, type="l",
       ylab="Global Active Power (kilowatts)", xlab="")
  lines(Sub_metering_2~Datetime,col='Red')
  lines(Sub_metering_3~Datetime,col='Blue')
})

#------   Write legend  -------
legend("topright", col=c("black", "red", "blue"), lty=1, lwd=2, 
       legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))

#------   Save our picture  -------
dev.copy(png, file="plot3.png", height=480, width=480)
dev.off()
#------   Choose next screen  -------
dev.new()

#------   Get space for our charts  -------
par(mfrow=c(2,2), mar=c(4,4,2,1), oma=c(0,0,2,0))

#------   Draw the last one  -------
with(data, {
  plot(Global_active_power~Datetime, type="l", 
       ylab="Global Active Power (kilowatts)", xlab="")
  plot(Voltage~Datetime, type="l", 
       ylab="Voltage (volt)", xlab="")
  plot(Sub_metering_1~Datetime, type="l", 
       ylab="Global Active Power (kilowatts)", xlab="")
  lines(Sub_metering_2~Datetime,col='Red')
  lines(Sub_metering_3~Datetime,col='Blue')
  legend("topright", col=c("black", "red", "blue"), lty=1, lwd=2, bty="n",
         legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))
  plot(Global_reactive_power~Datetime, type="l", 
       ylab="Global Rective Power (kilowatts)",xlab="")
})

#------   Save our picture  -------
dev.copy(png, file="plot4.png", height=480, width=480)
dev.off()

