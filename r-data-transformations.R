# Script to convert R data to Python

setwd("~/Downloads")

library(tidyverse)
library(openintro)
library(tidytuesdayR)


# Stent data
stent30 <- 
  stent30 %>% 
  mutate(time = "30 days")

stent365 <- 
  stent365 %>% 
  mutate(time = "365 days")

stent <- 
  stent30 %>% 
  bind_rows(stent365)

write_csv(stent, "stent.csv")

# Loan50 data
loan50 <- loan50
write_csv(loan50, "loan50.csv")

# passwords data
passwords <- readr::read_csv('https://raw.githubusercontent.com/rfordatascience/tidytuesday/master/data/2020/2020-01-14/passwords.csv')

passwords <- 
  passwords %>% 
  slice_head(n=500)

write_csv(passwords, "passwords.csv")

# loans data
loans <- 
  loans_full_schema %>%
  mutate(application_type = as.character(application_type)) %>%
  filter(application_type != "") %>%
  mutate(
    homeownership    = tolower(homeownership), 
    homeownership    = fct_relevel(homeownership, "rent", "mortgage", "own"), 
    application_type = fct_relevel(application_type, "joint", "individual")
  ) 

write_csv(loans, "loans.csv")


loans_individual_rent <- loans %>%
  filter(
    application_type == "individual",
    homeownership    == "rent") %>%
  nrow()

# county data

county <- 
  county %>% 
  mutate(
    pop_change_3levels = case_when(
      pop_change < 0 ~ "loss",
      pop_change == 0 ~ "no change",
      pop_change > 0 ~ "gain"
    ),
    population_change = if_else(pop_change_3levels == "gain", "gain", "no gain")
  ) %>% 
  filter(!is.na(pop_change))

write_csv(county, "county.csv")
