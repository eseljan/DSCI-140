# Step 1: load libraries
install.packages("tidyverse")   # run once, then you can comment this out
library(tidyverse)
library(readxl)
library(haven)
library(readr)
library(jsonlite)

# Step 2: Download the zip folder I'll share and upload it into your files
# on posit cloud.


### Collective Practice (instructor-led — code is given, just run it)

getwd()
setwd("/cloud/project/Misc Data")
library(tidyverse)

load("trees513.RData")
str(trees513A)  # confirm: should show a data frame with the species variable


# RDS file
poll_data <- readRDS("poll_data.rds")
str(poll_data)
hist(poll_data$AGE)
sd(poll_data$AGE)


# Fixed-width file
jails <- read_fwf("jails.txt",
                  fwf_positions(start = c(243, 289),
                                end = c(244, 293),
                                col_names = c("statecode", "confinedpop")))

str(jails)  # confirm: 911 obs. of 2 variables


# Web-hosted CSV
covid_test <- read_csv(
  "https://raw.githubusercontent.com/owid/covid-19-data/master/public/data/testing/covid-testing-all-observations.csv",
  col_select = c("ISO code", "Date", "Short-term positive rate"))

str(covid_test)


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

str(gov_data)  # confirm: 10 obs. of 3 variables, with "governor_list" as a
# LIST column -- that's your cue to unnest.

governors_long <- unnest(gov_data, governor_list)

str(governors_long)  # confirm: 30 obs. of 5 variables