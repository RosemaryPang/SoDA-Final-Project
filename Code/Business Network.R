##### Getting Started #####
setwd("/Users/mpang/Desktop")
library(igraph)
library(reshape2)
seed <- 19640714

##### Subset data #####
Pitt.full <- subset(Fulldata,city=="Pittsburgh")
Vegas.full <- subset(Fulldata,city=="Las Vegas")
Madison.full <- subset(Fulldata,city=="Madison")
Pitt_business_unique <-Pitt.full[!duplicated(Pitt.full[,c("business_id")]),] # Only keep unique business
Madison_business_unique <-Madison.full[!duplicated(Madison.full[,c("business_id")]),] # Only keep unique business
Vegas_business_unique <-Vegas.full[!duplicated(Vegas.full[,c("business_id")]),] # Only keep unique business

##### Pittsburg Network #####
Pitt.full$connect <- 1 # generate a variable incidating connection
Pitt.matrix <- as.matrix(acast(Pitt.full,user_id~business_id,value.var="connect")) # create network matrix
Pitt.matrix[is.na(Pitt.matrix)] <- 0 # replace NA to 0
Pitt.igraph <- graph.incidence(Pitt.matrix) # create igraph
shapes <- c(rep("circle",417),rep("square",83)) # 417 users are circles, 83 businesses are squares
size <- c(rep(0,417),Pitt_business_unique$stars.x) # change business size by stars, user sizes are 0
V(Pitt.igraph)$star <- c(size) # Add attributes
set.seed(seed)
plot(Pitt.igraph,vertex.shape=shapes,vertex.color=V(Pitt.igraph)$type,vertex.label=NA,
     edge.arrow=0.2,edge.arrow.size=0.1, vertex.size=V(Pitt.igraph)$star) # make graph

##### Madison Network #####
Madison.full$try <- 1
Madison.matrix <- as.matrix(acast(Madison.full,user_id~business_id,value.var="try"))
Madison.matrix[is.na(Madison.matrix)] <- 0
Madison.igraph <- graph.incidence(Madison.matrix)
shapes <- c(rep("circle",198),rep("square",29)) # 198 is for user number, 29 is number of business
size <- c(rep(0,198),Madison_business_unique$stars.x)
V(Madison.igraph)$star <- c(size)
set.seed(seed)
plot(Madison.igraph,vertex.shape=shapes,vertex.color=V(Madison.igraph)$type,vertex.label=NA,
     edge.arrow=0.2,edge.arrow.size=0.1, vertex.size=V(Madison.igraph)$star)

##### Vegas Network #####
Vegas.full$try <- 1
Vegas.matrix <- as.matrix(acast(Vegas.full,user_id~business_id,value.var="try"))
Vegas.matrix[is.na(Vegas.matrix)] <- 0
Vegas.igraph <- graph.incidence(Vegas.matrix)
shapes <- c(rep("circle",7606),rep("square",581)) # 7606 is for user number, 581 is number of business
shapelist <- c(rep("white",7606),rep("yellow",581))
size <- c(rep(0,7606),Vegas_business_unique$stars.x*0.5)
V(Vegas.igraph)$star <- c(size)
V(Vegas.igraph)$color <- c(shapelist)
plot(Vegas.igraph,vertex.shape=shapes,vertex.color=adjustcolor(V(Vegas.igraph)$color,alpha.f = 0.3),vertex.label=NA,
     edge.arrow=0.2,edge.arrow.size=0.1, vertex.size=V(Vegas.igraph)$star) # adjust color transparency, make users visualizable




