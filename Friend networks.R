##### Network Analysis #####

Fulldata <- read.csv("MAD_PITT_LAS_info.csv") # Read merged data
variable <- c("user_id","name.y",
              "review_count.y","average_stars","friends","elite","fans","useful.y","funny.y","cool.y",
              "compliment_photos","compliment_note","compliment_hot","compliment_list","compliment_writer",
"compliment_plain","compliment_cool","compliment_more","compliment_funny","compliment_cute","compliment_profile") # Keep user related variables
User <- Fulldata[variable] # Only user data, this is for network
User_unique <-User[!duplicated(User[,c("user_id")]),] # Only keep unique users
write.csv(User_unique,"User_unique.csv")

library(igraph)

#lets download data

friends = read.csv("User_unique.csv")

friends$user_id = as.factor(friends$user_id)
friends$friends = as.factor(friends$friends)

friendedgemat = cbind(friends$user_id, friends$friends)

edge = graph_from_edgelist(friendedgemat)

plot(edge, vertex.size=2, edge.arrow=0.2, vertex.label=NA, edge.arrow.size=0.1)

#Need to change size of vertex. 
V(edge)$size =fr