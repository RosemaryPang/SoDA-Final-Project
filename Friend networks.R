

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