########################################
############ app grid###################
########################################

appGrid <- grid_template(
    default = list(areas = rbind(c("map", "title"),
                                 c("map", "panel"),
                                 c("map", "info")),
                   cols_width = c("1fr", "400px"),
                   rows_height = c("100px", "auto", "600px")),
    
    mobile = list(areas = rbind("title",
                                "panel",
                                "info",
                                "map"),
                  rows_height = c("50px", "200px", "auto", "100px"),
                  cols_width = c("97%"))
)