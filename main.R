library(ggplot2)
library(ggsci)


japan_data <- read.csv("homework_data.csv")

YoY_vec <- c()
for (i in 1:nrow(japan_data)) {
  if (i == 1) {
    YoY <- 0
  } else {
    YoY <- (japan_data$number_of_stores[i] - japan_data$number_of_stores[i - 1]) / japan_data$number_of_stores[i - 1]
  }
    YoY_vec <- append(YoY_vec, YoY)
}

japan_data <- cbind(
  japan_data,
  "YoY" = YoY_vec
)

print(japan_data)

number_of_stores_graph <- ggplot(japan_data) +
  geom_bar(aes(x = japan_data$year, y = japan_data$number_of_stores), stat="identity") +
  labs(x = "年", y = "店舗数（店）") +
  ggtitle("日本のコンビニエンスストアの店舗数の推移") +
  theme_bw(base_family = "HiraKakuProN-W3")

print(number_of_stores_graph)

YoY_graph <- ggplot(japan_data) +
  geom_bar(aes(x = japan_data$year, y = japan_data$YoY, fill = japan_data$YoY < 0), stat="identity") +
  labs(x = "年", y = "店舗の増加率") +
  ggtitle("日本のコンビニエンスストアの増加率 (前年比)") +
  theme_bw(base_family = "HiraKakuProN-W3")

print(YoY_graph)





#############################
library(dplyr)


number_of_stores_by_prefecture_data <- read.csv("homework_data2.csv")
population_data <- read.csv("FEI_PREF_231220223924.csv")

prefectures_data <- full_join(
  number_of_stores_by_prefecture_data,
  population_data,
  by = c("year" = "year", "prefecture" = "prefecture")
)

per_10000_population_vec <- c()
for (i in ncol(prefectures_data)) {
  per_10000_population <- (prefectures_data$number_of_stores / prefectures_data$population) * 10000
  per_10000_population_vec <- append(
    per_10000_population_vec, per_10000_population
  )
}

prefectures_data <- cbind(
  prefectures_data,
  "per_10000_population" = per_10000_population_vec
)


library(plotly)
library(magrittr)

graph <- plot_ly(
  data = prefectures_data,
  x = ~population,
  y = ~number_of_stores,
  split = ~prefecture,
  type = "scatter"
)

print(graph)

graph <- plot_ly(
  data = prefectures_data,
  x = ~population,
  y = ~number_of_stores,
  color = ~year,
  type = "scatter"
)

print(graph)

graph <- plot_ly(
  data = prefectures_data,
  x = ~population,
  y = ~year,
  z = ~number_of_stores,
  split = ~prefecture,
  type = "scatter3d"
)

print(graph)

###############################################

year_vec <- c(2012:2018)
average_per_10000_population_vec <- c()
range <- nrow(prefectures_data) %/% 47

for (i in 1:range) {
  start <- 47 * (i - 1) + 1
  end <- start + 46
  tokyo <- start + 12
  average_per_10000_population <- (sum(prefectures_data$per_10000_population[start:end]) - prefectures_data$per_10000_population[tokyo] ) / 46
  print(prefectures_data$per_10000_population[tokyo])
  average_per_10000_population_vec <- append(average_per_10000_population_vec, average_per_10000_population)
}

average_per_10000_population_data <- data.frame(
  year = year_vec,
  average_per_10000_population = average_per_10000_population_vec
)

print(average_per_10000_population_data)

print(
ggplot(
  average_per_10000_population_data,
  aes(
    x = year,
    y = average_per_10000_population
  )
) + geom_bar(
  stat = "identity"
) + labs(
  x = "year",
  y = "average per 10000 population",
) + scale_x_continuous(
  breaks = seq(2012, 2018, 1)
)

)