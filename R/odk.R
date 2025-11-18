#Helper functions for interaction with ODK Central


#' Initialize/test ODK connection
#' @description
#' Have a user prompt to enter username and password and then
#' save the resulting token to be used for this session
#' @param url `chr` Target URL for the ODK Central API
#' @param user `chr` Username
#' @param pass `chr` Password
#' @param testing `bool` Should results be evaluated for testing
#' @return `bool` T/F
init_odk_connection <- function(
    url = yaml::read_yaml(here::here("sandbox/keys.yaml"))$odk$url,
    user = yaml::read_yaml(here::here("sandbox/keys.yaml"))$odk$name,
    pass = yaml::read_yaml(here::here("sandbox/keys.yaml"))$odk$pass,
    testing = FALSE
){
  x <- httr::POST(
    url = httr::modify_url(url, path = glue::glue("v1/sessions")),
    body = list(
      "email" = user,
      "password" = pass
    ),
    encode = "json"
  )

  x <- httr::content(x)

  Sys.setenv("ODK_TOKEN" = x$token)
  Sys.setenv("ODK_CSRF" = x$csrf)

  if(testing){
    return(Sys.getenv("ODK_TOKEN"))
  }else{
    cli::cli_alert_info(paste0("Your session has been validated at ", x$createdAt,
                               " and will remain active until ", x$expiresAt,
                               ". Your ODK session token has been cached and will
                             remain active until you restart this R session"))
  }
}


#' Test ODK connection
#' @description
#' Verify that the connection to ODK is still active
#'

#' List ODK projects
#' @description
#' Given verified access, list all projects the user can access
#'

#' List ODK forms
#' @description
#' Given verified access, list all forms under a project


#' Download ODK form data
#' @description
#' Given verified access, download all data from an ODK form
#'

#' List all users

#' See all users who have access to a form

#' Add online users

#' Add app users

#' Link and unlink users to a form

#' Initialize a local ODK data repository
#' @description
#' Identify a local file that will serve as a
#'
