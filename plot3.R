NEI <- readRDS("summarySCC_PM25.rds")

# Subset Data for Baltimore
NEI_Baltimore <- subset(NEI, fips == "24510")

# Summarize Data by year and type
Agg_by_year_type <- aggregate(NEI_Baltimore[c("Emissions")], list(year = NEI_Baltimore$year, type = NEI_Baltimore$type), sum)

#  Create Plot 3
library("ggplot2")
png('plot3.png')

p <- ggplot(Agg_by_year_type, aes(x=year, y=Emissions, colour=type))
p <- p + geom_line() +
      xlab("year") +
      ylab(expression('Emissions')) +
      ggtitle('PM2.5 Emissions in Baltimore')

print(p)

dev.off()