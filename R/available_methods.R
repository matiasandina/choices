#' @title Available methods
#' @description This function looks for available methods and creates global objects required by other functions in the package.
#' @param quietly Boolean, allows user to return a `data.frame` with available methods.

#' @export
available_methods <- function(quietly=TRUE){
  .packages <- c('rstudioapi', 'tcltk', 'rChoiceDialogs', 'gWidgets2RGtk2')
  .installed <- sapply(.packages, function(x) requireNamespace(x, quietly = TRUE))
  # remember for later
  assign('.installed', .installed, envir = .GlobalEnv)
  if (quietly == FALSE) {
    df <- data.frame(method = .packages, installed = .installed, row.names = NULL)
    return(df)
  }
}
