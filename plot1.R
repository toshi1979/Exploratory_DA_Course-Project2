# load data frame from file
source("loadData.R")

# compute sum by each year
EMbyYear <- tapply(NEI$Emissions,NEI$year,sum)

# open png device
png(file = "plot1.png",height=480, width=480)

# draw chart on the opened device
barplot(EMbyYear,ylab = "Total emissions [tons]"
                ,main = "Total PM2.5 emissions by year")

# close device
dev.off()