#' tab_schedule UI Function
#'
#' @description A shiny Module.
#'
#' @param id,input,output,session Internal parameters for {shiny}.
#'
#' @noRd 
#'
#' @importFrom shiny NS tagList 
mod_tab_schedule_ui <- function(id){
  
  ns <- NS(id)
  
  tagList(
 
    tags$div(class = "landing-block foreground-content",
             tags$div(class = "foreground-text",
                      tags$br(style = "line-height: 80px"),
                      tags$p("Tu presencia va a ser el mejor regalo", style = "font-family: \'Bauer Bodoni Std 1\'; font-size: 30px; letter-spacing:5px; text-align: center"),
                      tags$p("pero si aún querés hacernos un obsequio ", style = "font-family: \'Bauer Bodoni Std 1\'; font-size: 30px; letter-spacing:5px; text-align: center"),
                      tags$p("esta es nuestra cuenta:  ", style = "font-family: \'Bauer Bodoni Std 1\'; font-size: 30px; letter-spacing:5px; text-align: center"),
                      tags$p("Alias : MIEL.ORGANO.SALA", style = "font-family: \'MrsEavesItalic\'; letter-spacing:3px; text-align: center"),
                      tags$p("CBU : 0170081740000049032789", style = "font-family: \'MrsEavesItalic\'; letter-spacing:3px; text-align: center"),
                      tags$p("Titular : Rodrigo Requejo", style = "font-family: \'MrsEavesItalic\'; letter-spacing:3px; text-align: center"),
                      
             )
    )
    
  )
}
    
#' tab_schedule Server Functions
#'
#' @noRd 
mod_tab_schedule_server <- function(id, r_global){
  
  moduleServer( id, function(input, output, session){
    
    ns <- session$ns
 
  })
}
    
## To be copied in the UI
# mod_tab_schedule_ui("tab_schedule_ui_1")
    
## To be copied in the server
# mod_tab_schedule_server("tab_schedule_ui_1")
