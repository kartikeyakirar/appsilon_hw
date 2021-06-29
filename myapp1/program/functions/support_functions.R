############################################
################ supporting_functions.R#####
############################################
suppressMessages(library(geosphere))


# Function calculate distance betwwen consecutive points and add in data.frame in feature `distanceMeter`
add_sailed_distance <- function(dat) {
    out <- NULL
    if (!is.null(dat)) {
        out <- dat %>%
            arrange(DATETIME) %>%
            filter(is_parked == 0) %>%
            mutate(distanceMeter = distGeo(p1 = cbind(LON , LAT), p2 =  cbind(lag(LON), lag(LAT)))) %>%
            mutate(distanceMeter = ifelse(is.na(distanceMeter), 0, distanceMeter))
    }
    return(out)
}

# Returns ships names for selected vessel
get_ships_name <- function(dat, vessel) {
    out <- NULL
    if(!is.null(vessel)){
        out <- dat %>%
            filter(ship_type == vessel) %>%
            distinct(SHIPNAME) %>% .$SHIPNAME
    }
    return(out)
}

# Calculate list of sailed information e.g max distance, total distance etc and return in list
get_sailed_info <- function(dat, vessel, ship) {
    info <- list()
    if(!is.null(vessel) && !is.null(ship)){
        # filter data for vessel and shipType
        shipData <- dat %>% 
            filter(ship_type == vessel & SHIPNAME == ship) 
        
        # check if ship is parked
        if(length(which(shipData$is_parked == 0)) > 2) {
            shipData <- shipData %>%
                add_sailed_distance
            
            max_dist <- max(shipData$distanceMeter,na.rm = T)
            
            # calcculating latest max distance sailed
            shipData <- shipData %>%
                mutate(maxDisSailed = (distanceMeter == max_dist))
            max_dist_ind <- which(shipData$maxDisSailed)[1]
            
            # Lat long matrix for max distance
            geo_cordinate <- shipData %>% select(LON,LAT) %>% slice((max_dist_ind-1):max_dist_ind)
            total <- sum(shipData$distanceMeter)
            
        } else {
            
            max_dist <- "Ship is parked"
            total <- "Ship is parked"
            # Lat long matrix for max distance
            geo_cordinate <- shipData %>% select(LON,LAT) %>% slice(nrow(shipData))
        }
        
        info <- list("maxDistance"= max_dist,
                     "cordinates"= as.data.frame(geo_cordinate),
                     "total" = total,
                     "shipdata"= shipData)
    }
    return(info)
}