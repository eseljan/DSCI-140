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

mean(pdxTrees_parks$Tree_Height, na.rm = TRUE)


# Question 2 -----------------------------------------------------------
# Determine the range of tree heights in the data

range(pdxTrees_parks$Tree_Height, na.rm = TRUE)


# Question 3 -----------------------------------------------------------
# Find the median tree height

median(pdxTrees_parks$Tree_Height, na.rm = TRUE)


# Question 4 -----------------------------------------------------------
# Create a histogram of tree heights using the hist() function.

hist(pdxTrees_parks$Tree_Height)


# Question 5 -----------------------------------------------------------
# Change the Condition variable to (permanently) be a factor variable
# (use as.factor())

pdxTrees_parks$Condition <- as.factor(pdxTrees_parks$Condition)


# Question 6 -----------------------------------------------------------
# Generate a bar plot showing the count of trees in each condition
# (Condition). Use the plot() function.

plot(pdxTrees_parks$Condition)


# Question 7 -----------------------------------------------------------
# Create a frequency table of the tree Condition (Condition).

table(pdxTrees_parks$Condition)


# Question 8 -----------------------------------------------------------
# Produce a proportional table of the native status (Native) of the trees
# using prop.table() on the result of table().

prop.table(table(pdxTrees_parks$Native))


# Question 9 -----------------------------------------------------------
# Plot a scatter plot of tree height (Tree_Height) against crown width
# (Crown_Width_EW). Use the plot() function.

plot(pdxTrees_parks$Tree_Height, pdxTrees_parks$Crown_Width_EW)


# Question 10 ----------------------------------------------------------
# Generate TWO two-way proportional tables, each showing Condition as
# columns and Mature_Size as rows. First calculate proportions by rows,
# then by columns. What did you learn about the relationship? What did
# you learn about how Mature_Size must be coded for dead trees?
# (Hint: use prop.table() with the margin option)

# proportions by row (within each Mature_Size, how do trees split by Condition?)
prop.table(table(pdxTrees_parks$Mature_Size, pdxTrees_parks$Condition), margin = 1)


prop.table(table(pdxTrees_parks$Mature_Size, pdxTrees_parks$Condition), margin = 2)

# Interpretation (written answer, not code):
# The row-proportions table shows 0.0000 in the Dead column for every single
# Mature_Size level (L, S, and M) -- meaning no tree with a recorded
# Mature_Size is ever classified as Dead. In other words, Mature_Size is
# NEVER coded as L/S/M for a dead tree; it is always left missing (NA)
# instead. That's also why the column-proportions table can't show a Dead
# column at all -- there's no data to compute a proportion from. Aside from
# that, the Fair/Good/Poor proportions look fairly similar to each other
# across all three Mature_Size levels -- Condition doesn't vary much by size.
