############### Assignment Week 1 of Exploratory Data Analysis ############

# First calculate a rough estimate of how much memory the dataset will require in memory before reading into R
 # Number of rows = 2,075,259
 # Number of cols = 9
 # Therefore total data = 9 X 2075259
 # 
 # (assuming all column data read by read.table would be a factor and one factor takes 8 bytes)
 # Required size in bytes = 9 X 2075259 X 8 = 149418648 bytes ~ 142 MB (approx)

### Downloading and unzipping Data File

setwd("D:\\Coursera\\Data Science - Specialization\\04_Exploratory Data Analysis\\RCode")

url <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
f <- "household_power_consumption.zip"
download.file(url=url,destfile = f, mode = "wb")

unzip(f)


###############################################################
#### Read the Data File
data1 <- read.table("household_power_consumption.txt", header = TRUE, sep = ";", nrows = 70000)

## Strip the Date and Time fields and combine them together
DateTime <- strptime(paste(data1$Date, data1$Time), "%e/%m/%Y %H:%M:%S")

## Drop Date and Time columns from dataframe
data2 <- subset(data1, select = -c(Date, Time))

## Add new column of combined Date & Time to the dataframe
data3 <- cbind(DateTime, data2)

## filter out data of only 2 days of Feb 2007
data4 <- data3[data3$DateTime >= "2007-02-01 00:00:00" & data3$DateTime <= "2007-02-02 23:59:59",]

## Convert all but first columns to numeric
data4[, c(2:8)] <- sapply(data4[, c(2:8)], as.character)  # as.character is used first so that factor index wouldn't reflect in numeric coersion
data4[, c(2:8)] <- sapply(data4[, c(2:8)], as.numeric)

#### Free memory, which is no more required. Freeing everything except "data4"
rm(list=setdiff(ls(), "data4"))

#######################################
### PLOTTING 2

# Launching the PNG Graphic Device
png(filename = "plot2.png", width = 480, height = 480)

# Plotting the lines plot on the Graphics Device
plot(x = data4$DateTime, y = data4$Global_active_power, type = "l", xlab = "", ylab = "Global Active Power (kilowatts)")

# Closing the Graphic Device
dev.off()

