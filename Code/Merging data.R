##### Merging Data #####
setwd("/storage/home/scf7/Desktop")
install.packages("RJSONIO")
install.packages("plyr")
library(plyr)
library(RJSONIO)
install.packages("dplyr")
library(dplyr)
install.packages("tidyr")
library(tidyr)

business = read.csv("madPittLas_Health.csv")
review = read.csv("review.csv")
user = read.csv("user_new.csv")

#removes the 'b ' thing
user = user %>% separate(user_id, c("junk", "user_"),"b'", extra = "merge")
user = user %>% separate(user_ , c("User_id", "junk"),"'", extra = "merge")
user$User_id = noquote(user$User_id)

MAD_PITT_LAS = read.csv("MergedMAD_PITT_VEGAS_Business_Review.csv")

final_file = merge(MAD_PITT_LAS, user, by.x="user_id", by.y= "User_id")
write.csv(final_file,"MAD_PITT_LAS_info.csv")
