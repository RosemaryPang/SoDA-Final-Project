########## Json to CSV ##############
setwd("/Users/mpang/Desktop")
install.packages("RJSONIO")
library(RJSONIO)
Business <- readLines("business.json")
Business_data_frame <- as.data.frame(t(sapply(Business,fromJSON)))
View(Business_data_frame)
row.names(Business_data_frame) <- NULL # This is to drop the automatically generated column
write.csv(Business_data_frame,"Review.csv")


User <- readLines("review.json")
User_data_frame <- as.data.frame(t(sapply(User,fromJSON)))
View(User_data_frame)
row.names(User_data_frame) <- NULL # This is to drop the automatically generated column
write.csv(User_data_frame,"Review.csv")


######## Data Cleaning Starts Here #########
Business <- read.csv("YelpBusiness.csv") # Read data
library(stringr) # Library for separate string into multiple columns
category <- data.frame(str_split_fixed(Business$categories,",",17))    # Separate business category column into different columns (I set the number to be 17, you may change the number)                                                                                                                                                                                                                                                                    
X1 <- str_replace_all(as.character(category$X1),"c\\(","") # After separating the column, there is still c() and "" in the columns, the following steps are to remove these
X1 <- data.frame(gsub("\"","",X1))
X2 <- str_replace_all(as.character(category$X2),"\\)","")
X2 <- data.frame(gsub("\"","",X2))
X3 <- str_replace_all(as.character(category$X3),"\\)","")
X3 <- data.frame(gsub("\"","",X3))
X4 <- str_replace_all(as.character(category$X4),"\\)","")
X4 <- data.frame(gsub("\"","",X4))
X5 <- str_replace_all(as.character(category$X5),"\\)","")
X5 <- data.frame(gsub("\"","",X5))
X6 <- str_replace_all(as.character(category$X6),"\\)","")
X6 <- data.frame(gsub("\"","",X6))
X7 <- str_replace_all(as.character(category$X7),"\\)","")
X7 <- data.frame(gsub("\"","",X7))
X8 <- str_replace_all(as.character(category$X8),"\\)","")
X8 <- data.frame(gsub("\"","",X8))
X9 <- str_replace_all(as.character(category$X9),"\\)","")
X9 <- data.frame(gsub("\"","",X9))
X10 <- str_replace_all(as.character(category$X10),"\\)","")
X10 <- data.frame(gsub("\"","",X10))
X11 <- str_replace_all(as.character(category$X11),"\\)","")
X11 <- data.frame(gsub("\"","",X11))
X12 <- str_replace_all(as.character(category$X12),"\\)","")
X12 <- data.frame(gsub("\"","",X12))
X13 <- str_replace_all(as.character(category$X13),"\\)","")
X13 <- data.frame(gsub("\"","",X13))
X14 <- str_replace_all(as.character(category$X14),"\\)","")
X14 <- data.frame(gsub("\"","",X14))
X15 <- str_replace_all(as.character(category$X15),"\\)","")
X15 <- data.frame(gsub("\"","",X15))
X16 <- str_replace_all(as.character(category$X16),"\\)","")
X16 <- data.frame(gsub("\"","",X16))
X17 <- str_replace_all(as.character(category$X17),"\\)","")
X17 <- data.frame(gsub("\"","",X17))
categories <- cbind(X1,X2,X3,X4,X5,X6,X7,X8,X9,X10,X11,X12,X13,X14,X15,X16,X17) # Combine category columns and rename columns
names(categories) <- c("X1","X2","X3","X4","X5","X6","X7","X8","X9","X10","X11","X12","X13","X14","X15","X16","X17")
Business <- cbind(Business,categories) # Put category data into original pittsburg data
Business_health <- subset(Business,X1=="Health & Medical"|X2=="Health & Medical"|X3=="Health & Medical"|
                                           X4=="Health & Medical"|X5=="Health & Medical"|X6=="Health & Medical"|
                                           X7=="Health & Medical"|X8=="Health & Medical"|X9=="Health & Medical"|
                                          X10=="Health & Medical"|X11=="Health & Medical"|X12=="Health & Medical"|
                                          X13=="Health & Medical"|X14=="Health & Medical"|X15=="Health & Medical"|
                                          X16=="Health & Medical"|X17=="Health & Medical") # Pickout all Health related business
Business_city_health <- subset(Business_health,city=="Pittsburgh"|city=="Las Vegas"|city=="Madison") # Select cities
write.csv(Business_city_health,"Pittsburgh_Health.csv") # write to csv and manually clean



