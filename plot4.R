
################################################################################
# Section1: Read and treat the data:

# -- Read in the data:
df <- read.csv(dataFile, sep=';', na.strings='?', stringsAsFactors=FALSE)

# -- parse dates, subset rows, and name columns:
print(paste0("nrow(df)=", nrow(df)))
df$Date <- as.Date(df$Date,  format='%d/%m/%Y')
head(df)

# -- subset the data based on date range:
ss <- subset(df, Date >= as.Date('2007-02-01') & Date <= as.Date('2007-02-02'))
names(ss) <- c('Date', 'Time', 'Global_active_power', 'Global_reactive_power', 'Voltage', 'Global_intensity', 'Sub_metering_1', 'Sub_metering_2', 'Sub_metering_3')

dts <- strptime(paste(ss$Date, ss$Time), format = "%Y-%m-%d %H:%M:%S")
 
# -- add new column DateTime:
ss$DateTime <- dts
head(ss)
ss$Date <- NULL
ss$Time <- NULL

################################################################################
# Section2: Plot the graph - plot4

# Display a 2x2 array of plots

par(mfrow=c(2,2))

plot(as.numeric(ss$DateTime), ss$Global_active_power, type='l', ylab='Global Active Power (kilowatts)', xlab='', xaxt="n") #, xlim=ss$DoW)

plot(as.numeric(ss$DateTime), ss$Voltage, type='l', ylab='Voltage', xlab='datetime', xaxt="n") #, xlim=ss$DoW)

colors = c("black","red", "blue")
matplot(as.numeric(ss$DateTime), cbind(ss$Sub_metering_1,ss$Sub_metering_2,ss$Sub_metering_3),
                                 col=colors,
                                 lty=c(1,1,1),
       type='l', ylab='Energy Sub Metering', xlab='', xaxt="n")

legend('topright', names(c[,6:9])[-1] , 
   lty=1, col=colors, bty='o', cex=.75,border = "black", lwd=1, box.lwd=1 )

plot(as.numeric(ss$DateTime), ss$Global_reactive_power, type='l', ylab='Global_reactive_power', xlab='', xaxt="n") #, xlim=ss$DoW)

