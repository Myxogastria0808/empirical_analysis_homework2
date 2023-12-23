library(ggplot2)
library(ggsci)


# japan_data <- read.csv("homework_data.csv")

# YoY_vec <- c()
# for (i in 1:nrow(japan_data)) {
#   if (i == 1) {
#     YoY <- 0
#   } else {
#     YoY <- (japan_data$number_of_stores[i] - japan_data$number_of_stores[i - 1]) / japan_data$number_of_stores[i - 1]
#   }
#     YoY_vec <- append(YoY_vec, YoY)
# }

# japan_data <- cbind(
#   japan_data,
#   "YoY" = YoY_vec
# )

# print(japan_data)

# number_of_stores_graph <- ggplot(japan_data) +
#   geom_bar(aes(x = japan_data$year, y = japan_data$number_of_stores), stat="identity") +
#   labs(x = "年", y = "店舗数（店）") + 
#   ggtitle("日本のコンビニエンスストアの店舗数の推移") +
#   theme_bw(base_family = "HiraKakuProN-W3")

# print(number_of_stores_graph)

# YoY_graph <- ggplot(japan_data) +
#   geom_bar(aes(x = japan_data$year, y = japan_data$YoY, fill = japan_data$YoY < 0), stat="identity") +
#   labs(x = "年", y = "店舗の増加率") + 
#   ggtitle("日本のコンビニエンスストアの増加率 (前年比)") +
#   theme_bw(base_family = "HiraKakuProN-W3")

# print(YoY_graph)





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

# print("===============")
# print(data)

# average_per_person_vec <- c()
# range <- nrow(data) %/% 47
# for (i in 1:range) {
#   start <- 47 * (i - 1) + 1
#   end <- start + 46
#   average_per_person <- sum(data$per_person[start:end]) / 47
#   average_per_person_vec <- append(average_per_person_vec, average_per_person)
# }

# print(average_per_person_vec)

# print("summary")

# print(summary(data))

# print(barplot(average_per_person_vec))

# #各都道府県