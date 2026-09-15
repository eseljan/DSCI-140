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

# Create an object called state_ideology that reads the state_ideology.dta
# data in your Misc Data folder.
# Syntax: objectname <- read_dta("filepath/file.dta")



str(state_ideology)  # confirm: 250 obs. of 9 variables


# Challenge 2: Excel Data on Sheet #2 --------------------------------------

# Before importing, take a look at congressional_elections.xlsx in Excel
# so you can see there are multiple sheets.

# Create an object called split_tickets that reads the 2nd sheet of
# congressional_elections.xlsx. First row has variable names.
# Syntax: objectname <- read_excel("filepath/file.xlsx", sheet = "sheetname")



str(split_tickets)  # confirm: 30 obs. of 4 variables


# Challenge 3: Character-Delimited File ------------------------------------

# Before importing, open us_counties.txt in a plain text editor (not Excel)
# to see how it's delimited.

# Create a new object called countycases from us_counties.txt, which is
# delimited with "|". Variable names are already in the first row.
# Syntax: read_delim("filepath/file.txt", delim = "x")



str(countycases)  # confirm: 586302 obs. of 3 variables


# Challenge 4: Nested JSON Data ---------------------------------------------

# Before importing, open state_governors.json in a plain text editor to
# see its structure: each state has a nested list of governors.

# Create a new object called gov_data that reads state_governors.json.
# Syntax: objectname <- fromJSON("filepath/file.json")



str(gov_data)  # confirm: 5 obs. of 3 variables -- but "governor_list" will
# show up as a LIST column, not a normal one. That's your cue to unnest.

# Now unnest the governor_list column so each governor gets its own row.
# Syntax: new_object <- unnest(old_object, column_to_unnest)



str(governors_long)  # confirm: 10 obs. of 5 variables