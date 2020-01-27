
# choices

<!-- badges: start -->

<!-- badges: end -->

The goal of this package is to provide user friendly interactive
choices. Ideally, this package would be used by users with little to no
coding experience. Thus, some efforts were devoted to ensure users can’t
break the menus easily (e.g., by entering options that are not available
or adding spaces). Effort was also devoted to cross-platform
compatibility.

## Installation

**This package is yet to be released on CRAN.** In the future, you will
be able to install the released version of `choices` from
[CRAN](https://CRAN.R-project.org) with:

``` r
install.packages("choices")
```

For now, install the development version from
[GitHub](https://github.com/matiasandina/choices) with:

``` r
# install.packages("devtools")
devtools::install_github("matiasandina/choices")
```

## Usage

### Choose directory

There are several packages that handle directory selection. The goal of
this function is to handle directory selection, using existing packages,
*across platforms*. Functionality was tested in Windows, macOS, and
Linux environments. It attempts to select the method on the background,
by checking/suggesting what packages are available, without making hard
assumptions of what the user needs.

The function arguments allow for a bit more customization.

  - `initial_dir` defaults to `getwd()`
  - `method` allows user to define the method of their fancy for the
    user interface.

<!-- end list -->

``` r
library(choices)
```

``` r
choose_directory()
choose_directory(initial_dir = "your_path_here")
choose_directory(method = "rChoiceDialogs")
choose_directory(method = "rstudioapi")
```

### Choose files

A similar approach was done for choosing files. User might need to
adjust the `method` if they want to select multiple files, given some
GUIs do not allow for multiple file selection.

``` r
choose_files()
```

### Numeric menu

We can have a numeric menu as shown below:

``` r
library(choices)
opts <- c("Apple", "Banana", "Coconut")
numeric_menu(opts = opts)
```

``` r
numeric_menu(opts = opts, prompt = "A different prompt here")
```

    +++++++++++++++++++++++++++++++
    Please see your options below:
    +++++++++++++++++++++++++++++++
    Option 1) Apple
    Option 2) Banana
    Option 3) Coconut
    
    A different prompt here :> 

This menu is robust to cats slamming the keyboard:

``` r
numeric_menu(opts = opts)
```

    +++++++++++++++++++++++++++++++
    Please see your options below:
    +++++++++++++++++++++++++++++++
    Option 1) Apple
    Option 2) Banana
    Option 3) Coconut
    Use numbers to select the option :> aksdasdakjdsa
    Your input is not valid, please enter a number.
    Use numbers to select the option :>

This menu is robust to selecting options that are not on the menu:

``` r
numeric_menu(opts = opts)
```

    +++++++++++++++++++++++++++++++
    Please see your options below:
    +++++++++++++++++++++++++++++++
    Option 1) Apple
    Option 2) Banana
    Option 3) Coconut
    Use numbers to select the option :> 4
    Option is not valid. Choose again
    Use numbers to select the option :> 

### Ask yes/no

This function was included to make a more robust version of
`utils::askYesNo()` that could not be broken so easily by a cat slamming
the keyboard.

``` r
ask_yes_no("Do you like ice-cream?")
```

    Do you like ice-cream? [Y/N]? :> askdjakdja
    Option is not valid. Choose again
    Do you like ice-cream? [Y/N]? :> 

## Contribute

This is a preliminary release. Please file issues to make this software
work better.
