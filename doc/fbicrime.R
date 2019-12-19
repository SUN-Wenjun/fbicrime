## ---- include = FALSE----------------------------------------------------
knitr::opts_chunk$set(
  collapse = TRUE,
  comment = "#>"
)

## ----setup---------------------------------------------------------------
library(fbicrime)

## ---- eval = FALSE-------------------------------------------------------
#  set_fbi_crime_api_key('InputYourAPIKeyHere')

## ---- eval = FALSE-------------------------------------------------------
#  count_offense(offense,
#                level = 'national',
#                level_detail = NULL,
#                api_key = getOption('fbicrime_api_key'))

## ---- eval = FALSE-------------------------------------------------------
#  count_offense(offense = 'burglary')
#  
#  count_offense(offense = 'larceny',
#                level = 'agencies',
#                level_detail = 'MA0010100')
#  
#  count_offense(offense = c('burglary','larceny'),
#                level = 'regions',
#                = c('South','Northeast'))
#  
#  count_offense(offense = 'homicide',
#                level = 'states',
#                level_detail = c('AL', 'AZ'))

## ---- eval = FALSE-------------------------------------------------------
#  summarize_offender(offense,
#                     level = 'national',
#                     level_detail = NULL,
#                     variable = 'count',
#                     api_key = getOption('fbicrime_api_key'))

## ---- eval = FALSE-------------------------------------------------------
#  summarize_offender(offense = 'burglary')
#  
#  summarize_offender(offense = 'aggravated-assault',
#                     level = 'agencies',
#                     level_detail = 'MA0010100',
#                     variable = 'age')
#  
#  summarize_offender(offense = c('burglary','arson'),
#                     level = 'regions',
#                     level_detail = c('Northeast','South'),
#                     variable = 'sex')
#  
#  summarize_offender(offense = 'arson',
#                     level = 'states',
#                     level_detail = 'NH',
#                     variable = 'race')

## ---- eval = FALSE-------------------------------------------------------
#  summarize_victim(offense,
#                   level = 'national',
#                   level_detail = NULL,
#                   variable = 'count',
#                   api_key = getOption('fbicrime_api_key'))

## ---- eval = FALSE-------------------------------------------------------
#  summarize_victim(offense = 'violent-crime')
#  
#  summarize_victim(offense = 'aggravated-assault',
#                   level = 'agencies',
#                   level_detail = 'MA0010100',
#                   variable = 'age')
#  
#  summarize_victim(offense = 'property-crime',
#                   level = 'regions',
#                   level_detail = c('Midwest', 'West'),
#                   variable = 'relationship')
#  
#  summarize_victim(offense = 'motor-vehicle-theft',
#                   level = 'states',
#                   level_detail = 'DC',
#                   variable = 'sex')
#  
#  summarize_victim(offense = c('violent-crime','property-crime'),
#                   level = 'states',
#                   level_detail = c('DC','MA'),
#                   variable = 'race')

## ---- eval = FALSE-------------------------------------------------------
#  summarize_arrest(by_offense_type = FALSE,
#                   offense = NULL,
#                   level = 'national',
#                   level_detail = NULL,
#                   variable,
#                   since,
#                   until,
#                   api_key = getOption('fbicrime_api_key'))

## ---- eval = FALSE-------------------------------------------------------
#  summarize_arrest(by_offense_type = TRUE,
#                   offense = c('aggravated-assault','rape'),
#                   level = 'states',
#                   level_detail = c('NY','MA'),
#                   variable = 'race',
#                   since = 2010,
#                   until = 2011)
#  
#  summarize_arrest(by_offense_type = TRUE,
#                   offense = c('aggravated-assault','rape'),
#                   variable = 'race',
#                   since = 2010,
#                   until = 2011)
#  
#  summarize_arrest(by_offense_type = FALSE,
#                   level = 'regions',
#                   level_detail = c('South','Midwest'),
#                   variable = 'all',
#                   since = 2015,
#                   until = 2016)
#  
#  summarize_arrest(by_offense_type = FALSE,
#                   variable = 'all',
#                   since = 2015,
#                   until = 2016)

## ---- eval = FALSE-------------------------------------------------------
#  valid_arg_level(level, level_detail)

