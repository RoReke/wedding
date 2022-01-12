#' Run the Shiny Application
#'
#' @param ... arguments to pass to golem_opts
#' @inheritParams shiny::shinyApp
#'
#' @export
#' @importFrom shiny shinyApp
#' @importFrom golem with_golem_options
run_app <- function(
  onStart = NULL,
  options = list(), 
  enableBookmarking = NULL,
  ...
) {
  
  shinymanager::set_labels(
    language = "es",
    "Please authenticate" = "Login",
    "Username:" = "Usuario:",
    "Password:" = "Constraseña:"
  )
  
  with_golem_options(
    app = shinyApp(
      ui = shinymanager::secure_app(
        ui = app_ui, 
        language = "es",
        head_auth = golem_add_external_resources(),
        background  = glue::glue("url(\'image.png", "\') no-repeat center top fixed;")
        ),
      server = app_server,
      onStart = onStart,
      options = options, 
      enableBookmarking = enableBookmarking
    ), 
    golem_opts = list(...)
  )
}
