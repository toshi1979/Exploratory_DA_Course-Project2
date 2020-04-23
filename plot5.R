source("loadData.R")
library(ggplot2)

# extract group of Baltimore city
sub <- subset(NEI,NEI$fips == "24510")

# merge NEI and SCC data
message("merging two data set...")
df <- merge(sub,SCC,by = "SCC")

# extract only vehicle sources
df <- df[grepl("Vehicle",df$SCC.Level.Two),]

# compute sum by each year and each type
message("computing sum...")
EMBaltVehicle <- aggregate(df$Emissions,list(df$year),sum)

# explicitly add name to the columns
colnames(EMBaltVehicle) = c("year","totalEmission")

# coerce from integer to factor
EMBaltVehicle$year <- as.factor(EMBaltVehicle$year)

# draw chart
message("drawing a chart...")
ggplot(EMBaltVehicle,aes( x= year, y = totalEmission)) +
  geom_bar(stat = "identity",colour = "black") +
  geom_text(aes(label = round(totalEmission,digit=0), vjust = -0.5)) +
  labs(title="Total PM2.5 emissions from Vehicle in Baltimore city by year") +
  labs(y = "Total Emissions [tons]")

# save chart to the file
ggsave(file = "plot5.png")
message("done.")