# SoDA-Final-Project

  This is for SoDA 501 final project. Our group is working on Yelp challenge data, with a focus on health-related businesses in Pittsburgh, Las Vegas, and Madison.
  
  First, we convert the original JSON files to csv files. "Review.py" file is for converting Review.json to Review.csv using Python. "ReadClean.R" is for converting Business and User data to csv files. After converting Business.json to csv, we also subset the file to the cities and businesses we are interested in. 
  
  Second, we merge the subsetted business file, and "Review.csv" based on Business id, then merge this new file with "User.csv", based on User id. "Merging data.R" is the code for this step. 
  
  In the third step, we find the geolocation of the business and change the size and color of the businesses according to their number of reviews and review stars. "soda501maps.r" file is the R code for this step. We also find the Census data, so we can add more information to the maps.
  
  Finally, we also plot a basic network strucuture for reviewer-friend network, using the code "Friend network.R". We will include network attributes in the next step. 
  
  
  
