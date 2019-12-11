#' Count NIBRS offense data
#'
#' count_offense() is a function that queries the count of different types of offense from FBI Crime API and returns a data frame based on the query result.
#' You can specify offense type, level of aggregation (national, agencies, regions, or states), and selected levels (i.e. what are the states/regions/agencies you want to include) in this function.
#'
#' Before calling any querying functions, you should pass your API KEY with \code{set_fbi_crime_api_key()}.
#'
#' @param offense a string or a list, the offense type(s) to request. Required.
#' @param level a string, the level of aggregation for counting. It can be \code{national}, \code{agencies}, \code{regions}, or \code{states}.
#'     If omitted, \code{national} is assumed.
#' @param level_detail a string or a list. Use this parameter to indicate what are the agencies/regions/states you want to query.
#'     For example, when \code{level = 'agencies'}, then specify the ORI code of the agencies here.
#'     If \code{level = 'regions'} , then specify what regions to include here. There are four region categories available for choosing: Northeast, Midwest, West, and South.
#'     If \code{level = 'states'}, then specify state abbreviations here, e.g. \code{c('AL', 'AZ')}.
#'     Note, when \code{level = 'national'}, this parameter should be \code{NULL}.
#' @param api_key a srting, the API key for FBI Crime API. Required. Default is to get the key from global option,
#'     so if you have passed the API key to \code{set_fbi_crime_api_key()}, then this parameter is not necessary.
#'     In other words, you can either input the key here as a argument,
#'     or you can call function \code{set_fbi_crime_api_key()} to set key for FBI Crime API as a global option first.
#'
#' @import httr
#' @import jsonlite
#' @import dplyr
#' @export
#'
#' @examples
#' count_offense(offense = 'burglary')
#' count_offense(offense = 'larceny', level = 'agencies', level_detail = 'MA0010100')
#' count_offense(offense = c('burglary','larceny'), level = 'regions', level_detail = c('South','Northeast'))
#' count_offense(offense = 'homicide', level = 'states', level_detail = c('AL', 'AZ'))

count_offense <- function(offense,
                          level = 'national',
                          level_detail = NULL,
                          api_key = getOption('fbicrime_api_key')){
  # validate arguments
  valid_arg_level(level, level_detail)

  # define an output dataframe
  if (!is.null(level_detail)){
    df_result <- data.frame(matrix(ncol = 6, nrow = 0))
  }else{
    df_result <- data.frame(matrix(ncol = 5, nrow = 0))
  }

  # go over each offense type in the input list of offense, within each offense type, go over each level_detail if the query is not a 'national' level one.
  for (offense_sub in offense){
    if (!is.null(level_detail)){
      for (level_detail_sub in level_detail){
        endpoint <- paste('https://api.usa.gov/crime/fbi/sapi',
                          'api/nibrs',
                          offense_sub,
                          'offense',
                          level,
                          level_detail_sub,
                          'count',
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
                        'offense',
                        level,
                        'count',
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







