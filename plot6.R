source("loadData.R")
library(ggplot2)

# extract group of Baltimore city
BaltSub <- subset(NEI,NEI$fips == "24510")
LosSub <- subset(NEI,NEI$fips == "06037")

# merge NEI and SCC data
message("merging two data set...")
BaltDf <- merge(BaltSub,SCC,by = "SCC")
LosDf <- merge(LosSub,SCC,by = "SCC")

# extract only vehicle sources
BaltDf <- BaltDf[grepl("Vehicle",BaltDf$SCC.Level.Two),]
LosDf <- LosDf[grepl("Vehicle",LosDf$SCC.Level.Two),]

# compute sum by each year
message("computing sum...")
EMBaltVehicle <- aggregate(BaltDf$Emissions,list(BaltDf$year),sum)
EMLosVehicle <- aggregate(LosDf$Emissions,list(LosDf$year),sum)

# explicitly add name to the columns
colnames(EMBaltVehicle) = c("year","totalEmission")
colnames(EMLosVehicle) = c("year","totalEmission")

# coerce from integer to factor
EMBaltVehicle$year <- as.factor(EMBaltVehicle$year)
EMLosVehicle$year <- as.factor(EMLosVehicle$year)

# create new data frame to compare the "change"
diff.Balt.percent <- with(EMBaltVehicle, (totalEmission[1] - totalEmission[4])
                          /totalEmission[1]*100)
diff.Los.percent  <- with(EMLosVehicle, (totalEmission[1] - totalEmission[4])
                          /totalEmission[1]*100)
diff.percent <- data.frame(city=c("Baltimore","Los"),
                           diff.percent=c(diff.Balt.percent,diff.Los.percent))

# draw chart
message("drawing a chart...")
ggplot(diff.percent,aes( x= city, y = diff.percent)) +
  geom_bar(stat = "identity",fill="lightblue",colour = "black") +
  geom_text(aes(label = round(diff.percent,digit=0),vjust = 1.5)) +
  labs(title="Total PM2.5 emission from Vehicle comparison") +
  labs(subtitle = "Reduction percent between city from year 1999 to 2008")

# save chart to the file
ggsave(file = "plot6.png")
message("done.")