source("loadData.R")
library(ggplot2)

# merge NEI and SCC data
message("merging two data set...")
df <- merge(NEI,SCC,by = "SCC")

# extract only "Coal-related" sources
df <- df[grepl("Coal",df$SCC.Level.Three),]

# compute sum by year
message("computing sum...")
EMCoal <- aggregate(df$Emissions,list(df$year),sum)

# explicitly add name to the columns
colnames(EMCoal) = c("year","totalEmission")

# coerce from integer to factor
EMCoal$year <- as.factor(EMCoal$year)

# draw chart
message("drawing a chart...")
ggplot(EMCoal,aes( x= year, y = totalEmission)) +
  geom_bar(stat = "identity",colour = "black") +
  geom_text(aes(label = round(totalEmission,digit=0), vjust = -0.5)) +
  labs(title="Total Coal-related PM2.5 emissions by year") +
  labs(y = "Total Emissions [tons]")

# save chart to the file
ggsave(file = "plot4.png")
message("done.")