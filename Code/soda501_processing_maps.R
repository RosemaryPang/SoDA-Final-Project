setwd("I:/_Spring2018/SoDA501")
setwd("I:/_Spring2018/SoDA501/Project")
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

################################### Starts: Maps that go into Appendix: Figure 1, 2, and 3. ##########################
#### Data Input 

LasVegas = read.csv("LasVegas.csv")
Pitts = read.csv("Pitts.csv")
Madison = read.csv("Madison.csv")

names(LasVegas)[16] = "Star Ratings"
names(LasVegas)[17] = "No. of Reviews"

names(Pitts)[16] = "Star Ratings"
names(Pitts)[17] = "No. of Reviews"

names(Madison)[16] = "Star Ratings"
names(Madison)[17] = "No. of Reviews"


#### ggmap


sbbox = make_bbox(lon = LasVegas$longitude, lat = LasVegas$latitude, f = .1)
sbmap = get_map(location = sbbox, maptype = "roadmap", source = "google")
ggmap(sbmap) + geom_point(data = LasVegas, mapping = aes(x = LasVegas$longitude, y = LasVegas$latitude, size = `No. of Reviews`, colour = `Star Ratings`))


sbbox = make_bbox(lon = Pitts$longitude, lat = Pitts$latitude, f = .1)
sbmap = get_map(location = sbbox, maptype = "roadmap", source = "google")
ggmap(sbmap) + geom_point(data = Pitts, mapping = aes(x = Pitts$longitude, y = Pitts$latitude, size = `No. of Reviews`, colour = `Star Ratings`))



sbbox = make_bbox(lon = Madison$longitude, lat = Madison$latitude, f = .1)
sbmap = get_map(location = sbbox, maptype = "roadmap", source = "google")
ggmap(sbmap) + geom_point(data = Madison, mapping = aes(x = Madison$longitude, y = Madison$latitude, size = `No. of Reviews`, colour = `Star Ratings`))

################################### Ends: Maps that go into Appendix: Figure 1, 2, and 3. ##########################




### **************************** Other stuff that didn't go into the report directly, 
### but these are codes for data processing and for comparing maps from different R packages ******************************
###*****************************************************************************************************************##########


##################### Other Maps to check out, but didn't go into the report ################################################# 

Sys.setenv("plotly_username"="arifmasrur")
Sys.setenv("plotly_api_key"="IOZp8DGb7E1ti9gpvc1j")

#### Try Mapping with Plotly

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


############################################# Some Data Processing for Maps ####################################################

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


projectData = read.csv("MAD_PITT_LAS_info.csv")

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


# dim(LasVegas)
# length(unique(Pitts$business_id))


library(plotly)

# Pitts = read.csv("Pitts.csv")
# Pitts$stars.x = as.character(Pitts$stars.x)
# 
# g <- list(
#   scope = 'pittsburg',
#   projection = list(type = 'albers usa'),
#   showland = TRUE,
#   landcolor = toRGB("gray85"),
#   subunitwidth = 1,
#   countrywidth = 1,
#   subunitcolor = toRGB("white"),
#   countrycolor = toRGB("white")
# )
# 
# 
# p <- plot_geo(Pitts, locationmode = 'Pittsburg', sizes = c(1, 250)) %>%
#   add_markers(
#     x = ~longitude, y = ~latitude, size = ~review_count.x, color = ~q, hoverinfo = "text",
#     text = ~paste(Pitts$name.x, "<br />", Pitts$review_count.x, " reviews")
#   ) %>%
#   layout(title = 'Yelp Review<br>(Click legend to toggle)', geo = g)
# 
# chart_link = api_create(p, filename="yelp review")
# chart_link


####### Census Data Processing 

ACS_data = read.csv("ACS_2016_5yr_pov_race_allcities.csv")
ACS_data = read.csv("ACS_2016_5yr_pov_race_allcities_New.csv") 

ACS_vegas = ACS_data[, c(1:6)]
write.csv(ACS_vegas, "ACS_vegas.csv")
ACS_Pitts = ACS_data[, c(13:18)]
write.csv(ACS_Pitts, "ACS_Pitts.csv")
ACS_Mad = ACS_data[, c(7:12)]
write.csv(ACS_Mad, "ACS_Mad.csv")

ACS_vegas = read.csv("ACS_vegas.csv")
ACS_Pitts = read.csv("ACS_Pitts.csv")
ACS_Mad = read.csv("ACS_Mad.csv")

tract_PA = readOGR(dsn = ".", layer = "Allegheny_County_Census_Tracts_2016")
tract_PA@data$GEOID = as.character(tract_PA@data$GEOID)

## Pitts
data_PA = read.csv("ACS_Pitts.csv", stringsAsFactors = FALSE)
data_PA = data_PA %>% rename(GEOID = GEO.id2.pitt, Pct_BPL = HC03_EST_VC01.2, WhitePop = HD01_VD02.1, BlackPop = HD01_VD03.2, TotPop = HC01_EST_VC01.2)
data_PA$GEOID = as.character(data_PA$GEOID)
data_PA = data_PA[-1,]
rownames(data_PA) = c()
data_PA = data_PA[, -1]
data_PA = data_PA[-c(403:487),]

## LasVegas
data_LV = read.csv("ACS_vegas.csv", stringsAsFactors = FALSE)
data_LV = data_LV  %>% rename(GEOID = GEO.id2.vegas, Pct_BPL = HC03_EST_VC01, WhitePop = HD01_VD03, BlackPop = HD01_VD04, TotPop = HC01_EST_VC01)
data_LV$GEOID = as.character(data_LV$GEOID)
data_LV  = data_LV[-1,]
rownames(data_LV) = c()
data_LV  = data_LV[, -1]

## Madison
data_mad = read.csv("ACS_Mad.csv", stringsAsFactors = FALSE)
data_mad = data_mad  %>% rename(GEOID = GEO.id2.Mad, Pct_BPL = HC03_EST_VC01.1, WhitePop = HD01_VD02, BlackPop = HD01_VD03.1, TotPop = HC01_EST_VC01.1)
data_mad$GEOID = as.character(data_mad$GEOID)
data_mad  = data_mad[-1,]
rownames(data_mad) = c()
data_mad = data_mad[, -1]
data_mad = data_mad[-c(108:487),]


write.csv(data_LV, "ACS_vegas.csv")
write.csv(data_PA, "ACS_Pitts.csv")
write.csv(data_mad, "ACS_Mad.csv")

ACS_vegas = read.csv("ACS_vegas.csv")
ACS_Pitts = read.csv("ACS_Pitts.csv")
ACS_Mad = read.csv("ACS_Mad.csv")

ACS_Pitts$GEOID = as.character(ACS_Pitts$GEOID)
write.csv(ACS_Pitts, "ACS_Pitts.csv")

library(maptools)
ggtract_PA = fortify(tract_PA, region = "GEOID") 

# join tabular data
#ggtract_PA = left_join(ggtract_PA, data_PA, by=c("id")) 
ggtract_PA = merge(ggtract_PA, data_PA, by="id") 


#ggtract_PA = ggtract_PA[grep("Allegheny", ggtract$NAME),]

ggplot() +
  geom_polygon(data = ggtract_PA , aes(x=long, y=lat, group = group, fill=WhitePop), color="grey50") +
  scale_fill_gradientn(colours = c("red", "white", "cadetblue")) +
  coord_map(xlim = c(-80.36, -79.70), ylim = c(40.28,40.67))


# ggplot() +
#   geom_map(data = ggtract_PA, map = ggtract_PA, aes(x=long, y=lat, map_id = id), color="grey50", size = 0.1, fill = NA) 
# 

ditch_the_axes <- theme(
  axis.text = element_blank(),
  axis.line = element_blank(),
  axis.ticks = element_blank(),
  panel.border = element_blank(),
  panel.grid = element_blank(),
  axis.title = element_blank()
)

Pitts_base <- ggplot(data = ggtract_PA, mapping = aes(x = long, y = lat, group = group)) + 
  coord_fixed(1.3) + 
  geom_polygon(color = "black", fill = "gray")
Pitts_base 


Pitts_base  + geom_polygon(data = ggtract_PA, aes(fill = Pct_BPL), color = "white") + 
  guides(fill=FALSE) + 
  labs(x = "Longitude", y = "Latitude") + 
  scale_fill_gradient2(colours = rev(rainbow(5)), breaks = c(20, 40, 60, 80, 100))


### Another way

p = colorRampPalette(c("white", "red"))(128)
palette(p)
pop = ggtract_PA$Pct_BPL
cols = pop 
plot(tract_PA, col = cols)


p = colorRampPalette(brewer.pal(11, "Spectral"))(128)
palette(rev(p))
plot(tract_PA, col = cols)


### Using ggmap
points = fortify(tract_PA, region = "GEOID" )
pittsburgh = qmap("Pittsburgh, Pennsylvania", zoom = 10)

pittsburgh + geom_polygon(aes(x = long, y = lat, group = group, fill = Pct_BPL), data = ggtract_PA, color = 'black')+ guides(fill=FALSE) + scale_alpha(range=c(0.25,0.5))

##### Try Kernel Density Estimation #####

library("KernSmooth")
library("raster")

ACS_Pitts = read.csv("ACS_Pitts.csv")
output = "pitts_review_density.asc"

###### ############################################## Contour and Density Layers ##############################################
Pitts1 = Pitts[, c(14, 15, 17)]

library(ggmap)
pittsburg = c(lon = -80.026, lat = 40.439)

pittsburg.map =  get_map(location = pittsburg, maptype = "roadmap", zoom = 11, color = "bw")

ggmap(pittsburg.map, extent = "panel", maprange = FALSE) + geom_density2d(data = Pitts1, aes(x = longitude, y = latitude)) +
  stat_density2d(data = Pitts1, aes(x = longitude, y = latitude, fill = ..level.., alpha = ..level..), size = 0.01, bins = 16, geom = 'polygon') +
  scale_fill_gradient(low = "green", high = "red") +
  scale_alpha(range = c(0.00, 0.25), guide = FALSE) +
  theme(legend.position = "none", axis.title = element_blank(), text = element_text(size = 12))



