# TODO ask user to install stuff if non of the requirements are met
# change this to something like .onAttach

recommend_library <- function(lib_name){
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
