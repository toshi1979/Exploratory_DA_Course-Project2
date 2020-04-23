source("loadData.R")
library(ggplot2)

# extract group of Baltimore city
sub <- subset(NEI,NEI$fips == "24510")

# compute sum by each year and each type
EMBaltByType <- aggregate(sub$Emissions,list(sub$type,sub$year),sum)

# explicitly add name to the columns
colnames(EMBaltByType) = c("type","year","totalEmission")

# coerce from integer to factor
EMBaltByType$year <- as.factor(EMBaltByType$year)

# draw chart
ggplot(EMBaltByType,aes( x= year, y = totalEmission, fill= type)) +
          geom_bar(stat = "identity",colour = "black") +
          labs(title="Total PM2.5 emissions in Baltimore city split by type") +
          labs(y = "Total Emissions [tons]")

# save chart to the file
ggsave(file = "plot3.png")