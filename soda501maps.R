setwd("I:/_Spring2018/SoDA501")
setwd("I:/_Spring2018/SoDA501/someMaps")

library(rjson)
library(jsonlite)
library(dplyr)
library(tidyr)
library(ggplot2)
library(mapproj)
library(rgdal)
library(ggmap)
library(scales)
library(devtools)
library(stringr)
library(mapdata)
library(maps)

library(RColorBrewer)
library(sp)
library(mapview)



## Map USA
ggplot() + geom_polygon(data = usa, aes(x=long, y = lat, group = group)) + 
  +     coord_fixed(1.3) 


ggplot() + 
  geom_polygon(data = usa, aes(x=long, y = lat, group = group), fill = NA, color = "red") + 
  coord_fixed(1.3)



## State Maps
states <- map_data("state")
ggplot(data = states) + 
  geom_polygon(aes(x = long, y = lat, fill = region, group = group), color = "white") + 
  coord_fixed(1.3) +
  guides(fill=FALSE) 


few_states = subset(states, region %in% c("nevada", "pennsylvania", "wisconsin"))

ggplot(data = few_states) + 
  geom_polygon(aes(x = long, y = lat, group = group), fill = "palegreen", color = "black") + 
  coord_fixed(1.3)



## Zoom in Nevada

nv = subset(states, region == "nevada")
counties = map_data("county")
nv_counties = subset(counties, region == "nevada")

nv_base <- ggplot(data = nv, mapping = aes(x = long, y = lat, group = group)) + 
  coord_fixed(1.3) + 
  geom_polygon(color = "black", fill = "lightgray")

nv_base + theme_nothing()


nv_base + theme_nothing() + 
  geom_polygon(data = nv_counties, fill = NA, color = "white") +
  geom_polygon(color = "black", fill = NA) 


#### ggmap


sbbox = make_bbox(lon = LasVegas$longitude, lat = LasVegas$latitude, f = .1)
sbmap = get_map(location = sbbox, maptype = "roadmap", source = "google")
ggmap(sbmap) + geom_point(data = LasVegas, mapping = aes(x = LasVegas$longitude, y = LasVegas$latitude, size = review_count, colour = stars))


sbbox = make_bbox(lon = Pitts$longitude, lat = Pitts$latitude, f = .1)
sbmap = get_map(location = sbbox, maptype = "roadmap", source = "google")
ggmap(sbmap) + geom_point(data = Pitts, mapping = aes(x = Pitts$longitude, y = Pitts$latitude, size = review_count, colour = stars))



sbbox = make_bbox(lon = Madison$longitude, lat = Madison$latitude, f = .1)
sbmap = get_map(location = sbbox, maptype = "roadmap", source = "google")
ggmap(sbmap) + geom_point(data = Madison, mapping = aes(x = Madison$longitude, y = Madison$latitude, size = review_count, colour = stars))









pittsburgh = "University of Pittsburgh"
qmap(pittsburgh, zoom = 14)



ggplot(LasVegas, aes(x= longitude, y = latitude, color = stars)) +
  borders("world", color = "gray80", fill = "gray40") +
  geom_point(alpha = .6) + 
  


# cols = colorRampPalette(brewer.pal(9, "Blues"))
# 
# mapview(LasVegas, zcol = "stars", cex = "stars", color = "black", fillColor = cols(100), alpha.regions = .8) + sbmap






map <- get_googlemap('las vegas', zoom = 11)
ggmap(map, extent = 'device') + geom_point(data = LasVegas, mapping = aes(x = LasVegas$longitude, y = LasVegas$latitude, size = review_count, fill = stars), shape=20.5, alpha=0.9)


map <- get_googlemap('madison', zoom = 12)
ggmap(map, extent = 'device') + geom_point(data = Madison, mapping = aes(x = Madison$longitude, y = Madison$latitude, size = stars.x, fill = stars.x), shape=21, alpha=0.8)



map <- get_googlemap("pittsburgh", zoom = 12, marker = data.frame(Pitts$longitude, Pitts$latitude), scale = 2, maptype = "roadmap")
ggmap(map, extent = 'device')






#jsonFile <- fromJSON("business.json", pretty = TRUE)

# business = readLines("business.json")
# business2 = as.data.frame(t(sapply(business, fromJSON)))
# View(business2)
# 
# ### business_new = business_new[, c(57, 1, 97, 80, 6, 69, 65, 18, 96, 71, 49, 8, 43, 36, 51, 53, 58, 82, 89, 93, 2:5, 7, 9:17, 19:35, 37:42, 44:48, 50, 52, 54:56, 59:64, 66:68, 70, 72:79, 81, 83:88, 90:92, 94, 95, 98:101)]
# 

# 

#business = read.csv("business.csv")
#business = business[, c(85, 5, 46, 18, 28, 54, 37, 30, 81, 74, 41, 43, 67, 77, 65, 29, 38, 40, 34, 35, 1:4, 6:17, 19:27, 31:33, 36, 39, 42, 44, 45, 47:53, 55:64, 66, 68:73, 75, 76, 78, 79, 80, 82:84, 86:101)]
#write.csv(business, "business_new.csv")
#review = read.csv("review.csv")
#business = read.csv("business_new.csv")

#### Parsing

# business = business %>% separate(state, c("junk", "State_"),"b'", extra = "merge")
# business = business %>% separate(State_, c("state", "junk"),"'", extra = "merge")
# 
# business = business %>% separate(city, c("junk", "city_"),"b'", extra = "merge")
# business = business %>% separate(city_, c("city",  "junk" ),"'", extra = "merge")
# 
# business = business %>% separate(business_id, c("junk", "business_id_"),"b'", extra = "merge")
# business = business %>% separate(business_id_, c("business_id",  "junk" ),"'", extra = "merge")
# 
# business_pa = business[which(business$state == "PA"),]
# business_ca = business[which(business$state == "CA"),]
# business_fl = business[which(business$state == "FL"),]
# business_ga = business[which(business$state == "GA"),]
# 
# 
# 
# #business1 = business %>% separate(name, c("junk", "name_"),"b'", extra = "merge") %>% separate(name_, c("name",  "junk" ),"'", extra = "merge") %>% separate(neighborhood, c("junk", "neighborhood_"),"b'", extra = "merge") %>% separate(neighborhood_, c("neighborhood",  "junk" ),"'", extra = "merge") %>% separate(address, c("junk", "address_"),"b'", extra = "merge") %>% separate(address_, c("address",  "junk" ),"'", extra = "merge") %>% separate(address, c("junk", "address_"),"b'", extra = "merge") %>% separate(address_, c("address",  "junk" ),"'", extra = "merge")
# 
# business1 = business %>% separate(postal_code, c("junk", "postal_code_"),"b'", extra = "merge") 
# business1 = business1 %>% separate(postal_code_, c("postal_code", "junk"),"'", extra = "merge") 
# 
# 
# 

projectData = read.csv("MAD_PITT_LAS_info.csv")

# NYT
NYT <- read.csv(file ="data/NYT.csv") %>%
  mutate(date = as.Date(date)) %>%
  mutate(Dataset = "NYT")

# SWB
SWB<- read.csv(file ="data/SWB.csv") %>%
  mutate(date = as.Date(date)) %>%
  mutate(Dataset = "SWB")

# FBIS
FBIS <- read.csv(file ="data/FBIS.csv") %>%
  mutate(date = as.Date(date)) %>%
  mutate(Dataset = "FBIS")

# ICEWS
ICEWS <- read.csv(file ="data/ICEWS.csv") %>%
  mutate(date = as.Date(date)) %>%
  mutate(Dataset = "ICEWS") %>%
  rename(cameo.root = quad_class)


# Manually set colors for event types, called in ggmap later
event.color <- c("Neutral" = "gray60", 
                 "Verbal cooperation" = "steelblue1",
                 "Material cooperation"  = "dodgerblue3", 
                 "Verbal conflict" = "salmon1", 
                 "Material conflict" = "firebrick2")


# store our color scheme for the different sources
source.color <- c("NYT" = "dodgerblue3", 
                  "SWB" = "darkorchid",
                  "FBIS" = "cyan4", 
                  "ICEWS" = "firebrick")


ggplot(SWB, aes(x = lon, y = lat, color = cameo.root )) +
  
  borders("world", color = "gray80", fill = "gray40") +
  
  # plot the points
  geom_point(alpha = .6) + 
  
  # Assign our color scheme
  scale_color_manual(name = "Event Type", values = event.color) +
  
  # This resent the alpha to make the legend legible
  guides(color = guide_legend(override.aes = list(alpha = 1)))+
  
  # ggplot map coordinate transform 
  coord_map(projection = "ortho", orientation = c( 45, 80, 0 ))  +
  
  # Change the labels to be a little intuitive
  labs( title = "SWB Events", 
        x = "Degrees East/West",
        y = "Degrees North/South")


### Data with distinct business ID 
#LasVegas = projectData %>% filter(city == "Las Vegas" & state == "NV") %>% distinct(business_id, .keep_all = T)
#Pitts = projectData %>% filter(city == "Pittsburgh" & state == "PA") %>% distinct(business_id, .keep_all = T)
#Madison = projectData %>% filter(city == "Madison" & state == "WI") %>% distinct(business_id, .keep_all = T)

# write.csv(LasVegas, "LasVegas.csv")
# write.csv(Pitts, "Pitts.csv")
# write.csv(Madison, "Madison.csv")

LasVegas = read.csv("LasVegas.csv")
Pitts = read.csv("Pitts.csv")
Madison = read.csv("Madison.csv")



