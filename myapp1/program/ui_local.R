########################################
############ ui_local.R#################
########################################

# File contains ui layout and widgets

ui = semanticPage(includeCSS("program/www/style.css"),
                  grid(grid_template = appGrid,
                       title = div(h3(class="ui primary header", "Demo application"),
                                   h4(class="ui secondary header", "by kartikeya kirar")),
                       panel = fluidRow(box(title = "User Selection",
                                            color = "blue",
                                            width = 5,
                                            ship_selection_ui("shipSelection"))),
                           
                       map = div(class = "ui raised segment",id = "mapContainer",
                                 leafletOutput("distMap", width = "100%", height = "100%")
                                 )
                       ,
                       info = fluidRow(valueBoxOutput("distMax",width = 3),
                                       br(),br(),
                                       valueBoxOutput("totalSailed",width = 3)))
)