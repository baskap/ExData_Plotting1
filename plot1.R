#creating "sample.txt" file with data from 2007-02-01 and 2007-02-02
system('head -n1 household_power_consumption.txt > sample.txt')
system('grep "^[1-2]/2/2007" household_power_consumption.txt  >> sample.txt')

#reading data from "sample.txt" file
dat  <-read.csv("./sample.txt",
                na.strings=c("?"), 
                header=TRUE,
                sep = ";")

#setting device
png("plot1.png", bg="transparent")

#plotting histogram
hist(dat$Global_active_power, 
     breaks=12, 
     col="red", 
     main="Global Active Power",
     xlab="Global Active Power (kilowatts)")

#closing device
dev.off()

#restoring defaults
Sys.setlocale("LC_TIME", user_lang)

