# plot4.png shows Ssubplots of Energy, Voltage, and Power.

# Load the power consumption data set, convert the first two columns
# into the required date/time format, and replace the "?" symbol into
# the NA character.

data <- read.csv("household_power_consumption.txt",
                 sep=";",
                 colClasses=c(rep("character",2),rep("numeric",7)),
                 na.strings="?")

# Merge the date and time columns into one single timestamp.

data$Timestamp <- strptime(paste(data$Date,data$Time),
                           format="%d/%m/%Y %H:%M:%S")

# Eliminate the date and time collumns that are not necessary any more.

data$Date = NULL
data$Time = NULL

# Subset the required data only (from 2007-02-01 to 2007-02-02).

sub_data = subset(data,as.Date(data$Timestamp) >= "2007-02-01" 
                  & as.Date(data$Timestamp) < "2007-02-03")

# Initiate the png device.

png(filename="plot4.png", height=480, width=480)

# Set a 2x2 split to display the four plots.

par(mfrow = c(2,2))

# Subplot 1 is the same as plot2.png.

plot(sub_data$Timestamp,
     sub_data$Global_active_power,
     type="l",
     xlab="",
     ylab="Global Active Power")

# Subplot 2 is Voltage versus Time.

plot(sub_data$Timestamp,
     sub_data$Voltage,
     type="l",
     xlab="datetime",
     ylab="Voltage")

# Subplot 3 is same as plot3.png.

plot(sub_data$Timestamp,
     sub_data$Sub_metering_1,
     type="l",
     xlab="",
     ylab="Energy sub metering")

lines(sub_data$Timestamp,
      sub_data$Sub_metering_2,
      type="l",
      col="red")

lines(sub_data$Timestamp,
      sub_data$Sub_metering_3,
      type="l",
      col="blue")

legend(x="topright",
       c("Sub_metering_1","Sub_metering_2","Sub_metering_3"),
       lty=c(1,1),lwd=2,col=c("black","red","blue"),bty="n")

# Subplot 4 is Global Reactive Power versus Time.

plot(sub_data$Timestamp,
     sub_data$Global_reactive_power,
     type="l",
     xlab="datetime",
     ylab="Global_reactive_power")

# Save the figure and close the png device.

dev.off()