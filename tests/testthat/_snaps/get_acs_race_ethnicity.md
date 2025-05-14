# get_acs_race_ethnicity works

    Code
      get_acs_race_ethnicity()
    Message
      Getting data from the 2019-2023 5-year ACS
    Condition
      Error in `tidycensus::get_acs()`:
      ! argument "geography" is missing, with no default

# get_acs_race_ethnicity names are what we expect

    Code
      names(acs_race_ethnicity)
    Output
      [1] "geoid"            "geography"        "population_group" "estimate"        
      [5] "moe"             

---

    Code
      as.character(lapply(acs_race_ethnicity, class))
    Output
      [1] "character" "character" "character" "numeric"   "numeric"  

