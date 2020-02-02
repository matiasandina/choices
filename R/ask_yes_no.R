#' @title Ask yes no
#' @description This function allows yes/no answers to be returned as TRUE/FALSE or 'y'/'n'. It will prompt user multiple times until a valid response is given.
#' @param prompt character, prompt to ask the user.
#' @param boolean boolean, whether to return results as boolean or as 'y/n'.
#' @seealso utils::askYesNo()

#' @export
ask_yes_no <- function(prompt, boolean = TRUE){

  # Checking input to be character
  condition_prompt <- ensurer::check_that(prompt, is.character(.) && length(.) > 0)
  if (!condition_prompt) {
    stop("`prompt` must be character and length > 0")
  }

  new_prompt <- paste(prompt, "[Y/N]? :> ")

  ans <- tolower(readline(prompt = new_prompt))

  yes_no <- c("y", "n")

  while (!(ans %in% yes_no)) {
    message("Option is not valid. Choose again")
    ans <- readline(prompt = new_prompt)
  }

  if (boolean) {
    if (ans == "y") {
      return(TRUE)
    } else {
      return(FALSE)
    }
  } else {
    return(ans)
  }
}
