#' Summarize NIBRS offender demographic data
#'
#' summarize_offender() is a function that queries offender demographic information from FBI Crime API and returns a data frame.
#'     You can specify offense type, aggregation level (national, agencies, regions, or states), and aggregation variable (age, ethnicity, etc.) in this function.
#'
#' Before calling any querying functions, you should pass your API KEY with \code{set_fbi_crime_api_key()}.
#'
#' @param offense a string or a list, the offense type(s) to request. Required.
#' @param level a string, the level of aggregation. It can be \code{national}, \code{agencies}, \code{regions}, or \code{states}.
#'     If omitted, \code{national} is assumed.
#' @param level_detail a string or a list. Use this parameter to indicate what are the agencies/regions/states you want to query.
#'     For example, when \code{level = 'agencies'}, then specify the ORI code of the agencies here.
#'     If \code{level = 'regions'} , then specify what regions to include here. There are four region categories available for choosing: Northeast, Midwest, West, and South.
#'     If \code{level = 'states'}, then specify state abbreviations here, e.g. \code{c('AL', 'AZ')}.
#'     Note, when \code{level = 'national'}, this parameter should be \code{NULL}.
#' @param variable a string, the rule for aggregating. It can be \code{age}, \code{ethnicity}, \code{race}, \code{sex}, or \code{count}.
#'     If omitted, \code{count} is assumed.
#' @param api_key a srting, the API key for FBI Crime API. Required. Default is to get the key from global option
#'     You can input the key here as a argument,
#'     or you can call function \code{set_fbi_crime_api_key()} to set key for FBI Crime API as a global option first.
#'
#' @import httr
#' @import jsonlite
#' @import dplyr
#' @export
#'
#' @examples
#' summarize_offender(offense = 'burglary')
#' summarize_offender(offense = 'aggravated-assault', level = 'agencies', level_detail = 'MA0010100', variable = 'age')
#' summarize_offender(offense = c('burglary','arson'), level = 'regions', level_detail = c('Northeast','South'), variable = 'sex')
#' summarize_offender(offense = 'arson', level = 'states', level_detail = 'NH', variable = 'race')

summarize_offender <- function(offense,
                               level = 'national',
                               level_detail = NULL,
                               variable = 'count',
                               api_key = getOption('fbicrime_api_key')){
  valid_arg_level(level, level_detail)

  if (!is.null(level_detail)){
    df_result <- data.frame(matrix(ncol = 6, nrow = 0))
  }else{
    df_result <- data.frame(matrix(ncol = 5, nrow = 0))
  }

  for (offense_sub in offense){
    if (!is.null(level_detail)){
      for (level_detail_sub in level_detail){
        endpoint <- paste('https://api.usa.gov/crime/fbi/sapi',
                          'api/nibrs',
                          offense_sub,
                          'offender',
                          level,
                          level_detail_sub,
                          variable,
                          sep = '/')
        query <- paste(endpoint, '?API_KEY=', api_key, sep = '')
        response <- httr::GET(query)
        if(httr::http_error(response)){
          warning('The request produced an error')
          break}
        else{content_of_response <- httr::content(response)}
        df <- as.data.frame(jsonlite::fromJSON(jsonlite::toJSON(content_of_response$data), simplifyDataFrame = TRUE))
        if(length(df) == 0){warning('No available data for one of the given query')}else{
          df <- df %>%
            mutate(year = as.numeric(data_year), count = as.numeric(value), type = offense_sub, level = level, level_detail = level_detail_sub) %>%
            select(year, level, level_detail, type, key, count) %>%
            arrange(desc(year))
          df_result <- rbind(df_result, df)
        }
      }
    }else{
      endpoint <- paste('https://api.usa.gov/crime/fbi/sapi',
                        'api/nibrs',
                        offense_sub,
                        'offender',
                        level,
                        variable,
                        sep = '/')
      query <- paste(endpoint, '?API_KEY=', api_key, sep = '')
      response <- httr::GET(query)
      if(httr::http_error(response)){
        warning('The request produced an error')
        break}
      else{content_of_response <- httr::content(response)}
      df <- as.data.frame(jsonlite::fromJSON(jsonlite::toJSON(content_of_response$data), simplifyDataFrame = TRUE))
      if(length(df) == 0){warning('No available data for one of the given query')}else{
        df <- df %>%
          mutate(year = as.numeric(data_year), count = as.numeric(value), type = offense_sub, level = level) %>%
          select(year, level, type, key, count) %>%
          arrange(desc(year))
        df_result <- rbind(df_result, df)
      }
    }
  }
  return(df_result)
}



