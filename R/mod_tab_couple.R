#' tab_couple UI Function
#'
#' @description A shiny Module.
#'
#' @param id,input,output,session Internal parameters for {shiny}.
#'
#' @noRd 
#'
#' @importFrom shiny NS tagList 
#' @importFrom shinyWidgets setBackgroundImage 
mod_tab_couple_ui <- function(id){
  
  ns <- NS(id)
  
  tagList(
    
    # parent container
    tags$div(class = "landing-wrapper",
             
             # Image fond d'écran
             tags$div(class = "landing-block background-content",
                      
                      img(src = 'image.png'),
                      style = "height: 80vh;"
                      
             ),
             
             # Texte
             tags$div(class = "landing-block foreground-content",
                      tags$div(class = "foreground-text",
                               tags$h1("Guada & Ro", style = "font-family: 'Bauer Bodoni Std 1'; letter-spacing:10px"),
                               tags$p("'The one where we get married...'", style = "font-family: 'MrsEavesItalic'; font-size:45px; letter-spacing:5px"),
                               tags$br(),
                               tags$p("Sábado 26 marzo 17:45 hs.", style = "font-family: 'Bauer Bodoni Std 1'; letter-spacing:3px; font-size: 25px")
                      )
             ),
             
             div(
               textOutput(
                 outputId = ns("decompte_mariage")
               ),
               style = "font-family: 'Bauer Bodoni Std 1'; 
                        font-size:20px; 
                        letter-spacing:3px; 
                        color: black;
                        text-align: center" 
             )  
    )
  )
  
}
    
#' tab_couple Server Functions
#'
#' @noRd 
mod_tab_couple_server <- function(id, r_global){
  
  moduleServer( id, function(input, output, session){
    
    ns <- session$ns
   
    output$decompte_mariage <- renderText({

      get_count_countdown_moments(start_moment = lubridate::now(),
                                  end_moment = "2022-03-26 18:00:00",
                                  text = "Casamiento",
                                  language = "en")
      
    })
    
  })
}
    
## To be copied in the UI
# mod_tab_couple_ui("tab_couple_ui_1")
    
## To be copied in the server
# mod_tab_couple_server("tab_couple_ui_1")
