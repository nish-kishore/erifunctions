#Helper functions for interaction with ODK Central


#' Initialize/test ODK connection
#' @description
#' Have a user prompt to enter username and password and then
#' save the resulting token to be used for this session
#' @param url `chr` Target URL for the ODK Central API
#' @param user `chr` Username
#' @param pass `chr` Password
#' @param testing `bool` Should results be evaluated for testing
#' @param verbose `bool` Should the function return character with information
#' or a boolean vector verifying connection
#' @return `chr`/`bool` Verbose response or a T/F
init_odk_connection <- function(
    url = yaml::read_yaml(here::here("sandbox/keys.yaml"))$odk$url,
    user = yaml::read_yaml(here::here("sandbox/keys.yaml"))$odk$name,
    pass = yaml::read_yaml(here::here("sandbox/keys.yaml"))$odk$pass,
    testing = FALSE,
    verbose = TRUE
){

  if(testing){
    x <- httr::GET(
      url = "https://api.ipify.org/?format=json"
    )

    x <- httr::content(x)

    Sys.setenv("ODK_TOKEN" = x$ip)
  }else{
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
    Sys.setenv("ODK_URL" = url)
  }

  if(verbose){
    cli::cli_alert_info(paste0("Your session has been validated at ", x$createdAt,
                               " and will remain active until ", x$expiresAt,
                               ". Your ODK session token has been cached and will
                             remain active until you restart this R session"))

  }else{
    return(!Sys.getenv("ODK_TOKEN") == "")
  }
}

#' List ODK projects
#' @description
#' Given verified access, list all projects the user can access
#' @param url `chr` Target URL for the ODK Central API
#' @param auth `chr` Authorization token to access URL
#' @param testing `bool` T/F if you want to just verify that the API if working
#' @returns `tibble` Output of all projects from API call
list_odk_projects <- function(
    url = Sys.getenv("ODK_URL"),
    auth = Sys.getenv("ODK_TOKEN"),
    testing = FALSE
){

  if(testing){
    (httr::GET(
      url = httr::modify_url(url, path = glue::glue("v1/example2"))
    ) |>
      httr::content())$code
  }else{
    x <- httr::GET(
      url = httr::modify_url(url, path = glue::glue("v1/projects")),
      config = httr::add_headers(
        "Authorization" = paste0("Bearer ", auth),
        "forms" = "true"
      )
    )

    x <- httr::content(x)

    out <- lapply(1:length(x), function(i){
      tibble::tibble(
        "project_id" = x[[i]]$id,
        "project" = x[[i]]$name,
        "description" = x[[i]]$description
      )
    }) |> dplyr::bind_rows()

    return(out)
  }
}

#' List ODK forms
#' @description
#' Given verified access and a project id, list all forms under a project
#' @param url `chr` Target URL for the ODK Central API
#' @param auth `chr` Authorization token to access URL
#' @param project_id `int` Project id from `list_odk_projects()`
#' @param testing `bool` T/F if you want to just verify that the API if working
#' @returns `tibble` Output of all projects from API call
list_odk_forms <- function(
    url = Sys.getenv("ODK_URL"),
    auth = Sys.getenv("ODK_TOKEN"),
    project_id,
    testing = FALSE
){

  if(testing){
    (httr::GET(
      url = httr::modify_url(url, path = glue::glue("v1/example2"))
    ) |>
      httr::content())$code
  }else{
    x <- httr::GET(
      url = paste0(url, "v1/projects/",project_id,"/forms"),
      config = httr::add_headers(
        "Authorization" = paste0("Bearer ", auth)
      )
    )

    x <- httr::content(x)

    out <- lapply(1:length(x), function(i){
      x[[i]] |> unlist() |> t() |>  tibble::as_tibble()
    }) |> dplyr::bind_rows() |>
      dplyr::select("xmlFormId", "name")

    return(out)
  }
}

#' Download ODK form data
#' @description
#' Given verified access, project id and form ID, download all data from an
#' ODK form
#' @param url `chr` Target URL for the ODK Central API
#' @param auth `chr` Authorization token to access URL
#' @param project_id `int` Project id from `list_odk_projects()`
#' @param form_id `chr` From id from `list_odk_forms()`
#' @param testing `bool` T/F if you want to just verify that the API if working
#' @returns `tibble` Output of all projects from API call
#' @importFrom utils unzip
download_odk_form <- function(
    url = Sys.getenv("ODK_URL"),
    auth = Sys.getenv("ODK_TOKEN"),
    project_id,
    form_id,
    testing = FALSE
){

  if(testing){
    (httr::GET(
      url = httr::modify_url(url, path = glue::glue("v1/example2"))
    ) |>
      httr::content())$code
  }else{
    tmp_file <- tempfile(fileext = ".csv.zip")

    x <- httr::GET(
      url = paste0(url, "v1/projects/",project_id,
                   "/forms/",form_id,"/submissions.csv.zip"),
      config = httr::add_headers(
        "Authorization" = paste0("Bearer ", auth)
      ),
      httr::write_disk(tmp_file, overwrite = T)
    )

    unzip(tmp_file, exdir = tempdir())

    out <- readr::read_csv(paste0(tempdir(),"/",form_id,".csv"))

    return(out)
  }
}

#' List all users

#' See all users who have access to a form

#' Add online users

#' Add app users

#' Link and unlink users to a form
