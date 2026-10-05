# ============================================================
# Starbucks Beverage Data — Exploratory Analysis
# ============================================================

# Set the working directory to the folder containing the data file
setwd("/cloud/project/Starbucks Data")

# Install the tidyverse package (collection of data science packages:
# dplyr, ggplot2, readr, etc.)
# NOTE: fixed typo — original had "tidverse", should be "tidyverse"
install.packages("tidyverse")

# Load the tidyverse package into the session so its functions are available
library(tidyverse)

# --------------------------------------------------------------
# Load and inspect the data
# --------------------------------------------------------------

# Read in the Starbucks CSV file as a data frame/tibble
sb <- read_csv("starbucks_26FA_practice.csv")

# Preview the first few rows of the dataset
slice_head(sb)

# Show the structure of the dataset: column names, types, sample values
str(sb)

# Summary statistics (min, max, mean, quartiles, NAs) for every column
summary(sb)

# Summary statistics for just the Calories column
summary(sb$Calories)

# --------------------------------------------------------------
# Explore the Beverage_category column
# --------------------------------------------------------------

# Frequency count of each beverage category
table(sb$Beverage_category)

# Same frequency count, but converted to proportions (relative frequencies)
prop.table(table(sb$Beverage_category))

# NOTE: "sd" doesn't exist — this should reference the sb data frame.
# Fixed typo: sd -> sb
nrow(sb)

# --------------------------------------------------------------
# Clean the data
# --------------------------------------------------------------

# Remove duplicate rows, keeping only distinct/unique observations
sb <- distinct(sb)

# Convert the Caffeine (mg) column to numeric
# (it may have been read in as character/text due to formatting issues)
sb$`Caffeine (mg)` <- as.numeric(sb$`Caffeine (mg)`)

# Equivalent conversion using tidyverse (dplyr) syntax with the pipe operator
# (this line re-does the same conversion as above, just using mutate())
sb <- sb |>
  mutate(`Caffeine (mg)` = as.numeric(`Caffeine (mg)`))

# Rename columns to simpler, more consistent lowercase names
# NOTE: fixed typo — original had "proteign", should be "protein"
sb <- sb |>
  rename(fat = `Total Fat (g)`,
         sodium = `Sodium (mg)`,
         sugar = `Sugars (g)`,
         protein = `Protein (g)`,
         caffeine = `Caffeine (mg)`)

# --------------------------------------------------------------
# Explore caffeine content
# --------------------------------------------------------------

# Find the row(s) with the minimum caffeine value
sb |>
  slice_min(caffeine)

# Plot a histogram of the Calories column to see its distribution
hist(sb$Calories)

# --------------------------------------------------------------
# Create derived variables
# --------------------------------------------------------------

# Create a new column classifying each drink as "High" or "Low" calorie,
# based on whether it's above or below the average Calories value
# (na.rm = TRUE ensures missing values don't break the mean calculation)
sb <- sb |>
  mutate(high_cal_drink = if_else(Calories > mean(Calories, na.rm = TRUE),
                                   "High", "Low"))

# Two equivalent ways to subset only the high-calorie drinks:

# 1. Using dplyr's filter() function
high_cal_data <- filter(sb, high_cal_drink == "High")

# 2. Using base R's bracket/indexing syntax
high_cal_data <- sb[sb$high_cal_drink == "High", ]

# Create a categorical caffeine variable with four levels:
# "None" (0 mg), "Low" (<80 mg), "Medium" (<200 mg),
# "Missing" (NA values), and "High" (everything else, i.e. >=200 mg)
sb <- sb |>
  mutate(caffeine_cat = case_when(
    caffeine == 0 ~ "None",
    caffeine < 80 ~ "Low",
    caffeine < 200 ~ "Medium",
    is.na(caffeine) ~ "Missing",
    TRUE ~ "High"
  ))
