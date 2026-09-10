# Run the following code to load the penguins data

install.packages("palmerpenguins")
library(palmerpenguins)
penguins <- penguins # note - this works because in the library we loaded there 
# exists something already called penguins.

# How many observations and variables are there in this data? 
# Use the str() function to answer this question.

str(penguins)

#  How many penguins are there of each species type are there in this data?
#  Use the summary() function to answer this question.  Also, use the $ operator to 
#  ONLY get summary statistics for this one variable, not the entire dataset

summary(penguins$species)


# Print the first row of data (by "print", I mean make the information appear
# in your console without creating a new object).  To do this, index by position. 
# remember the convention is [row, column].  If a row/column is not specified (left blank)
# it will return ALL rows/columns

penguins[1,] 

# Now, assign the first row of data to a new vector object called row 1.  
# The assignment operator is <-

row1<-penguins[1,] 

# prints first column of data (all rows)

penguins[,1] 

penguins$species

# Creates a new dataframe object called Gentoo that ONLY coontains the species 
# Gentoo (and still has all variables).  Instead of indexing by position, index using
# a logical statement. Don't forget to use == for "is equal to" and to put the value 
# of the variable (meaning "Gentoo") in quotation marks

gentoo<- penguins[penguins$species=="Gentoo", ] 

penguins[penguins$species=="Gentoo", ] 

gentoo<-2


# Without creating any new object, make a scatterplot of that shows bill length on
# the X axis and bill depth on the Y axis for ONLY penguins that live on the island of Biscoe
# use the plot()  function.  Each X and Y should be indexed! Because you are referencing
# variables, treat them like you are indexing a vector NOT a dataframe (this means no need 
# for a comma WITHIN your brackets)
plot(penguins$bill_depth_mm[penguins$island=="Biscoe"], 
     penguins$bill_length_mm[penguins$island=="Biscoe"])

whatisthis<-penguins$bill_depth_mm

# This code creates a new variable called nonsense that always takes on the value of "Whatever"

penguins$nonsense<-"Whatever"

# permanently remove this variable from the penguins dataset by getting rid of 
# it by referencing it's position as the 9th column.  Don't forget to employ the
# assignment operator and index both rows and columns

penguins <-penguins[,-9]

# This code creates a new variable called long_bill that is coded as 1 whenever bill length 
# is over 44 (all other observations can remain missing by default)

penguins$long_bill<-1

penguins$long_bill2[penguins$bill_length_mm>44] <- 1 

# On your own, recodes the long_bill variable using indexing so that it is now 
# coded as 0 whenever bill length <=44

penguins$long_bill2[penguins$bill_length_mm<=44] <- 0 

# use the summary command to get summary statistics for this new variable

summary(penguins$long_bill2) # summary statistics for new variable


# Last but not least, get summary statistics on bill length ONLY for Gentoo penguins

summary(penguins$bill_length_mm[penguins$species=="Gentoo"])


# Dream Only Data

Dream <- penguins[penguins$island=="Dream",]