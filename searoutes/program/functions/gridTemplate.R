########################################
############ app grid###################
########################################

# application grid
appGrid <- grid_template(
    default = list(areas = rbind(c("map", "title"),
                                 c("map", "panel"),
                                 c("map", "info")),
                   cols_width = c("1fr", "400px"),
                   rows_height = c("50px", "auto", "200px")),
    mobile = list(areas = rbind("title",
                                "panel",
                                "info",
                                "map"),
                  rows_height = c("50px", "auto", "100px", "300px"),
                  cols_width = c("100%"))
)

# sidepanel grid
panelGrid <- grid_template(
    default = list(areas = rbind(c("text", "text"),
                                 c("widget", "widget"),
                                 c("info1", "info2")),
    cols_width = c("50%", "50%"),
    rows_height = c("150px", "200px", "auto")
))