template <- readLines(file("inst/extdata/certificate_template.tex"))

save(template, file = "data/template.rda")
