data <- readr::read_csv("https://docs.google.com/spreadsheets/d/1RBiAoRZ3xVvBiJrexDYazL1dJlXh_yu3loiArvdNnfY/export?format=csv&id=1RBiAoRZ3xVvBiJrexDYazL1dJlXh_yu3loiArvdNnfY&gid=720181803")

data <- data %>%
  dplyr::mutate(NOME_COMPLETO = ifelse(is.na(NOME_COMPLETO), stringr::str_c(NOME, SOBRENOME, sep = " "), NOME_COMPLETO),
         HORAS           = TOTAL * 2.5) %>%
  dplyr::filter(!is.na(NOME_COMPLETO))

mkcertificate(data, "NOME_COMPLETO", "HORAS", "EMAIL", ass_paths1 = "inst/extdata/PRIMEIRAASSINATURA.png", ass_paths2 = "inst/extdata/PRIMEIRAASSINATURA.png",
              ex_dir = "certificates")

