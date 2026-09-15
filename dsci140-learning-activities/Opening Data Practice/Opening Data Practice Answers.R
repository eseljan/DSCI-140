# Step 1: load libraries
install.packages("tidyverse")   # run once, then you can comment this out
library(tidyverse)
library(readxl)
library(haven)
library(readr)
library(jsonlite)

# Step 2: Download the zip folder I'll share and upload it into your files
# on posit cloud.


### Collective Practice (instructor-led)

getwd()
setwd("/cloud/project/Misc Data")
library(tidyverse)

load("trees513.RData")
str(trees513A)  # confirm: should show a data frame with the species variable


### Individual Practice ---------------------------------------------------

# Challenge 1: Stata Data -------------------------------------------------

state_ideology <- read_dta("state_ideology.dta")

str(state_ideology)  # confirm: 250 obs. of 9 variables


# Challenge 2: Excel Data on Sheet #2 --------------------------------------

split_tickets <- read_excel("congressional_elections.xlsx",
                            sheet = "congress_split_tickets")

str(split_tickets)  # confirm: 30 obs. of 4 variables


# Challenge 3: Character-Delimited File ------------------------------------

countycases <- read_delim("us_counties.txt", delim = "|")

str(countycases)  # confirm: 586302 obs. of 3 variables


# Challenge 4: Nested JSON Data ---------------------------------------------

gov_data <- fromJSON("state_governors.json")

str(gov_data)  # confirm: 5 obs. of 3 variables, with "governor_list" as a
# LIST column -- that's your cue to unnest.

governors_long <- unnest(gov_data, governor_list)

str(governors_long)  # confirm: 10 obs. of 5 variables