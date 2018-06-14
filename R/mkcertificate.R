#' Creates Certificates of Attendance
#'
#' \code{mkcertificate} creates certificates of attendance based on
#' data.
#'
#' @param data dataframe with values
#'
#' @param col_names character value for the column with the names.
#'
#' @param col_hours character value for the column with the hours.
#'
#' @param col_email character value for the column with the email.
#'
#' @param ass_paths1
#'
#' @param ass_paths2
#'
#' @param ex_dir
#'
#' @export

mkcertificate <- function(data, col_names, col_hours, col_email, ass_paths1, ass_paths2, ex_dir = "."){

  lista <- org_data(data, col_names, col_hours, col_email)

  if(ex_dir != ".")
    dir.create(ex_dir)

  purrr::pmap(lista, build_certificate, ass_paths1, ass_paths2, ex_dir)
}

#' Build the Certificate
#'
#' \code{build_certificate} is the function responsible to generate the PDF.
#'
#' @export

build_certificate <- function(names, hours, email, ass_paths1, ass_paths2, ex_dir){
  texto_base <- mkcertificate::template

  texto_uso <- texto_base %>%
    stringr::str_replace("NOMEALUNO", names) %>%
    stringr::str_replace("HORASCOMPLETAS", hours) %>%
    stringr::str_replace("PRIMEIRAASSINATURA", normalizePath(ass_paths1)) %>%
    stringr::str_replace("SEGUNDAASSINATURA", normalizePath(ass_paths2))

  temp_dir <- tempdir()

  border <- magick::image_read("https://raw.githubusercontent.com/p4hUSP/mkcertificate/master/inst/extdata/border-1.jpg")

  border_path <- stringr::str_c(temp_dir, "/border.jpg")

  magick::image_write(border, path = border_path)

  texto_uso <- stringr::str_replace(texto_uso, "BORDERPATH", "border.jpg")

  temp_file <- tempfile(tmpdir = temp_dir)

  writeLines(texto_uso, con = temp_file)

  current_wd <- getwd()
  setwd(temp_dir)
  system(sprintf("pdflatex %s", temp_file))
  setwd(current_wd)
  system(sprintf("cp %s.pdf %s/%s.pdf", temp_file, ex_dir, digest::digest(email)))
}

#'

org_data <- function(data, col_names, col_hours, col_email){

  names <- data[[col_names]]

  hours <- as.character(data[[col_hours]])

  email <- data[[col_email]]

  lista <- list(names = names,
                hours = hours,
                email = email)

  return(lista)
}
