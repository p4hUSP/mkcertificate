#'
#'
library(magrittr)

mkcertificate <- function(data_list, ass_paths = "DEMO/PRIMEIRAASSINATURA.png"){
  names_vector <- data[[col_name]]

  texto_base <- mkcertificate::template

  texto_uso <- texto_base %>%
    stringr::str_replace("NOMEALUNO", "NOMEDOALUNO") %>%
    stringr::str_replace("HORASCOMPLETAS", "HORASCOMPLETAS") %>%
    stringr::str_replace("PRIMEIRAASSINATURA", normalizePath(ass_paths)) %>%
    stringr::str_replace("SEGUNDAASSINATURA", normalizePath(ass_paths))

  temp_dir <- tempdir()

  border <- magick::image_read("https://raw.githubusercontent.com/p4hUSP/mkcertificate/master/borders/border-1.jpg")

  border_path <- stringr::str_c(temp_dir, "/border.jpg")

  magick::image_write(border, path = border_path)

  texto_uso <- stringr::str_replace(texto_uso, "BORDERPATH", "border.jpg")

  temp_file <- tempfile(tmpdir = temp_dir)

  writeLines(texto_uso, con = temp_file)

  current_wd <- getwd()
  setwd(temp_dir)
  system(sprintf("pdflatex %s", temp_file))
  setwd(current_wd)
  system(sprintf("cp %s.pdf teste.pdf", temp_file))

}
# template <- readLines(con = file("R/certificate_template.tex"))
#
# devtools::use_data(template)

# border <- magick::image_read("DEMO/border-2.jpg")
# devtools::use_data(border)
