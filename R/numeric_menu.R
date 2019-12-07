
numeric_menu <- function(opts, prompt = NULL){

  if (is.null(prompt)) {
    prompt <- "Use numbers to select the option"
  }

  # prompt
  print_options(opts)
  prompt <- paste(as.character(prompt), ":> ")

  # ask for the first time
  ans <- readline(prompt = prompt)

  # validate and convert to numeric
  ans <- validate_input(ans, prompt)
  # Check if answer is within options
  ans <- within_options(ans, opts, prompt)

  # will this blow up with index error?
  selected_option <- opts[ans]

  return(selected_option)
}


print_options <- function(opts){
  message("+++++++++++++++++++++++++")
  message("Please see your options below:")
  message("+++++++++++++++++++++++++")
  message(paste0("Option ",
                 seq_len(length(opts)),
                 ") ",
                 opts,
                 "\n"))

}

within_options <- function(ans, opts, prompt){
  while (ans < 1 | ans > length(opts)) {
    message("Option is not valid. Choose again")
    ans <- readline(prompt = prompt)
  }
  ans <- validate_input(ans, prompt)
  return(ans)
}

validate_input <- function(ans, prompt){
  # while loop checking whether the input is valid
  # TODO: expand this to more categories?
  # Consider ensurer package?
  ans <- suppressWarnings(as.numeric(ans))

  while (is.na(ans)) {
    message("Your input is not valid, please enter a number.")
    ans <- readline(prompt = prompt)
    ans <- suppressWarnings(as.numeric(ans))
  }

  return(ans)
}
