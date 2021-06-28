############################################
################ Global.R###################
############################################
# loading data and defining global variables

# Loading libraries
suppressMessages(library("shiny"))
suppressMessages(library("shiny.semantic"))
suppressMessages(library("semantic.dashboard"))
suppressMessages(library("dplyr"))
suppressMessages(library("leaflet"))


# Loading data files
data_dir <- "program/data/"
if(!file.exists(paste0(data_dir, "ships.csv"))) {
    # Unzip the file and save it in csv format for next time.
    g_ships <- vroom::vroom(paste0(data_dir, "ships_04112020.zip"), delim = ",", show_col_types = FALSE)
    vroom::vroom_write(x = g_ships, file = paste0(data_dir, "ships.csv"), delim = ",")
} else {
    # Read the csv file.
    g_ships <- vroom::vroom(paste0(data_dir, "ships.csv"), delim = ",", show_col_types = FALSE)
}

# defining global variables and pre-processing data to reduce latency
g_ships <- g_ships %>% select("LAT", "LON", "SHIPNAME", "DATETIME", "ship_type", "is_parked")  # for current assignment required few datapoints
g_vessels <- unique(g_ships$ship_type)
g_ships_vessels_dt <- g_ships %>% select(SHIPNAME, ship_type) %>% distinct


# sourcing supporting files
support_dir <- "program/functions/"
source(paste0(support_dir, "support_functions.R"), local = TRUE)
source(paste0(support_dir, "support_shipname_module.R"), local = TRUE)
source(paste0(support_dir, "gridTemplate.R"), local = TRUE)
