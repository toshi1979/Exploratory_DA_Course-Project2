source("loadData.R")

# extract group of Baltimore city
sub <- subset(NEI,NEI$fips == "24510")

# compute sum by each year
EMBalt <- tapply(sub$Emissions,sub$year,sum)

# open png device
png(file = "plot2.png",height=480, width=480)

# draw chart on the opened device
barplot(EMBalt,ylab = "Total emissions [tons]"
                ,main = "Total PM2.5 emissions by year in Baltimore city")

# close device
dev.off()