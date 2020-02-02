#' @title Choose files
#' @description This function allows the user to choose file(s) interactively. It has been tested on Windows, Ubuntu and macOS.
#' @param initial_dir Path to folder from which to display dialog. Default is to use current working directory.
#' @param method Package to be used to construct the GUI. See `select_directory_method()`
#' @param title Character, title of the vector
#' @param multiple Boolean, allows for multiple files to be selected. Some GUIs do not allow multiple files.
#' @seealso select_directory_method(), choose_directory()

### Main Function ####

#' @export
choose_files <- function(initial_dir = getwd(),
                         method = select_directory_method(),
                         title = NULL, multiple = TRUE) {

  # ensure the path works
  initial_dir <- normalizePath(initial_dir, winslash = "\\", mustWork = TRUE)
  # ensure the title works
  if (!is.null(title)) {
    # coerce to character just in case
    title <- as.character(title)
  } else {
    title <- "Choose file(s)"
  }

  if (method == "rstudioapi") {
    warning("RStudioAPI does not allow for multiple files.\nIgnoring parameter `multiple`.\nSelect another method using `method` argument in function call.\nSee available methods with `available_methods(FALSE)`")
  }

  switch(method,
         'choose.files' = choose.files(default = initial_dir, caption = title, multi = multiple),
         'rstudioapi' = rstudioapi::selectFile(path = initial_dir, caption = title),
         'tcltk' = tk_choose.files(default = initial_dir, caption = title, multi = multiple, filters = NULL, index = 1),
         'rChoiceDialogs' = rChoiceDialogs::rchoose.files(default = initial_dir, caption = title, multi = multiple),
         'gWidgets2RGtk2' = gWidgets2RGtk2::gfile(type = 'open', text = title, initial.dir = initial_dir),
         readline('Please enter file path: ')
  )
}



