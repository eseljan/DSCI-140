# ---- Setup ----

# install.packages() downloads a package to your computer.
# You only need to do this ONCE per computer, not every time you run the script.
install.packages("tidyverse")
install.packages("palmerpenguins")

# library() loads a package for this session. You do this EVERY time you open R.
library(tidyverse)        # dplyr, ggplot2, and friends
library(palmerpenguins)   # the penguins dataset

# The dataset lives inside the package. This copies it into your Environment
# pane so you can see it and click on it.
penguins <- penguins


# ---- Choosing and reordering columns ----

# |> is the pipe. Read it as "and then."
# "Take penguins, and then select..."

# select() picks COLUMNS. contains("gth") keeps every column whose name
# includes "gth": bill_length_mm and flipper_length_mm.
penguins |>
  select(contains("gth"))

# relocate() moves a column to the front without dropping the others.
# slice_head(n = 8) keeps the first 8 rows.
penguins |>
  relocate(bill_length_mm) |>
  slice_head(n = 8)

# arrange() sorts ROWS. By default it sorts smallest to largest;
# desc() flips it to largest first. Result: the 10 longest bills.
penguins |>
  arrange(desc(bill_length_mm)) |>
  slice_head(n = 10)


# ---- Looking at the data ----


View(penguins)      # opens the data as a spreadsheet tab (capital V!)
summary(penguins)   # quick summary of every column, including counts of NAs


# ---- Filtering rows ----

# filter() keeps ROWS that meet a condition.
# is.na(sex) is TRUE when sex is missing, so this keeps only those rows.
# Because we use <-, the result is saved as a new object.
missingpenguins <- penguins |>
  filter(is.na(sex))

View(missingpenguins)

# ! means "not." This keeps rows where sex is NOT missing.
# Careful: we are saving over penguins, so the original rows are gone
# from our copy.
penguins <- penguins |>
  filter(!is.na(sex))

# Use == (two equals signs) to test whether something is equal.
# One = would try to assign a value. Text needs quotes and exact capitalization.
female <- penguins |>
  filter(sex == "female")
View(female)

# $ pulls one column out of a data frame.
# species is a factor (categories), so summary() counts each category.
summary(penguins$species)

# | means "or." Keep penguins that are Chinstrap OR Gentoo.
chin_gen <- penguins |>
  filter(species == "Chinstrap" | species == "Gentoo")

# != means "not equal to." Same result as above, written a different way.
chin_gen2 <- penguins |>
  filter(species != "Adelie")


# ---- Sorting and Distinct() ----

# No <- here, so R just PRINTS the result. The female object is unchanged.
# head() shows the first 6 rows: the six heaviest females.
female |>
  arrange(desc(body_mass_g)) |>
  head()

# With <-, the sorted version replaces the old female.
female <- female |>
  arrange(desc(body_mass_g))
View(female)

# distinct() returns each unique combination that appears in the data,
# here every species-year pair.
penguins |>
  distinct(species, year)


# ---- Calculations within groups ----

# group_by() tells R to do what follows separately for each species.
# mutate() adds a new COLUMN and keeps all the rows.
#   max_weight      = heaviest penguin of that species
#                     (na.rm = TRUE ignores missing values)
#   relative_weight = each penguin's weight as a share of its species' max
max <- penguins |>
  group_by(species) |>
  mutate(max_weight = max(body_mass_g, na.rm = TRUE)) |>
  mutate(relative_weight = body_mass_g / max_weight)