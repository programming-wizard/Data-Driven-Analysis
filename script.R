library(plyr)
library(ggplot2)

events <- readRDS("R_events_2019.rds")

# 2. Obtaining a count (frequency) of events for each group and visualizing the top 50 groups:

groups <- count(events, 'group_name')
groups_order <- order(groups$freq, decreasing = T)
top_groups <- groups[groups_order, ]

## Visualizing

top_50_groups <- top_groups[1:50, ]

group_viz <- ggplot(top_50_groups, aes(group_name, freq)) + geom_bar(stat = "identity")

# 3. Obtaining a count (frequency) of events for each city (venue_city) and visualizing the top 50 cities:

city <- count(events, "venue_city")
city_order <- order(city$freq, decreasing = T)
top_cities <- city[city_order, ]
top_cities <- na.omit(top_cities)

## Visualizing

top_50_cities <- top_cities[1:50, ]

city_viz <- ggplot(top_50_cities, aes(venue_city, freq)) + geom_bar(stat = "identity")

# 4. Obtaining a count (frequency) of events per country and visualizing the top 20 countries:

country <- count(events, "venue_country")
country_order <- order(country$freq, decreasing = T)
top_countries <- country[country_order, ]
top_countries <- na.omit(top_countries)

## Visualizing

top_50_countries <- top_countries[1:20, ]

country_viz <- ggplot(top_50_countries, aes(venue_country, freq)) + geom_bar(stat = "identity")

# 5. Grouping the events by local_date, tabulating and visualizing the number of events per month using a bar chart:

#############################
library(dplyr)
library(lubridate)
#############################

months_count <- events %>% group_by(months=floor_date(events$local_date, "month")) %>%
  summarize(events_count=n())

## Visualization

events_viz <- ggplot(months_count, aes(months, events_count)) + geom_bar(stat = "identity")

# ALL VISUALIZATIONS:

group_viz
city_viz
country_viz
events_viz