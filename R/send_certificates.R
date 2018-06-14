
send_certificates <- function(data, col_names, col_hours, col_email){
  gmailr::s
  emails_df <- matriculados_df %>%
    mutate(To      = `E-Mail`,
           From    = "programacao.sociais@gmail.com",
           Subject = assunto,
           body    = texto) %>%
    select(To, From, Subject, body)

  emails_mime <- emails_df %>%
    pmap(mime)

  safe_send_message <- safely(send_message)

  sent_mail <- emails_mime %>%
    map(safe_send_message)

}
