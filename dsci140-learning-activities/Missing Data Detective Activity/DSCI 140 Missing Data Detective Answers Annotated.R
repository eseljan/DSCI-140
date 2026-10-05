# =============================================================================
# DSCI 140 - Missing Data Detective: Annotated Answers
# Investigating missingness in intelligence and ideology_placement (ANES 2016)
# =============================================================================

library(naniar)
library(tidyverse)

# anes is already loaded in the Posit Cloud project

# -----------------------------------------------------------------------------
# PART 1: intelligence
# -----------------------------------------------------------------------------
# intelligence is "apparent intelligence as determined by the survey
# interviewer." Start with the basics: how much is missing, and what does
# the non-missing data look like?

anes |> select(intelligence) |> miss_var_summary()
#   variable     n_miss pct_miss
#   intelligence   3167     74.2

table(anes$intelligence, useNA = "always")
#    1    2    3    4    5 <NA>
#  319  371  372   37    4 3167

# 74% missing is enormous -- far too much to be a few people skipping a
# question. That scale of missingness is a clue that something structural
# is going on, not random nonresponse.

# Re-read the sample description linked in the activity: ANES 2016 used TWO
# interview modes, face-to-face (with a live interviewer) and self-administered
# web. Since "intelligence" can only be rated by a human interviewer who is
# actually in the room, it should be IMPOSSIBLE for web respondents to have a
# value here -- not just unlikely, impossible by design.

vis_miss(anes |> select(intelligence))
# The near-total, clean band of missingness in this one column (rather than
# missingness scattered unevenly throughout) is consistent with a single
# structural cause rather than individual respondents randomly skipping it.

# CONCLUSION: intelligence's ~1,103 non-missing respondents are almost
# certainly every face-to-face respondent in the sample (the published ANES
# 2016 face-to-face sample size is ~1,181, very close to what we see here),
# while every web respondent is missing. If "interview mode" were a variable
# in our data, this would be a clean case of MAR (Missing At Random): the
# missingness is fully explained by an OBSERVED variable, just not one we
# happen to have access to in this trimmed dataset. Since mode isn't in our
# data, a student looking only at what's available here could reasonably
# call this MNAR instead -- a good example of how the "right" classification
# can depend on what variables you actually have, not just on the true
# underlying mechanism.

# -----------------------------------------------------------------------------
# PART 2: ideology_placement
# -----------------------------------------------------------------------------
anes |> select(ideology_placement) |> miss_var_summary()
#   variable           n_miss pct_miss
#   ideology_placement    967     22.6

# 22.6% missing is much more modest than intelligence, and does not look like
# a clean structural split. Let's look for patterns using group_by(), the
# same pattern modeled in the activity instructions.

anes |>
  select(ideology_placement, party_id) |>
  group_by(party_id) |>
  miss_var_summary()

# Turning this into percent-missing by party_id tells a clear story:
anes |>
  group_by(party_id) |>
  summarize(pct_missing_ideology = mean(is.na(ideology_placement)) * 100)
#   party_id                        pct_missing_ideology
#   1. Strong Democrat                             24.5
#   2. Not very strong Democrat                    29.9
#   3. Independent-Democrat                        17.8
#   4. Independent                                 39.7
#   5. Independent-Republican                      14.4
#   6. Not very strong Republican                  19.3
#   7. Strong Republican                           10.7

gg_miss_var(anes |> select(ideology_placement, party_id),
            facet = party_id, show_pct = TRUE)

# CONCLUSION: missingness in ideology_placement ranges from 10.7% among
# Strong Republicans up to 39.7% among Independents -- a real, substantial,
# and intuitive pattern. People without a strong partisan identity are less
# likely to have a well-formed ideological self-placement to report. Since
# this missingness is explained by an OBSERVED variable (party_id), this is
# a clean example of MAR.

# -----------------------------------------------------------------------------
# A useful check: does survey mode (our best guess for intelligence's
# missingness) ALSO explain ideology_placement's missingness? It's worth
# checking rather than assuming the same explanation applies to both.
# -----------------------------------------------------------------------------
anes |>
  mutate(mode_proxy = if_else(is.na(intelligence), "Web (no interviewer)", "Face-to-face")) |>
  group_by(mode_proxy) |>
  summarize(pct_missing_ideology = mean(is.na(ideology_placement)) * 100)
#   mode_proxy             pct_missing_ideology
#   Face-to-face                           22.6
#   Web (no interviewer)                   22.7

# These two numbers are essentially identical. Mode explains almost ALL of
# intelligence's missingness, but explains NONE of ideology_placement's.
# This is the main lesson of the activity: don't assume one explanation
# applies to every variable in your dataset. Each variable needs its own
# investigation.

# =============================================================================
# EXTRA TASKS
# =============================================================================

# -----------------------------------------------------------------------------
# Recode income's missing values to a labeled category
# -----------------------------------------------------------------------------
# income is currently numeric, so a plain mutate(income = ifelse(is.na(income),
# "Income not reported", income)) would error -- you can't mix numbers and
# text in the same ifelse() without R complaining. Convert to character FIRST,
# so the whole column is one consistent type, then replace the NAs.
anes <- anes |>
  mutate(income_cat = as.character(income)) |>
  mutate(income_cat = replace_na(income_cat, "Income not reported"))

table(anes$income_cat == "Income not reported")
# FALSE  TRUE
#  4068   202   <- matches the 202 missing values named in the activity

# -----------------------------------------------------------------------------
# Practice with drop_na()
# -----------------------------------------------------------------------------
anes_complete <- anes |>
  drop_na(intelligence, ideology_placement)

nrow(anes)           # 4270
nrow(anes_complete)  # far fewer -- dropping on intelligence alone throws
                      # away most of the dataset, since 74% of it is missing!
                      # This is a good illustration of why drop_na() is risky
                      # to use carelessly: it can quietly gut your sample size.
