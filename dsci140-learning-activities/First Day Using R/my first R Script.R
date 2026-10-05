# Anything that starts with a # is a comment!!! It does not "run" in R.

# The arrow <- means "store this." Read it as "order gets..."
# c() combines values into one object, called a vector.
# This makes a vector of three numbers and names it "order".
order <- c(1, 2, 3)

# Vectors can hold text too. Text always goes in quotation marks.
# R calls text "character" data.
animal <- c("cat", "dog", "fish")

# This line gives an ERROR, on purpose.
# You can't do math on text, so R says:
#   "non-numeric argument to binary operator"
# Errors are normal. Read the message; it usually tells you what went wrong.
animal + 3

# Each item in quotes counts as ONE element, even if it has several words.
# This vector has 2 elements, not 6.
randomwords <- c("hello there", "nice to meet you")

# str() shows the STRucture of an object: its type and what's in it.
# Output:  chr [1:3] "cat" "dog" "fish"
# "chr" = character (text), "[1:3]" = three elements.
str(animal)

# mean() calculates the average. It works here because order holds numbers.
# Output:  [1] 2
mean(order)

# nchar() counts the Number of CHARacters in each element.
# Output:  [1] 3 3 4    (cat = 3, dog = 3, fish = 4)
nchar(animal)