NEI <- readRDS("summarySCC_PM25.rds")

# Summarize Data by year
Agg_by_year <- aggregate(NEI[c("Emissions")], list(year = NEI$year), sum)

#  Create Plot 1
png('plot1.png')

plot(Agg_by_year$year, Agg_by_year$Emissions/10^6, type = "l", 
     main = "Total PM2.5 Emissions in the US",
     xlab = "Year", ylab = "Emissions(10^6)")


dev.off()