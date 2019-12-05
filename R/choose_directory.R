#' @title Choose directory
#' @description This function allows the user to choose a directory interactively. It has been tested on Windows, Ubuntu and macOS. The gist comes from https://stackoverflow.com/questions/48218491/os-independent-way-to-select-directory-interactively-in-r
#' @param initial_dir Path to folder from which to display dialog. Default is to use current working directory.
#' @param method Package to be used to construct the GUI. See `select_directory_method()`
#' @param title Character, title of the vector
#' @seealso `select_directory_method()`

### Main Function ####

#' @export
choose_directory <- function(initial_dir = getwd(),
                             method = select_directory_method(),
                             title = NULL) {

  # ensure the path works
  initial_dir <- normalizePath(initial_dir, winslash = "\\", mustWork = TRUE)
  # ensure the title works
  if (!is.null(title)) {
    # coerce to character just in case
    title <- as.character(title)
  } else {
    title <- "Choose directory"
  }

  # Call function using method
  switch(method,
         'choose.dir' = choose.dir(default = initial_dir, caption = title),
         'RStudioAPI' = rstudioapi::selectDirectory(path = initial_dir, caption = title),
         'tcltk' = tcltk::tk_choose.dir(default = initial_dir, caption = title),
         'rChoiceDialogs' = rChoiceDialogs::rchoose.dir(default = initial_dir, caption = title),
         'gWidgets2RGtk2' = gWidgets2RGtk2::gfile(type = 'selectdir', text = title, initial.dir = initial_dir),
         readline('Please enter directory path: ')
  )
}


###  Helpers ####
# First helper: function to load packages, installing them first if necessary
# Returns logical value for whether successful
ensure_library <- function(lib_name){
  # Calling installed.packages() many times is slow
  if (!exists(".installed", envir = .GlobalEnv)) {
    .installed <- installed.packages()
    # remember for later
    assign('.installed', .installed, envir = .GlobalEnv)
    }

  x <- lib_name %in% .installed
  #if (!x) {
  #  install.packages(lib_name, dependencies = TRUE, quiet = TRUE)
  #  x = require(lib_name, quietly = TRUE, character.only = TRUE)
  #}
  return(x)
}


# Second helper: function to switch between options
select_directory_method <- function() {
  # Tries out a sequence of potential methods for selecting a directory to find one that works
  # The fallback default method if nothing else works is to get user input from the console
  if (!exists('.dir.method')) {  # if we already established the best method, just use that
    # otherwise lets try out some options to find the best one that works here
    if (exists('utils::choose.dir')) {
      .dir.method = 'choose.dir'
    } else if (rstudioapi::isAvailable() & rstudioapi::getVersion() > '1.1.287') {
      .dir.method = 'RStudioAPI'
      ensure_library('rstudioapi')
    } else if (ensure_library('tcltk') &
              class(try({tt  <- tktoplevel(); tkdestroy(tt)}, silent = TRUE)) != "try-error") {
      .dir.method = 'tcltk'
    } else if (ensure_library('gWidgets2') & ensure_library('RGtk2')) {
      .dir.method = 'gWidgets2RGtk2'
    } else if (ensure_library('rJava') & ensure_library('rChoiceDialogs')) {
      .dir.method = 'rChoiceDialogs'
    } else {
      .dir.method = 'console'
    }
    assign('.dir.method', .dir.method, envir = .GlobalEnv) # remember the chosen method for later
  }
  return(.dir.method)
}



