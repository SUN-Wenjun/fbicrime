#' Set KEY for FBI Crime API
#'
#' A convenience function to set key for FBI Crime API as a global option.
#' Visit the following URL to get a key for the API: \url{https://api.data.gov/signup/}
#'
#' Before calling any querying functions, you should pass your API KEY with \code{set_fbi_crime_api_key()}.
#' This function sets the input API key as a global option so that you don't need to specify the key every time.
#'
#' @param x a string, your key for FBI Crime API.
#'
#' @return set_fbi_crime_api_key() invisibly returns `NULL`.
#'
#' @examples
#' set_fbi_crime_api_key('SomeExampleKey5AynpvPpUQTEyxE77jo1RU8PIv')
#'
#' @export


set_fbi_crime_api_key <- function(x) {
  options('fbicrime_api_key' = x)
  return(invisible())
}
