############################################
######## support_shipname_module.R##########
############################################

#### module function
########################################
############ support_shipname_module.R##
########################################
# UI
ship_selection_ui <- function(id) {
    ns <- NS(id)
    tagList(selectInput(inputId = ns("vesseltype"),
                        label = "Select vessel",
                        choices = g_vessels,
                        multiple = FALSE,
                        width = "100%"),
            br(),br(),
            selectizeInput(inputId = ns("shipname"),
                           choices = NULL,
                           label = "Select ship",
                           selected = NULL,
                           width = "100%"))
}

# Server
ship_selection_server <- function (input, output, session) {
    value <- reactiveVal()
    observeEvent(input$vesseltype,{ 
        ships <- get_ships_name(g_ships_vessels_dt, input$vesseltype)
        updateSelectizeInput(session = session,
                             inputId = "shipname",
                             choices = ships,
                             server = TRUE)
    })
    
    observeEvent(input$shipname, {
        
        if (!is.null(input$shipname) && input$shipname != "") {
            value(get_sailed_info(g_ships, input$vesseltype, input$shipname))
        }
    })
    
    return(value)
    
}

    