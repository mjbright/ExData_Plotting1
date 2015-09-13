
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
# Section2: Plot the graph - plot2


W <- strftime(ss$DateTime, format='%a')
#head(ss)

ss$DoW <- factor(ss$DoW, levels=c("Mon", "Tue", "Wed", "Thu", "Fri", "Sat", "Sun"), ordered = TRUE)
#head(ss)
#tail(ss)
#?strptime

plot(as.numeric(ss$DateTime), ss$Global_active_power, type='l', ylab='Global Active Power (kilowatts)', xlab='', xaxt="n") #, xlim=ss$DoW)
axis(1, at=1:7, labels=c("Mon", "Tue", "Wed", "Thu", "Fri", "Sat", "Sun"))

