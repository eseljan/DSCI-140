setwd("/cloud/project/Starbucks Data")
install.packages("tidverse")
library(tidverse)

sb <- read_csv("starbucks_26FA_practice.csv")
slice_head(sb)
str(sb)
summary(sb)
summary(sb$Calories)

table(sb$Beverage_category)
prop.table(table(sb$Beverage_category))

nrow(sd)

sb <- distinct(sb)

sb$`Caffeine (mg)` <- as.numeric(sb$`Caffeine (mg)`)


sb <- sb |>
  mutate(`Caffeine (mg)`=as.numeric(`Caffeine (mg)`))

sb <- sb |>
  rename(fat=`Total Fat (g)`,
         sodium=`Sodium (mg)`,
         sugar=`Sugars (g)`,
         proteign=`Protein (g)`,
         caffeine=`Caffeine (mg)`)


sb |> 
  slice_min(caffeine)

hist(sb$Calories)

sb <- sb |>
  mutate(high_cal_drink=if_else(Calories>mean(Calories, na.rm=TRUE), "High", "Low"))

high_cal_data <- filter(sb, high_cal_drink=="High")
high_cal_data <- sb[sb$high_cal_drink=="High", ]



sb <- sb |>
  mutate(caffeine_cat=case_when(caffeine==0 ~ "None",
                                caffeine<80 ~ "Low",
                                caffeine<200 ~ "Medium",
                                is.na(caffeine) ~ "Missing",
                                TRUE ~ "High"))
