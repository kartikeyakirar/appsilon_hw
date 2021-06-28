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
            valueBox(value = round(value$maxDistance),
                     subtitle = "Max distance",
                     icon = icon("globe americas"),
                     color = "yellow",size = "tiny")
        })
        
        output$totalSailed <- renderValueBox({
            valueBox(value = round(value$total),
                     subtitle = "Total sailed",
                     icon = icon("map marked"),
                     color = "yellow",size = "tiny"
            )
        })
        
        output$distMap <- renderLeaflet({
            out <- leaflet()
            cord <- value$cordinates
            cord$Position <- c("Begin", "End")
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
}