# Script to convert R data to Python

setwd("~/Downloads")

library(tidyverse)
library(openintro)
library(tidytuesdayR)
library(maps)


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

# Mapping data

dfips <- 
  maps::county.fips %>%
  as_tibble() %>% 
  extract(polyname, c("region", "subregion"), "^([^,]+),([^,]+)$")

map_county <- 
  map_data("county") %>%
  as_tibble() %>%
  left_join(dfips) %>%
  mutate(fips = case_when(
    subregion == "okaloosa"  & region == "florida"        ~ 12091L,
    subregion == "st martin" & region == "louisiana"      ~ 22099L,
    subregion == "currituck" & region == "north carolina" ~ 37053L,
    # Oglala Lakota Count, see https://en.wikipedia.org/wiki/Oglala_Lakota_County,_South_Dakota
    subregion == "shannon"   & region == "south dakota"   ~ 46113L, 
    subregion == "galveston" & region == "texas"          ~ 48167L,
    subregion == "accomack"  & region == "virginia"       ~ 51001L,
    subregion == "pierce"    & region == "washington"     ~ 53053L,
    subregion == "san juan"  & region == "washington"     ~ 53055L,
    TRUE ~ fips
  ))

county_for_map <- 
  county_complete %>%
  select(fips, name, state, poverty_2017, unemployment_rate_2017, homeownership_2010, median_household_income_2017)

write_csv(county_for_map, "county_for_map.csv")
