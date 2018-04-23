# SoDA-Final-Project

  This is for the SoDA 501 final project. Our group is working on Yelp 2018 challenge data, with a focus on health-related businesses in Pittsburgh, Las Vegas, and Madison.
  
  The first step in our project is to convert the original JSON files to csv files. Several files provide the code for different steps in this process.
  
  "Review.py"
   The "Review.py" file provides code for converting Review.json to Review.csv using Python.
  
  "ReadClean.R"
  The "ReadClean.R" provides code for converting Business and User data to csv files. After converting Business.json to csv, we also subset the file to the cities and businesses we are interested in. 
  
  "Merging data.R"
  Second, we merge the subsetted business file, and "Review.csv" based on Business id, then merge this new file with "User.csv", based on User id. "Merging data.R" is the code for this step. 
  
  "soda501maps.r"
  In the third step, we find the geolocation of the business and change the size and color of the businesses according to their number of reviews and review stars. "soda501maps.r" file is the R code for this step. We also find the Census data, so we can add more information to the maps.
  
  Finally, we also plot a basic network strucuture for reviewer-friend network, using the code "Friend network.R". We will include network attributes in the next step. 
  
  
  
  
