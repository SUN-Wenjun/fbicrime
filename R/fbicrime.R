#' fbicrime: an R package for querying data from FBI Crime API
#'
#' The fbicrime provides four important functions for querying crime data from FBI Crime API
#' (i.e. \code{count_offense()}, \code{summarize_offender()}, \code{summarize_victim()}, and \code{summarize_arrest()})
#' and one convenience function (i.e. \code{set_fbi_crime_api_key()}) for setting API key as a global option.
#'
#' @section set_fbi_crime_api_key() function:
#' \code{set_fbi_crime_api_key()} sets the input API key as a global option so that you don't need to
#' specify the key every time. If global environment is reset, you will need to
#' pass the key again with this function.
#' Please visit the following URL to get a key for the API: \url{https://api.data.gov/signup/}
#'
#' @section count_offense() function:
#' \code{count_offense()} is a function that queries the count of different types of offense from
#' FBI Crime API and returns a data frame based on the query result.
#' You can specify offense type, level of aggregation (national, agencies, regions, or states),
#' and selected levels (i.e. what are the states/regions/agencies you want to include) in this function.
#'
#' @section summarize_offender() function:
#' \code{summarize_offender()} is a function that queries offender demographic information from
#' FBI Crime API and returns a data frame.
#' You can specify offense type, aggregation level (national, agencies, regions, or states), and
#' aggregation variable (age, ethnicity, etc.) in this function.
#'
#' @section summarize_victim() function:
#' \code{summarize_victim()} is a function that queries victim demographic information from
#' FBI Crime API and returns a data frame.
#' You can specify offense type, aggregation level (national, agencies, regions, or states), and
#' aggregation variable (age, ethnicity, etc.) in this function.
#'
#' @section summarize_arrest() function:
#' \code{summarize_arrest()} is a function that queries arrest information from FBI Crime API and returns a data frame.
#' You can choose whether to summarize by offense type or not with \code{by_offense_type} and input
#' the offense(s) with \code{offense}.
#' You can also specify aggregation level (national, agencies, regions, or states), aggregation variable
#' (age, ethnicity, etc.), and time span in this function.
#'
#' @import httr
#' @import jsonlite
#' @import dplyr
#'
#' @docType package
#' @name fbicrime
NULL
