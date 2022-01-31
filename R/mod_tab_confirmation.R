#' tab_confirmation UI Function
#'
#' @description A shiny Module.
#'
#' @param id,input,output,session Internal parameters for {shiny}.
#' 
#' @importFrom readr read_csv locale
#' @import shinyvalidate
#' @import shinyjs
#' @noRd 
#'
#' @importFrom shiny NS tagList 
#' @importFrom shinyjs useShinyjs
mod_tab_confirmation_ui <- function(id){
  
  ns <- NS(id)
  
  tagList(
 
    useShinyjs(),
    
    fluidRow(
      align = "center",
      tags$br(style = "line-height: 65px"),
      h1("Confirmar asistencia", style = "font-family: \'Bauer Bodoni Std 1\'; font-size:30px; letter-spacing:5px; color: black; text-align: center"),
      h1("Ingrese en el formulario sus elecciones", style = "font-family: \'Bauer Bodoni Std 1\'; font-size:15px; letter-spacing:2px; color: black; text-align: center"),
      tags$br(style = "line-height: 40px"),
    ),
    
    sidebarLayout(
      
      sidebarPanel(
        
        width = 6,
        selectizeInput(
          inputId = ns("name"),
          label   = HTML("Nombre:"),
          choices = NULL,
          selected  = character(0),
          options = list(
            placeholder = "Elegir nombre...",
            onInitialize = I('function() { this.setValue(""); }'),
            maxItems    = 1
          )
        ),

        tags$br(style = "line-height: 20px"),
        
        #tags$p("Pr\u00e9sence aux diff\u00e9rents moments du mariage", style = "font-size:15px; letter-spacing:3px; font-weight: bold; color: black"),
         
        
        tags$br(style = "line-height: 20px"),
        
        textInput(
          inputId = ns("special_diet"),
          label = "Dieta especial (alergias/intolerancias alimentarias, dieta para embarazadas, etc.))",
          placeholder = "Indique aquí los planes"
        ),
        selectInput(
          inputId = ns("principal"),
          label = "Elija su opción de menú principal: ",
          choices = c("Ravioli Longo (Nuez, provolone, ricota, nuez moscada y mozzarella)", "Risotto cuatro quesos de portobellos y hongos de pino al malbec")
        ),
        fileInput(
          inputId = ns("file"), 
          label = "Subir Certificado de Vacunación",
          multiple = FALSE,
          accept = c(".pdf")
        ),
        
        
        uiOutput(ns("show_input_teens_menu")),
      
        uiOutput(ns("show_input_kids_menu")),
        
        tags$br(style = "line-height: 20px"),
        
        actionButton(
          inputId = ns("save_info_guest"),
          label = "Guardar mis opciones*"
        ),
        
        tags$br(style = "line-height: 20px"),
        
        tags$p("*Podrá realizar la operación nuevamente para agregar una nueva persona", style = "font-size:15px; letter-spacing:3px; color: black"),
        
      ),
      
      mainPanel(
        
        width = 6,
        
        h1("Resumen de su información", style = "font-size:20px"),
        
        tags$br(style = "line-height: 20px"),
        
        tableOutput(ns("summary_info_guest")),
        
        tags$br(style = "line-height: 20px"),
        
        fluidRow(
          align = "center",
          column(
            width = 6,
            actionButton(
              inputId = ns("clean_last_info_guest"),
              label = "Eliminar la última información guardada"
            )
          ),
          column(
            width = 6,
            actionButton(
              inputId = ns("send_info_guest"),
              label = "Enviar mis elecciones a los novios"
            )
          )
        )
        
      )
      
  )
  )
  
}
    
#' tab_confirmation Server Functions
#' 
#' @importFrom shinyjs reset hide
#' @importFrom tibble add_row
#' @importFrom dplyr top_n distinct pull filter left_join arrange bind_rows group_by
#' @importFrom purrr map_dfr
#'
#' @noRd 
mod_tab_confirmation_server <- function(id, r_global){
  
  moduleServer( id, function(input, output, session){
    
    ns <- session$ns
    
    # Local reactive values - stay in the module
    r_local <- reactiveValues()
    
    r_local$info <- tibble(
      name = character(),
      special_diet = character(),
      menu_dinner = character()
      )
    
    observeEvent(input$name, {
      req(input$name)
      type <- r_global$data_guests %>% filter(name == input$name) %>% pull(type)
      if (type == "Kid") {
        updateSelectInput(
          session = session,
          inputId = "principal",
          choices = c("Menú Infantil", "Ravioli Longo (Nuez, provolone, ricota, nuez moscada y mozzarella)", "Risotto cuatro quesos de portobellos y hongos de pino al malbec"),
          selected = character(0)
        )
      } else {
        updateSelectInput(
          session = session,
          inputId = "principal",
          choices = c("Ravioli Longo (Nuez, provolone, ricota, nuez moscada y mozzarella)", "Risotto cuatro quesos de portobellos y hongos de pino al malbec"),
          selected = character(0)
        )
      }
    }, ignoreInit = TRUE)
    # Update input list guest according to data
    observeEvent(TRUE, once = TRUE, {

      updateSelectizeInput(
        session = session,
        inputId = "name",
        choices = c(r_global$data_guests %>% distinct(name) %>% pull())
        )

    })
    
    # Find info about guest in data and update selectinput menu according to guest type adult/teen/kid
    # observeEvent(input$name, ignoreInit = TRUE, {
    # 
    #   req(input$name != "Choisir dans la liste la personne")
    #   req(r_global$data_guests)
    # 
    #   r_local$type_guest <- r_global$data_guests %>%
    #     filter(name == input$name) %>%
    #     pull(type)
    # 
    #   if (r_local$type_guest == "Ado") {
    # 
    #     output$show_input_teens_menu <- renderUI({
    # 
    #       selectInput(
    #         inputId = ns("teens_menu"),
    #         label = "Menu pour le d\u00eener - le menu adulte contient du foie gras et du canard",
    #         choices = c("Menu adulte", "Menu enfant"),
    #         selected = "Menu adulte"
    #       )
    #       
    #     })
    #     
    #     shinyjs::hide(id = "kids_menu")
    # 
    #   } else if (r_local$type_guest == "Enfant") {
    # 
    #     output$show_input_kids_menu <- renderUI({
    # 
    #       selectInput(
    #         inputId = ns("kids_menu"),
    #         label = "Choix pour les repas (cocktail, d\u00eener, retour)",
    #         choices = c("Menu enfant", "Pas de repas \u00e0 pr\u00e9voir pour mon bibou"),
    #         selected = "Menu enfant"
    #       )
    # 
    #     })
    #     
    #     shinyjs::hide(id = "teens_menu")
    #     
    #   } else {
    #     
    #     shinyjs::hide(id = "kids_menu")
    #     shinyjs::hide(id = "teens_menu")
    #     
    #   }
    #   
    # })
    
    # Click on save choice / add info to sumamry tibble
    observeEvent(input$save_info_guest, {
      
      iv$enable()
      if (!iv$is_valid()) {
        showNotification(
          ui = "Por favor complente el formulario",
          type = "error"
        )
        req(FALSE)
      }
      
      r_local$name <- input$name
      r_local$special_diet <- input$special_diet
      r_local$principal <- input$principal
      
      r_local$info <- r_local$info %>% 
        add_row(
          name = r_local$name,
          special_diet = r_local$special_diet,
          menu_dinner    = r_local$principal
          )
      
      googledrive::drive_upload(
        media = input$file$datapath,
        path = "Certificados Vacuna",
        name = glue::glue("Certificado_{r_local$name}.pdf")
      ) 
      
      iv$disable()
      reset("file")
      reset("name")
      reset("special_diet")
      reset("principal")
    })
    
    # Delete last line
    observeEvent(input$clean_last_info_guest, {
     
      r_local$info <- r_local$info[-nrow(r_local$info),]
      
    })
    
    # Table summarising info
    output$summary_info_guest <- renderTable({
      
      r_local$info %>% 
        rename(
          stats::setNames(c("name", "special_diet", "menu_dinner"), 
                          c("Nombre", "Dieta Especial", "Menú Principal") 
          )
        )
    })
    
    # Save info
    observeEvent(input$send_info_guest, {
      
      # vec_guests_to_send <- r_local$info %>% 
      #   pull(name)
      # 
      # if (any(vec_guests_to_send %in% vec_guests_already_answer)) {
      #   
      #   showNotification(
      #     ui = "Parte de la información ya se había enviado a los novios. Los datos han sido reemplazados por los que acaba de ingresar.",
      #                    type = "default")
      #   
      # }
      # 
      # # Verify if there are doubles - if yes, delete them
      # 
      # if (any(duplicated(vec_guests_to_send))) {
      #   
      #   showNotification(
      #     ui = "Ha ingresado información duplicada para la misma persona. Sólo se conservarán los últimos.",
      #     type = "default"
      #     )
      #   
      #   r_local$info <- r_local$info %>% 
      #     group_by(name) %>% 
      #     top_n(1)
      #   
      # }
      # Construct the new database
      r_global$data_guests <- add_info_guests_in_database(
        info_to_add = r_local$info,
        data_guests = r_global$data_guests
        )
      
      # Show notification
      showNotification(
        ui = "Su información ha sido enviada a los novios.",
        type = "message"
        )
      # Upload the new database
      temp_dir <- tempdir()
      readr::write_csv(r_global$data_guests, glue::glue(temp_dir, "/new_data_guests.csv"))
      googledrive::drive_update("data_invitados", glue::glue(temp_dir, "/new_data_guests.csv"))
      
    })
    
    #validacion 
    iv <- InputValidator$new()
    iv$add_rule("name", sv_required(message = ""))
    iv$add_rule("principal", sv_required())
    iv$add_rule("file", sv_required(message = "Ingresar Certificado"))
    
  })
  
}
    
## To be copied in the UI
# mod_tab_confirmation_ui("tab_confirmation_ui_1")
    
## To be copied in the server
# mod_tab_confirmation_server("tab_confirmation_ui_1")
