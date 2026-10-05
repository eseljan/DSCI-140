# Exercise: Exploring Tree Data in R
#
# Objective: Utilize basic R functions to analyze and visualize tree data from
# the pdxTrees_parks dataset. Functions include mean(), range(), median(),
# hist(), plot(), table(), and prop.table().
#
# Dataset Description: The dataset contains information on various trees
# within Portland public parks, including details like tree height, park
# location, and species common name.

# Load the data with this code:
install.packages("pdxTrees")
library(pdxTrees)
pdxTrees_parks <- get_pdxTrees_parks()


# Question 1 -----------------------------------------------------------
# Calculate the mean tree height (Tree_Height)



# Question 2 -----------------------------------------------------------
# Determine the range of tree heights in the data



# Question 3 -----------------------------------------------------------
# Find the median tree height



# Question 4 -----------------------------------------------------------
# Create a histogram of tree heights. Use hist()



# Question 5 -----------------------------------------------------------
# Change the Condition variable to (permanently) be a factor variable
# (use as.factor())



# Question 6 -----------------------------------------------------------
# Generate a bar plot showing the count of trees in each condition
# (Condition). Use the plot() function.



# Question 7 -----------------------------------------------------------
# Create a frequency table of the tree Condition (Condition).



# Question 8 -----------------------------------------------------------
# Produce a proportional table of the native status (Native) of the trees
# using prop.table() on the result of table().



# Question 9 -----------------------------------------------------------
# Plot a scatter plot of tree height (Tree_Height) against crown width
# (Crown_Width_EW). Use the plot() function.



# Question 10 ----------------------------------------------------------
# Generate TWO two-way proportional tables, each showing Condition as
# columns and Mature_Size as rows. First calculate proportions by rows,
# then by columns. What did you learn about the relationship? What did
# you learn about how Mature_Size must be coded for dead trees?
# (Hint: use prop.table() with the margin option)

# proportions by row:


# proportions by column:


# Interpretation (write your answer as a comment below):

