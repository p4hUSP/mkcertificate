#'
#'
library(magrittr)

mkcertificate <- function(data_list, border = "border.jpg", ass_paths = "R/PRIMEIRAASSINATURA.png"){nam
  names_vector <- data[[col_name]]
  texto_base <- mkcertificate::template
  texto_uso <- texto_base %>%
    stringr::str_replace("NOMEALUNO", "Rafael de Castro Coelho Silva") %>%
    stringr::str_replace("HORASCOMPLETAS", "25") %>%
    stringr::str_replace("PRIMEIRAASSINATURA", normalizePath(ass_paths)) %>%
    stringr::str_replace("SEGUNDAASSINATURA", normalizePath(ass_paths)) %>%
    stringr::str_replace("HORASCOMPLETAS", "25")

  temp_dir <- tempdir()

  texto_base <- stringr::str_replace(texto_base, "BORDERPATH", normalizePath(border))

  temp_file <- tempfile(tmpdir = temp_dir)

  writeLines(text, con = temp_file)

  {
    current_wd <- getwd()
    setwd(temp_dir)
    system(sprintf("pdflatex %s", temp_file))
    setwd(current_wd)
    system(sprintf("cp %s.pdf teste.pdf", temp_file))
  }
}
# template <- readLines(con = file("R/certificate_template.tex"))
#
# devtools::use_data(template)

# border <- magick::image_read("R/border-2.jpg")
# devtools::use_data(border)
