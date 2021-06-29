########################################
############ server_local.R#############
########################################


server <- function(input, output, session) {
    # Module
    distanceInfo <- callModule(ship_selection_server,
                               "shipSelection")
    
    # Observe and observeEvents
    observeEvent(distanceInfo(), {
        value <- distanceInfo()
        output$distMax <- renderValueBox({
            # checking if distance is character. (condition if ship is parked)
            if(is.character(value$maxDistance)) {
                distVal <- "--"
                subtitle <- value$maxDistance
            } else {
                distVal <- round(value$maxDistance)
                subtitle <- "Max Sailed(Meters)"
            }
            
            valueBox(value = distVal,
                     subtitle = subtitle,
                     icon = icon("map marked"))
        })
        
        output$totalSailed <- renderValueBox({
            # checking if distance is character.
            if(is.character(value$total)) {
                distVal <- "--"
                subtitle <- value$maxDistance
            } else {
                distVal <- round(value$maxDistance)
                subtitle <- "Total sailed (Meters)"
            }
            valueBox(value = distVal,
                     subtitle = subtitle,
                     icon = icon("globe americas")
            )
        })
        
        output$distMap <- renderLeaflet({
            out <- leaflet()
            cord <- value$cordinates
            
            if(nrow(cord) == 1) {
                cord$Position <- "Parked"
            } else {
                cord$Position <- c("Begin", "End")
            }
            
            if (!is.null(value$cordinates)) {
                out <-leaflet(data = cord,
                              options = leafletOptions(minZoom = 0, maxZoom = 12)) %>% addTiles() %>%
                    addMarkers( ~ LON, ~ LAT, popup = ~ Position) %>%
                    addPolylines(lng = ~ LON,
                                 lat =  ~ LAT,
                                 color = "#444444")
            }
            out
        })
    })
    
    output$panelElements <- renderUI({
        grid(grid_template = panelGrid,
             area_styles = list(text = "padding: 10px", widget = "margin: 5px", info1 = "padding-right: 5px",info1 = "padding-left: 5px"),
             text = div(class = "ui segment",p("App calculates maximum distance sailed by ship for slected vessel type and, plots route on map.")),
             widget = ship_selection_ui("shipSelection"),
             info1 = card(style = "border-radius: 0; width: 100%; background: #efefef",
                          valueBoxOutput("distMax")),
             info2 = card(style = "border-radius: 0; width: 100%; background: #efefef",
                          valueBoxOutput("totalSailed")))
    })
}