# plot1.png shows a histogram of Frequency vs Global Active Power.

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

png(filename="plot1.png", height=480, width=480)

# Plot the histogram.

hist(sub_data$Global_active_power,
     col="red",
     main="Global Active Power",
     xlab="Global Active Power (kilowatts)",
     ylab="Frequency")

# Save the figure and close the png device.

dev.off()