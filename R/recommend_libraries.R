.onAttach <- function(...){

  available_methods(quietly = TRUE)
  recommend_library(.installed, .packages)
}

recommend_library <- function(.installed, .packages){

  # check windows
  win_os <- exists('utils::choose.dir')

  can_use <- any(win_os, .installed)

  if (!can_use) {
    # suggest install
    message("You don't have any of the recommended packages installed.")

    to_install <- numeric_menu(names(.installed),
                               prompt = "Which package do you want to install?")

    utils::install.packages(to_install, dependencies = TRUE)
    require(lib_name, quietly = TRUE, character.only = TRUE)

  }

}
