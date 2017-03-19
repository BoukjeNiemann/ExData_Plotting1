# read in the dataset
# ? means data is missing
# I try to use only base R in this script
# I can't change the names of the days to the English versions
# because I can't change the default locale to English because my OS won't accept
# Sys.setlocale("LC_TIME", "English")
url <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
download.file(url, destfile="household_power_consumption.zip", method="curl")
unzip("household_power_consumption.zip")
powerdata <- read.table("household_power_consumption.txt", header = TRUE, sep = ";", 
                        na.strings = "?", as.is = TRUE)
# extract only 2007-02-01 and 2007-02-02
pdata <- powerdata[powerdata$Date=="1/2/2007" | powerdata$Date=="2/2/2007",]
# combine the first columns to a datetime
datetime <- paste(pdata$Date,pdata$Time)
pdata <- cbind(datetime,pdata)
# give the datetime column a Date and Time format
pdata$datetime <- strptime(pdata$datetime, "%d/%m/%Y %H:%M:%S")
# make the required plot
with(pdata, plot(datetime, Global_active_power, type = "l", ylab = "Global Active Power (kilowatts)"))
# save as png file, defaults are 480 x 480 pixels
dev.copy(png, file="plot2.png")
dev.off()
plot.new()
