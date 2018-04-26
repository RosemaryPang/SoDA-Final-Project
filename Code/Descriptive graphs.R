##### Getting Started #####
setwd("/Users/mpang/Desktop")
Fulldata <- read.csv("MAD_PITT_LAS_info.csv") # Read merged data
library(dplyr)
library(ggplot2)
library(stringr)


##### Separate cities #####
Pitt.full <- subset(Fulldata,city=="Pittsburgh")
Vegas.full <- subset(Fulldata,city=="Las Vegas")
Madison.full <- subset(Fulldata,city=="Madison")

##### distribution of ratings by users
ratings_and_users <- Fulldata %>% group_by(stars.y) %>% count()
ggplot(data=ratings_and_users, aes(x=stars.y, y=n)) + 
  geom_bar(stat="identity",fill="lightblue") +
  labs(title = "Distribution of Ratings by Users", y = "Count of Users",x="Star Category") +
  theme_minimal()

##### distribution of ratings by business
Fulldata$star.z[Fulldata$stars.x<2] <- 1
Fulldata$star.z[Fulldata$stars.x>=2&Fulldata$stars.x<3] <- 2
Fulldata$star.z[Fulldata$stars.x>=3&Fulldata$stars.x<4] <- 3
Fulldata$star.z[Fulldata$stars.x>=4&Fulldata$stars.x<5] <- 4
Fulldata$star.z[Fulldata$stars.x==5] <- 5


ratings_and_business <- Fulldata %>% group_by(star.z) %>% count()
ggplot(data=ratings_and_business, aes(x=star.z, y=n)) + 
  geom_bar(stat="identity",fill="lightblue") +
  labs(title = "Distribution of Ratings by Business", y = "Count of Businesses",x="Star Category") +
  theme_minimal()

ratings_and_business.Pitt <- Pitt.full %>% group_by(star.z) %>% count()
ggplot(data=ratings_and_business.Pitt, aes(x=star.z, y=n)) + 
  geom_bar(stat="identity",fill="lightblue") +
  labs(title = "Distribution of Ratings by Business", y = "Count of Businesses",x="Star Category") +
  theme_minimal()

ratings_and_business.Madison <- Madison.full %>% group_by(star.z) %>% count()
ggplot(data=ratings_and_business.Madison, aes(x=star.z, y=n)) + 
  geom_bar(stat="identity",fill="lightblue") +
  labs(title = "Distribution of Ratings by Business", y = "Count of Businesses",x="Star Category") +
  theme_minimal()

ratings_and_business.Vegas <- Vegas.full %>% group_by(star.z) %>% count()
ggplot(data=ratings_and_business.Vegas, aes(x=star.z, y=n)) + 
  geom_bar(stat="identity",fill="lightblue") +
  labs(title = "Distribution of Ratings by Business", y = "Count of Businesses",x="Star Category") +
  theme_minimal()

##### Histogram of user review count #####
qplot(Fulldata$review_count.y,geom="histogram",main="Histogram for User Review Count",
      xlab="Review Count",fill=I("lightblue"),binwidth=30)+
  theme_minimal()

##### Histogram of business review count #####
qplot(Fulldata$review_count.x,geom="histogram",main="Histogram for Business Review Count",
      xlab="Review Count",fill=I("lightblue"),col=I("grey"),binwidth=30)+
  theme_minimal()

#### Recode review count #####
Fulldata$buscount[Fulldata$review_count.x<=50] <- 1
Fulldata$buscount[Fulldata$review_count.x>50&Fulldata$review_count.x<=100] <- 2
Fulldata$buscount[Fulldata$review_count.x>100&Fulldata$review_count.x<=150] <- 3
Fulldata$buscount[Fulldata$review_count.x>150&Fulldata$review_count.x<=200] <- 4
Fulldata$buscount[Fulldata$review_count.x>200] <- 5

Fulldata$usercount[Fulldata$review_count.y<=200] <- 1
Fulldata$usercount[Fulldata$review_count.y>200&Fulldata$review_count.y<=400] <- 2
Fulldata$usercount[Fulldata$review_count.y>400&Fulldata$review_count.y<=600] <- 3
Fulldata$usercount[Fulldata$review_count.y>600&Fulldata$review_count.y<=800] <- 4
Fulldata$usercount[Fulldata$review_count.y>800&Fulldata$review_count.y<=1000] <- 5
Fulldata$usercount[Fulldata$review_count.y>1000] <- 6


##### Correlation of number of review and ratings
ggplot(data=Fulldata,aes(x=factor(buscount),y=stars.x,color=I("blue")))+
  geom_boxplot() +
  labs(title = "Business Ratings vs Count", y = "Average Rating", x = "Rating Count")+
  theme_minimal() ## Business count-rating


ggplot(data=Fulldata,aes(x=factor(usercount),y=average_stars,color=I("blue")))+
  geom_boxplot() +
  labs(title = "User Ratings vs Count", y = "Average Rating", x = "Rating Count")+
  theme_minimal() ## User count-rating
  
##### Top categories with 5-star
top_rated_categories <- Fulldata %>% filter(stars.x==5) %>% select(name.x,X2)
top <- top_rated_categories %>% group_by(X2) %>% summarise(count=n()) %>% arrange(desc(count))
topfive <- head(top,5) #top 5 receive more than 100 5-star rates
ggplot(data=topfive, aes(x=X2, y=count)) + 
  geom_bar(stat="identity",fill="lightblue") +
  labs(title = "Top categories with 5-stars", y = "Count of Businesses",x="Business Category") +
  theme_minimal()

##### Top categories with less than 2-stars
least_rated_categories <- Fulldata %>% filter(stars.x<2) %>% select(name.x,X2)
least <- least_rated_categories %>% group_by(X2) %>% summarise(count=n()) %>% arrange(desc(count))
topfive2 <- head(least,5) #top 5 receive more than 20 5-star rates
ggplot(data=topfive2, aes(x=X2, y=count)) + 
  geom_bar(stat="identity",fill="lightblue") +
  labs(title = "Top categories with Less than 2-stars", y = "Count of Businesses",x="Business Category") +
  theme_minimal()
