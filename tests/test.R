
library(tidyverse)

data <- read_csv("https://docs.google.com/spreadsheets/d/1RBiAoRZ3xVvBiJrexDYazL1dJlXh_yu3loiArvdNnfY/export?format=csv&id=1RBiAoRZ3xVvBiJrexDYazL1dJlXh_yu3loiArvdNnfY&gid=720181803")

data <- data%>%
  mutate(NOME_COMPLETO = if_else(is.na(NOME_COMPLETO), str_c(NOME, SOBRENOME, sep = " "), NOME_COMPLETO),
         HORAS           = TOTAL * 2.5) %>%
  filter(!is.na(NOME_COMPLETO))

lista <- org_data(data, "NOME_COMPLETO", "HORAS", "EMAIL")

col_names  = "NOME_COMPLETO"
col_hours  = "HORAS"
col_email  = "EMAIL"
ass_paths1 = "DEMO/PRIMEIRAASSINATURA.png"
ass_paths2 = "DEMO/PRIMEIRAASSINATURA.png"
