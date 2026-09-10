# Run the following code to load the penguins data

install.packages("palmerpenguins")
library(palmerpenguins)
penguins <- penguins # note - this works because in the library we loaded there 
                     # exists something already called penguins.

# How many observations and variables are there in this data? 
# Use the str() function to answer this question.



#  How many penguins are there of each species type are there in this data?
#  Use the summary() function to answer this question.  Also, use the $ operator to 
#  ONLY get summary statistics for this one variable, not the entire dataset



# Print the first row of data (by "print", I mean make the information appear
# in your console without creating a new object).  To do this, index by position. 
# remember the convention is [row, column].  If a row/column is not specified (left blank)
# it will return ALL rows/columns


# Now, assign the first row of data to a new vector object called row 1.  
# The assignment operator is <-



# prints first column of data (all rows)



# Creates a new dataframe object called Gentoo that ONLY coontains the species 
# Gentoo (and still has all variables).  Instead of indexing by position, index using
# a logical statement. Don't forget to use == for "is equal to" and to put the value 
# of the variable (meaning "Gentoo") in quotation marks


# Without creating any new object, make a scatterplot of that shows bill length on
# the X axis and bill depth on the Y axis for ONLY penguins that live on the island of Biscoe
# use the plot()  function.  Note! Each X and Y should be indexed! Because you are referencing
# variables, treat them like you are indexing a vector NOT a dataframe (this means no need 
# for a comma WITHIN your brackets)



# This code creates a new variable called nonsense that always takes on the value of "Whatever"

penguins$nonsense<-"Whatever"

# permanently remove this variable from the penguins dataset by getting rid of 
# it by referencing it's position as the 9th column.  Don't forget to employ the
# assignment operator and index both rows and columns


# This code creates a new variable called long_bill that is coded as 1 whenever bill length 
# is over 44 (all other observations can remain missing by default)

penguins$long_bill[penguins$bill_length_mm>44] <- 1 

# On your own, recodes the long_bill variable using indexing so that it is now 
# coded as 0 whenever bill length <=44


# use the summary command to get summary statistics for this new variable


# Get summary statistics on bill length ONLY for Gentoo penguins


# Last but not least, create a dataframe called Dream that ONLY includes penguins from
# the island of Dream (include all columns)



