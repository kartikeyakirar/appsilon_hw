########################################
############ ui_local.R#################
########################################

# File contains ui layout and widgets

ui = semanticPage(includeCSS("style.css"),
                  grid(grid_template = appGrid,
                       area_style = list(title = "margin: 20px;", panel = "margin: 20px;", info = "margin: 20px;"),
                       title = h2(class = "ui header", icon("ship"), div(class = "content", "SeaRouts")),
                       panel = uiOutput("panelElements"),
                       map = leafletOutput("distMap", width = "100%", height = "100%"),
                       info = div(h4(class="ui horizontal divider header",icon("info circle"), "@about"),
                                  div(class = "ui segment", style = "margin-bottom: 10px","This application is developed by ",br(),
                                  tags$img(src = "/www/developer.png", class = "ui avatar image"),
                                  a(herf = "https://www.linkedin.com/in/kartikeyakirar/", "Kartikey kirar"),
                                  " as part of appsilon assignment. It's built using shiny.semantic and leaflet pacakge"))
))