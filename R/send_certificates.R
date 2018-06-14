
send_certificates <- function(data, col_names, col_hours, col_email, from_email){
  gmailr::s
  emails_df <- matriculados_df %>%
    mutate(To      = col_email,
           From    = from_email,
           Subject = assunto,
           body    = texto) %>%
    select(To, From, Subject, body)

  emails_mime <- emails_df %>%
    pmap(mime)

  safe_send_message <- safely(send_message)

  sent_mail <- emails_mime %>%
    map(safe_send_message)

}
