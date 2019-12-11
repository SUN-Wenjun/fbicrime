#' Validate arguments
#'
#' valid_arg_level() is a function used to validate the arguments for \code{level} and \code{level_detail}.
#'
#' This function is intended to be called by other querying functions within the fbicrime package, but not for external call by users.
#'
#' It checks two things:
#' 1) whether the input \code{level} is legal (i.e. one of 'agencies', 'national', 'regions', 'states');
#' 2) whether the input \code{level} matches \code{level_detail}.
#' This function produces an error when \code{level} is 'national' but \code{level_detail} is not NULL,
#' and when \code{level} is not 'national' but \code{level_detail} is NULL or is not specified.
#'
#'
#' @export

# check if the input level is valid
# standard_level <- c('agencies', 'national', 'regions', 'states')
# valid_arg_level <- function(level){
#   if (!level %in% standard_level){stop('invalid level')}
# }


valid_arg_level <- function(level, level_detail){
  standard_level <- c('agencies', 'national', 'regions', 'states')
  # check whether level is legal
  if (!level %in% standard_level){stop('invalid level')}

  # check whether level matches level_detail
  # if level is 'national', but level_detail is not null: give a warning
  if (level == 'national' & !is.null(level_detail)){stop('when level is "national", level_detail should be null')}
  # if level is not 'national', but level_detail is null: give an error
  if (level != 'national' & is.null(level_detail)){stop('when level is "national", level_detaill should not be empty')}
}
