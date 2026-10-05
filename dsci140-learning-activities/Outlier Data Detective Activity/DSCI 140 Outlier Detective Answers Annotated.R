# =============================================================================
# DSCI 140 - Outlier Detective: Annotated Answers
# Investigating outliers in price and lotsize (Portland-area home sales)
# =============================================================================

library(tidyverse)

# pdx_housing is already loaded in the Posit Cloud project

# -----------------------------------------------------------------------------
# PART 1: price
# -----------------------------------------------------------------------------
summary(pdx_housing$price)
#     Min.  1st Qu.   Median     Mean  3rd Qu.     Max.
#      500   408000   528000   593023   670000 25500000

# -----------------------------------------------------------------------------
# Look before you calculate: hist(), plot(), and boxplot()
# -----------------------------------------------------------------------------
hist(pdx_housing$price)
# USELESS here, and worth knowing why: hist() picks bin widths to span the
# full range of the data, min to max. Because one value (25.5 million) is so
# much larger than everything else, the bins stretch out to cover that whole
# range, and all 20,662 other prices -- which only go up to a few million --
# get crushed into a single bar at the far left. You can't even tell there's
# an outlier at all from this plot, let alone how many or how extreme.

plot(pdx_housing$price)
# MUCH better. This plots each price against its row number, and the $25.5M
# point is immediately visible as a single dot floating far above the rest.
# A plain scatter survives a single extreme value in a way a histogram does
# not, because one point just becomes one dot, not a bin boundary.

boxplot(pdx_housing$price)
# This is not a third, different method -- a boxplot's whiskers are drawn at
# exactly 1.5*IQR, the SAME rule we calculate by hand below. The single most
# extreme point appears at the very top, and you can also see a whole
# cluster of smaller points flagged just above the upper whisker -- a visual
# preview of the ~1,337 rows the IQR calculation is about to flag.
#
# Takeaway: plot() and boxplot() are good for an initial "something looks
# off" gut check. hist() is not, when one value dominates the range. None of
# the three tell you exactly where to draw the line or how many rows are
# affected -- for that you still need the actual numbers below.

q1 <- quantile(pdx_housing$price, 0.25, na.rm = TRUE)
q3 <- quantile(pdx_housing$price, 0.75, na.rm = TRUE)
iqr <- q3 - q1
lower_bound <- q1 - 1.5 * iqr
upper_bound <- q3 + 1.5 * iqr
# q1 = 408000, q3 = 670000, iqr = 262000
# lower_bound = 46500, upper_bound = 1066500

pdx_housing |>
  filter(price < lower_bound | price > upper_bound) |>
  nrow()
# 1,337 of 20,663 rows flagged (about 6.5%)

# That's a LOT of flagged rows -- far too many to investigate one at a time.
# Real estate prices are naturally right-skewed (lots of normal homes, a
# long tail of expensive ones), so the IQR rule will flag plenty of homes
# that are expensive but completely real. The useful move is to sort by
# price and look closely at just the most extreme handful.

pdx_housing |>
  arrange(desc(price)) |>
  select(address, city, price, bedrooms, bathrooms, lotsize, hometype, yearbuilt) |>
  head(5)
#   address                     city         price    bed bath   lotsize hometype      yearbuilt
#   3729 NE Columbia Blvd       Portland  25,500,000    3    1    217800 SINGLE_FAMILY      1942
#   24152 SW Petes Mountain Rd  West Linn  6,300,000    6   10    291416 SINGLE_FAMILY      1995
#   5335 SW Patton Rd           Portland   5,750,000    4    7    148104 SINGLE_FAMILY      1971
#   1190 Fairway Rd             Lake Oswego 5,250,000    4    6     98010 SINGLE_FAMILY      1995
#   1193 Fairway Rd             Lake Oswego 4,750,000    5    6     52272 SINGLE_FAMILY      2001

# The #1 row is almost certainly an ERROR: a 3-bedroom, 1-bathroom house
# built in 1942, priced at $25.5 million, is simply not plausible -- a home
# with that bedroom/bathroom count doesn't match a $25M price tag anywhere,
# even in Portland's priciest neighborhoods. (Columbia Blvd is also an
# industrial/commercial corridor near the airport, not a luxury residential
# area, which is another red flag.) This looks like a data entry or
# scraping error -- possibly a misplaced decimal or a mismatched price field.
#
# By contrast, rows #2-5 are all internally consistent with being GENUINE
# luxury homes: West Linn and Lake Oswego are legitimately Portland's
# wealthiest suburbs, and each of these properties has a bedroom/bathroom
# count and lot size that make sense for a multi-million-dollar estate
# (6 bed/10 bath, 4 bed/7 bath, etc.). These are rare, but real -- exactly
# the "Giant Sequoia" lesson from the pdxTrees example in lecture: don't
# assume every extreme value is a mistake.

pdx_housing |>
  arrange(price) |>
  select(address, city, price, bedrooms, bathrooms, hometype, daysonzillow) |>
  head(5)
#   address                city       price bed bath hometype       daysonzillow
#   Levy Code 113          Portland     500   NA   NA SINGLE_FAMILY          350
#   20395 SW Pike St       Aloha       1200    3    1 SINGLE_FAMILY          137
#   7850 SE Sporri Ln      Portland    2500    3    3 CONDO                   99
#   16605 SW Daylily St    Sherwood    3400    3    2.5 SINGLE_FAMILY          32
#   SW Garden Home Rd      Portland    5510   NA   NA SINGLE_FAMILY          145

# The low end tells a different, messier story. "Levy Code 113" and "SW
# Garden Home Rd" (no house number) don't look like normal property
# addresses at all -- these are likely tax or assessment records, not real
# arms-length home sales, that got swept into this dataset by the scraper.
# The others (a 3-bed/1-bath house for $1,200, a condo for $2,500) are not
# physically impossible the way the $25.5M listing was, but a real home
# selling for a few thousand dollars in the Portland area is extremely
# unlikely -- more plausible explanations include a $1 family transfer, a
# foreclosure auction starting bid, or another non-market transaction type
# that shouldn't be compared to ordinary home sales at all. Unlike the
# $25.5M case, this isn't as clear-cut -- it's a case where you'd want to
# know more about what "price" actually captures in this scraped data
# before deciding how to treat these rows.

# -----------------------------------------------------------------------------
# PART 2: lotsize
# -----------------------------------------------------------------------------
summary(pdx_housing$lotsize)
#      Min.   1st Qu.    Median      Mean   3rd Qu.      Max.
#         0      4791      6969     27049     10018 208722096

hist(pdx_housing$lotsize)
plot(pdx_housing$lotsize)
boxplot(pdx_housing$lotsize)
# Same story, even more extreme: 208,722,096 is roughly 1,000x a typical
# lot, so hist() is completely unreadable -- a single bar at zero, nothing
# else visible. plot() again shows the one point clearly, floating far
# above everything else. boxplot() shows that same point at the top, plus
# a dense cluster of smaller flagged points near the upper whisker.

q1l <- quantile(pdx_housing$lotsize, 0.25, na.rm = TRUE)
q3l <- quantile(pdx_housing$lotsize, 0.75, na.rm = TRUE)
iqrl <- q3l - q1l
lower_bound_l <- q1l - 1.5 * iqrl
upper_bound_l <- q3l + 1.5 * iqrl
# q1 = 4791, q3 = 10018, iqr = 5227
# upper_bound = 17858.5 (lower_bound is negative, so only the upper bound matters)

pdx_housing |>
  filter(lotsize > upper_bound_l) |>
  nrow()
# 1,876 of 20,663 rows flagged (about 9%) -- again, too many to check by hand.
# Sort and look at the extremes instead:

pdx_housing |>
  arrange(desc(lotsize)) |>
  select(address, city, price, bedrooms, bathrooms, lotsize, hometype) |>
  head(5)
#   address                      city          price bed bath   lotsize      hometype
#   5844 NE 32nd Pl              Portland     584995   3    2 208722096 SINGLE_FAMILY
#   14166 SW Barrows Rd UNIT 2   Tigard       319000   2    3  18992160 TOWNHOUSE
#   2330 SW 325th Ave            Hillsboro   1500000   3    1   3693888 SINGLE_FAMILY
#   Side Seidl Rd                Troutdale     50000   NA   NA  3471732 SINGLE_FAMILY
#   20100 S Meyers Rd            Oregon City 1050000   2    3   3131528 SINGLE_FAMILY

# 208,722,096 square feet is about 4,792 ACRES. An ordinary 3-bed/2-bath home
# priced at $584,995 does not sit on a lot the size of a small county --
# this is almost certainly a unit or data-entry error (square feet entered
# where a different unit, or a different field entirely, was intended).
#
# Row #2 is similarly implausible: a TOWNHOUSE (by definition a small,
# shared-wall unit) on 436 acres makes no physical sense -- also an error.
#
# Row #3 is a more interesting case: an 85-acre lot (3,693,888 sq ft) under
# a $1.5 million property in Hillsboro. This is NOT obviously an error --
# large rural and exurban properties with genuinely large acreage do exist
# on the fringes of the Portland metro, and a $1.5M price is plausible for
# a substantial piece of land. This is a good example of a case you can't
# resolve just by looking at the number itself -- it depends on whether the
# price and hometype are consistent with the lot size, which they are here.

# -----------------------------------------------------------------------------
# EXTRA TASK 1: treat the confirmed errors and recompute the mean
# -----------------------------------------------------------------------------
# Based on the investigation above, the clearest, most defensible error to
# fix is the $25.5M listing (price) and the 208-million-sq-ft lot (lotsize).
# We'll remove just those two confirmed errors, not the broader set of
# merely-expensive-but-real homes.

pdx_housing_cleaned <- pdx_housing |>
  filter(price != 25500000, lotsize != 208722096)

mean(pdx_housing$price, na.rm = TRUE)          # 612061.1 (with the error included)
mean(pdx_housing_cleaned$price, na.rm = TRUE)  # 610857.9 (one row removed)
# Barely moves -- about a 0.2% change. Even a single $25.5M error gets
# diluted across 20,663 rows, especially since several other GENUINE
# multi-million-dollar sales are already in the data (the error is only
# about 4x the next-highest real price).

mean(pdx_housing$lotsize, na.rm = TRUE)          # 27049.3 (with the error included)
mean(pdx_housing_cleaned$lotsize, na.rm = TRUE)  # 16939.2 (one row removed)
# This one moves A LOT -- about a 37% drop from removing a single row.
# The lotsize error (208,722,096) isn't just large, it's roughly 1,000x
# bigger than a typical lot, versus the price error which was only about
# 4-8x bigger than other genuinely expensive homes. One row can dominate a
# mean when it's off by orders of magnitude, even in a large dataset.
#
# Compare both of these to the pdxTrees example from lecture, where
# removing 160 genuine outliers barely moved the mean DBH at all. The
# lesson here is more specific than "outliers barely matter" or "outliers
# always matter" -- it depends on HOW extreme a given value is relative to
# the rest of its own variable's distribution, not just on how many values
# you're removing.

# -----------------------------------------------------------------------------
# EXTRA TASK 2: try the IQR approach on a third variable
# -----------------------------------------------------------------------------
summary(pdx_housing$bathrooms)
pdx_housing |> arrange(desc(bathrooms)) |> select(address, city, price, bedrooms, bathrooms) |> head(5)
#   address                     city        price   bed bath
#   24152 SW Petes Mountain Rd  West Linn 6300000     6   10
#   1503 NE Schuyler St         Portland  1419000     8   10
#   2425 S Military Rd          Portland  3705000     5   10
#   14698 SE Loren Ln           Milwaukie  890000    10   10
#   19230 Bryant Rd             Lake Oswego 975000     8    9

# The highest value here (10 bathrooms) is worth noting alongside price:
# the #1 row is the SAME property that showed up as our #2 highest price
# earlier (24152 SW Petes Mountain Rd, West Linn). That consistency is
# reassuring -- a 6-bed/10-bath estate priced at $6.3M is internally
# coherent, reinforcing that this is a genuine luxury property, not an
# error, from a second angle.

summary(pdx_housing$yearbuilt)
table(pdx_housing$yearbuilt == 0)
# FALSE  TRUE
# 20275    10

# 10 properties are listed as built in year "0" -- this isn't really an
# "outlier" in the statistical sense (an oddly LOW but real value); it's a
# disguised MISSING value, similar to the -99 and 99 codes you saw in
# earlier missing data activities. Worth noting the difference: an outlier
# is a genuinely extreme but real value, while year = 0 is a sentinel code
# standing in for "we don't know." They can look similar in a summary()
# table (both show up as an extreme min/max), but they call for different
# fixes -- one is a case for na_if(), not for outlier treatment.
