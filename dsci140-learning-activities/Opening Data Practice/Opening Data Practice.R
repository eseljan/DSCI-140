# Step 1: load libraries
install.packages("tidyverse")
library(tidyverse)
library(readxl)
library(haven)
library(readr)

# Step 2: I will share with the class a zip folder. Download the folder onto
# your computer and then UPLOAD it into your files on posit cloud.




### Collective Practice

getwd() # View working directory
setwd("/cloud/project/Misc Data") # Change working directory to Misc Data folder
library(tidyverse) # load tidyverse (make sure installed!)

load("trees513.RData") # code to load trees513.RData file


str(trees513A) # examine one of 2 objects that existed in file
summary(trees513A$species) # get summary statistics for species variable
plot(trees513A$species) # get plot of species variable

poll_data <- readRDS("poll_data.rds") # open RDS file
str(poll_data) # examine data structure

hist(poll_data$AGE) # get histogram of age variable
sd(poll_data$AGE) # retrieve standard deviation. Note, no missing data!


prop.table(table(trees513A$species))


statepop <- read_csv("state_pop_byrace.csv", col_names = c("statecode", "year", "asian", "black", "white"))
# read in csv file that had no existing variable names

mean(statepop$asian[statepop$statecode == 1])
# get mean of asian population in state 1


incumbents <- read_excel("congressional_elections.xlsx", sheet = "congress_incumbents")
# read in excel data and specify which sheet you want




# Individual Practice ---------------------------------------------------------




# Challenge 1: Stata Data -------------------------------------------------

# Some data will be in proprietary formats like .dta (Stata) or .save (SPSS)
# Create an object called state_ideology that reads the state_ideology.dta data
# in your Misc Data folder. The standard syntax for this task is objectname
# <- read_dta("filepath/file.dta")  You may use user interface to import!
# Do not worry about variable names, they will transfer over automatically.

library(haven)



# If you successfully loaded this data, your environment should show a dataset
# with 250 rows and 9 variables.


# Challenge 2: Excel Data on Sheet #2 -------------------------------------

# Excel workbooks can store data into multiple sheets. In this task you need
# to load data from the second sheet of the workbook (if you have no idea what
# I'm talking about, download the data and open it in excel).

# Create an object called split_tickets that reads the congressional_elections.xlsx
# data. The data you care about is on the 2nd sheet of this workbook. The
# first row of data has appropriate variable names. The standard syntax for this
# task is: objectname <- read_excel("filepath/file.xlsx", sheet=#)



# If you successfully loaded this data, your environment should show a dataset
# with 30 rows and 4 variables.

# Can you find the range of percentage_split with the range() function?



# Challenge 3: Character Delimited files. ---------------------------------


# Create a new data object called countycases from the data stored in
# us_counties.txt. This data is delimited with a "|".  (This data has
# variable names in the first row that does not require attention.)

# Use the read_delim() command, which takes the following standard syntax:
#   read_delim("filepath/file.txt", delim="x") where x is any character



# If you successfully loaded this data, your environment should show a dataset
# with 586302 observations and 3 variables (daily tracking).

# find a summary statistic cases in Multnomah county!



# Challenge 4: Fixed Width Data -------------------------------------------

# The jails.txt file is a big file of data with information on every jail in
# America in fixed width format. It would be time consuming to read through the
# codebook and partition every variable. Extract and load just two variables from
# this data: The state code of a jail, which appears in the data in fixed width
# locations 243-244, and the confined population at mid-year, which appears in
# the data in fixed width locations 289-293. Call these variables statecode and
# confinedpop. The object name for your new dataset should be jails.

# Note: this file lives in the same Misc Data folder as everything else, so a
# relative filename would work here too -- this example uses the full
# ("absolute") path instead, just to show you both styles work.

# Use the following standard syntax as your guide:
# read_fwf("file.txt",  fwf_positions(start = c(startposition1, startposition2),
#                                     end = c(endposition1, endposition2),
#                                     col_names = c("varname1","varname2"))



# If you were successful, you should have 911 observations.

# Loading Data on the Web -------------------------------------------------

# Instead of file paths, it is also possible to point commands that read files
# to http/https URLs. Let's test this with the read_csv command. In this
# exercise, let's also limit the columns imported to only 3 variables. This
# saves time and memory. We will employ the col_select option, identifying
# variables we want in R's standard c() format for lists.

# For Example:
# objectname <- read_csv("url", col_select=c("varname1", "varname2", "varnameetc"))

# Read this data: https://raw.githubusercontent.com/owid/covid-19-data/master/public/data/testing/covid-testing-all-observations.csv
# But only read in the variables called "ISO code", "Date", and "Short-term positive rate"




# Writing Data as rds -------------------------------------------------------


# Let's practice writing data. R has commands that will allow you to write data
# in ANY format.

# Save multiple objects of your choice as an Rdata file using this syntax:

# The standard syntax for saving Rdata files is:



# The file now exists in your Posit cloud (find it!). If you wanted to save
# the file to your harddrive, you would do this by going to More (gear icon) and
# selecting Export.

# Other options for saving this data would include
# write_delim(object, "filename.txt", delim="x")
# write_csv(object, "filename.csv")
# write_xlsx(object, "filename.xlsx")


# CHALLENGE!

# Extra time? Find data on the web. Any data! CAN YOU OPEN IT IN R?????
