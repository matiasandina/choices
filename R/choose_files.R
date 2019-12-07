#' @title Choose files
#' @description These function allows the user to choose a directory interactively. It has been tested on Windows, Ubuntu and macOS. The gist comes from https://stackoverflow.com/questions/48218491/os-independent-way-to-select-directory-interactively-in-r
#' @param initial_dir Path to folder from which to display dialog. Default is to use current working directory.
#' @param method Package to be used to construct the GUI. See `select_directory_method()`
#' @param title Character, title of the vector
#' @seealso `select_directory_method()`

### Main Function ####

#' @export
choose_files <- function(initial_dir = getwd(),
                         method = select_directory_method(),
                         title = NULL) {

  # TODO: make sure that all options are compatible
  # for example rstudioapi::selectFile() is not compatible with multiple files
  # modify select_method accordingly

  # ensure the path works
  initial_dir <- normalizePath(initial_dir, winslash = "\\", mustWork = TRUE)
  # ensure the title works
  if (!is.null(title)) {
    # coerce to character just in case
    title <- as.character(title)
  } else {
    title <- "Choose file(s)"
  }


  switch(method,
         'choose.dir' = choose.dir(default = initial_dir, caption = title),
         'RStudioAPI' = rstudioapi::selectDirectory(path = initial_dir, caption = title),
         'tcltk' = tcltk::tk_choose.dir(default = initial_dir, caption = title),
         'rChoiceDialogs' = rChoiceDialogs::rchoose.dir(default = initial_dir, caption = title),
         'gWidgets2RGtk2' = gWidgets2RGtk2::gfile(type = 'selectdir', text = title, initial.dir = initial_dir),
         readline('Please enter directory path: ')
  )
}



