#' tab_place UI Function
#'
#' @description A shiny Module.
#'
#' @param id,input,output,session Internal parameters for {shiny}.
#'
#' @noRd 
#'
#' @importFrom shiny NS tagList 
mod_tab_place_ui <- function(id){
  
  ns <- NS(id)
  
  url_map <- a("Link Google Map", href="https://www.google.com/maps/place/Chacra+Tal%C3%B3/@-34.3798936,-59.0225015,15z/data=!4m5!3m4!1s0x0:0xb320b7e9c1f9dac6!8m2!3d-34.3798936!4d-59.0225015")
  
  tagList(
    
    tags$br(style = "line-height: 80px"),
    
    fluidRow(
      
      column(
        width = 6,
        tags$div(img(src = "www/bellenoe.jpg", height = "500px"), style = "text-align: center"),
        tags$br(style = "line-height: 20px"),
        tags$p("Chacra Taló", style = "font-family: \'Bauer Bodoni Std 1\'; font-size: 30px; letter-spacing:3px; text-align: center"),
        tags$p("Calle Carlos Lemee y Ruta 6,", style = "font-family: \'Bauer Bodoni Std 1\'; font-size: 20px; letter-spacing:3px; text-align: center"),
        tags$p("Los Cardales, Prov. Buenos Aires.", style = "font-family: \'Bauer Bodoni Std 1\'; font-size: 20px; letter-spacing:3px; text-align: center")
        ),
      
      column(
        width = 6,
        align = "center",
        leafletOutput(
          outputId = ns("carte_belle_noe"),
          height = 400,
          width = 600
        ),
        tags$br(style = "line-height: 20px"),
        tags$p(url_map, style = "font-family: \'Bauer Bodoni Std 1\'; font-size: 30px; letter-spacing:3px; text-align: center")
        
        
        
      )
    ),
    
    # Parking
    tags$br(style = "line-height: 80px"),
    
     
    tags$br(style = "line-height: 80px"),
    
    # Hébergements
    fluidRow(
      
      column(
        offset = 4,
        width = 8,
        tags$div(img(src = "www/bellenoe_dortoir.jpg"), 
                 style = "text-align: center"),
      )
      
    ),
    
    tags$br(style = "line-height: 80px"),
    
    # Salon des enfants
    fluidRow(
      
      column(
        width = 6,
        tags$div(img(src = "www/chacratalo2.jpeg"), 
                 style = "text-align: center"),
      ),
      
      column(
        width = 6,
        tags$br(style = "line-height: 120px"),
        tags$p("Ingreso Vehicular", style = "font-family: \'Bauer Bodoni Std 1\'; font-size: 30px; letter-spacing:3px; text-align: center"),
        tags$p("El ingreso se realiza a través de una bóveda de árboles", style = "font-family: \'MrsEavesItalic\'; letter-spacing:3px; text-align: center")
      )
        
    )
 
  )
}
    
#' tab_place Server Functions
#'
#' @noRd 
mod_tab_place_server <- function(id, r_global){
  
  moduleServer( id, function(input, output, session){
    
    ns <- session$ns
    
    output$carte_belle_noe <- renderLeaflet({
      
      get_map_wedding(
        data_markers = tibble(
          longitude = -59.0223298386258,  
          latitude = -34.37904355083765,
          name = "Chacra Taló"),
          zoom = 13,
        icon_markers = "heart"
      )
                            
    })
 
  })
}
    
## To be copied in the UI
# mod_tab_place_ui("tab_place_ui_1")
    
## To be copied in the server
# mod_tab_place_server("tab_place_ui_1")
