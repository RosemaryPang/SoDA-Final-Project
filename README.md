# SoDA-Final-Project

  This is for the SoDA 501 final project. Our group is working on Yelp 2018 challenge data, with a focus on health-related businesses in Pittsburgh, Las Vegas, and Madison.
  
 # After downloading the challenge data as a JSON, the first step in our project is to convert the original JSON files to csv files. Several files provide the code for different steps in this process. The next step is to subset the files to just the cities and businesses of interest. Then, we merged the subsetted files into a single file for analysis. Our analyses include maps of businesses based on their location, number of reviews, and number of starts, along with plots of the user network structure.
  
  The Code folder has the following files that provide the code for our project:
  
 # "Review.py"
 The "Review.py" file provides code for converting the original JSON file with business reviews (Review.json) to a csv file (Review.csv) using Python.
  
#  "ReadClean.R"
  The "ReadClean.R" provides R code for converting the JSON files with business information and attributes (including location, number of reviews, number of starts, etc.) (Business.json) and user data (including user id and friends) (User.json) to csv files.
  After converting Business.json to csv, we also subset the file to only the cities and businesses we are interested in. 
  
#  "Merging data.R"
  This file provides R code for merging and subsetting the business file and review file (Review.csv) based on Business id.
  It then gives the code to merge this new file with User.csv based on User id. 
  
#  "soda501maps.r"
  This file provides R code for finding the geolocation of the business and changing the size and color of the businesses according to the number of reviews and stars. Additionally, 2000 Decennial Census data is used to add contextual information such as tract-level poverty to the maps.
  
 # "Friend network.R"
  This file provides code for plotting a basic network strucuture for reviewer-friend network. We will include network attributes in the next step.
  
