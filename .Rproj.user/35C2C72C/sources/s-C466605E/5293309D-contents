#' Summarize arrest data
#'
#' summarize_arrest() is a function that queries arrest information from FBI Crime API and returns a data frame.
#'     You can choose whether to summarize by offense type or not with \code{by_offense_type} and input the offense(s) with \code{offense}.
#'     You can also specify aggregation level (national, agencies, regions, or states), aggregation variable (age, ethnicity, etc.), and time span in this function.
#'
#' @param by_offense_type a boolean. \code{TRUE} means to summarize by offense type, \code{FALSE} means to return information about all offense types.
#'     If omitted, \code{FALSE} is assumed.
#' @param offense a string or a list, the offense type(s) to request.
#'     If omitted, \code{NULL} is assumed.
#' @param level a string, the level of aggregation. It can be \code{national}, \code{agencies}, \code{regions}, or \code{states}.
#'     If omitted, \code{national} is assumed.
#' @param level_detail a string or a list. Use this parameter to indicate what are the agencies/regions/states you want to query.
#'     For example, when \code{level = 'agencies'}, then specify the ORI code of the agencies here.
#'     If \code{level = 'regions'} , then specify what regions to include here. There are four region categories available for choosing: Northeast, Midwest, West, and South.
#'     If \code{level = 'states'}, then specify state abbreviations here, e.g. \code{c('AL', 'AZ')}.
#'     Note, when \code{level = 'national'}, this parameter should be \code{NULL}.
#' @param variable a string, the rule for aggregating.
#'     The availale arguments for this parameter vary for different endpoints of the API. Please check the API document (https://crime-data-explorer.fr.cloud.gov/api) for details.
#'     Required.
#' @param since a number, the year to start
#' @param until a number, the year to end
#' @param api_key a srting, the API key for FBI Crime API. Required. Default is to get the key from global option,
#'     so if you have passed the API key to \code{set_fbi_crime_api_key()}, then this parameter is not necessary.
#'     In order word, you can either input the key here as a argument,
#'     or you can call function \code{set_fbi_crime_api_key()} to set key for FBI Crime API as a global option first.
#'
#' @import httr
#' @import jsonlite
#' @import dplyr
#' @export
#'
#' @examples
#' summarize_arrest(by_offense_type = TRUE, offense = c('aggravated-assault','rape'), level = 'states', level_detail = c('NY','MA'), variable = 'race', since = 2010, until = 2011)
#' summarize_arrest(by_offense_type = TRUE, offense = c('aggravated-assault','rape'), variable = 'race', since = 2010, until = 2011)
#' summarize_arrest(by_offense_type = FALSE, level = 'regions', level_detail = c('South','Midwest'), variable = 'all', since = 2015, until = 2016)
#' summarize_arrest(by_offense_type = FALSE, variable = 'all', since = 2015, until = 2016)



summarize_arrest <- function(by_offense_type = FALSE,
                             offense = NULL,
                             level = 'national',
                             level_detail = NULL,
                             variable,
                             since,
                             until,
                             api_key = getOption('fbicrime_api_key')){
  # validate arguments
  valid_arg_level(level, level_detail)

  # define an output dataframe
  if (!is.null(level_detail)){
    df_result <- data.frame(matrix(ncol = 6, nrow = 0))
  }else{
    df_result <- data.frame(matrix(ncol = 5, nrow = 0))
  }

  if (by_offense_type){
    # with specific offense type - offense
    for (offense_sub in offense){
      if (!is.null(level_detail)){
        # with specific level
        for (level_detail_sub in level_detail){
          # go over each level and each offense type
          endpoint <- paste('https://api.usa.gov/crime/fbi/sapi',
                            'api/arrest',
                            level,
                            level_detail_sub,
                            offense_sub,
                            variable,
                            as.character(since),
                            as.character(until),
                            sep = '/')
          query <- paste(endpoint, '?API_KEY=', api_key, sep = '')
          response <- httr::GET(query)
          if(httr::http_error(response)){
            warning('The request produced an error')
            break}
          else {content_of_response <- httr::content(response)}

          df <- as.data.frame(jsonlite::fromJSON(jsonlite::toJSON(content_of_response$data), simplifyDataFrame = TRUE))
          if(length(df) == 0){warning('No available data for the given query')}else{
            df <- df %>%
              mutate(year = as.numeric(data_year), count = as.numeric(value), level = level, level_detail = level_detail_sub, type = offense_sub) %>%
              select(year, level, level_detail, type, key, count) %>%
              arrange(desc(year))
            df_result <- rbind(df_result, df)
          }
        }
      }else{
        # without specific level
        # only go over each offense type
        endpoint <- paste('https://api.usa.gov/crime/fbi/sapi',
                          'api/arrest',
                          level,
                          offense_sub,
                          variable,
                          as.character(since),
                          as.character(until),
                          sep = '/')
        query <- paste(endpoint, '?API_KEY=', api_key, sep = '')

        response <- httr::GET(query)

        if(httr::http_error(response)){
          warning('The request produced an error')
          break}
        else {content_of_response <- httr::content(response)}

        df <- as.data.frame(jsonlite::fromJSON(jsonlite::toJSON(content_of_response$data), simplifyDataFrame = TRUE))
        if(length(df) == 0){warning('No available data for the given query')}else{
          df <- df %>%
            mutate(year = as.numeric(data_year), count = as.numeric(value), level = level, type = offense_sub) %>%
            select(year, level, type, key, count) %>%
            arrange(desc(year))
          df_result <- rbind(df_result, df)
        }
      }
    }
  }else{
    # without specific offense type
    if (!is.null(level_detail)){
      # with specific level
      for (level_detail_sub in level_detail){
        # go over each level
        endpoint <- paste('https://api.usa.gov/crime/fbi/sapi',
                          'api/arrest',
                          level,
                          'offense',
                          level_detail_sub,
                          variable,
                          as.character(since),
                          as.character(until),
                          sep = '/')

        query <- paste(endpoint, '?API_KEY=', api_key, sep = '')

        response <- httr::GET(query)

        if(httr::http_error(response)){
          warning('The request produced an error')
          break}
        else {content_of_response <- httr::content(response)}

        df <- as.data.frame(jsonlite::fromJSON(jsonlite::toJSON(content_of_response$data), simplifyDataFrame = TRUE))
        if(length(df) == 0){warning('No available data for the given query')}else{
          df <- df %>%
            mutate(year = as.numeric(data_year), count = as.numeric(value), level = level, level_detail = level_detail_sub, type = 'offense') %>%
            select(year, level, level_detail, type, key, count) %>%
            arrange(desc(year))
          df_result <- rbind(df_result, df)
        }
      }
    }else{
      # without specific level
      # only query one offense type on national level
      endpoint <- paste('https://api.usa.gov/crime/fbi/sapi',
                        'api/arrest',
                        level,
                        'offense',
                        variable,
                        as.character(since),
                        as.character(until),
                        sep = '/')
      query <- paste(endpoint, '?API_KEY=', api_key, sep = '')

      response <- httr::GET(query)

      if(httr::http_error(response)){
        warning('The request produced an error')
        break}
      else {content_of_response <- httr::content(response)}

      df <- as.data.frame(jsonlite::fromJSON(jsonlite::toJSON(content_of_response$data), simplifyDataFrame = TRUE))
      if(length(df) == 0){warning('No available data for the given query')}else{
        df <- df %>%
          mutate(year = as.numeric(data_year), count = as.numeric(value), level = level, type = 'offense') %>%
          select(year, level, type, key, count) %>%
          arrange(desc(year))
        df_result <- rbind(df_result, df)
      }
    }
  }
  return(df_result)
}



