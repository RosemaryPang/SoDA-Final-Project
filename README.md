# SoDA-Final-Project

  This is for the SoDA 501 final project. Our group used data from the Yelp 2018 challenge data, focusing on health-related businesses within three US cities: Pittsburgh, Las Vegas, and Madison. 
  
  To begin the project, we needed to perform a few steps in order to make the data usable for our purposes. After downloading the challenge data as a JSON, the first step in our project is to convert the original JSON files to csv files. Several files provide the code for different steps in this process. The next step is to subset the files to just the cities and businesses of interest. Then, we merged the subsetted files into a single file for analysis. Our analyses include maps of businesses based on their location, number of reviews, and number of stars, along with plots of the user network structure.
  
  The Code folder has the following files that provide the code for our project:
  
 # "Review.py"
 The "Review.py" file provides code for converting the original JSON file with business reviews (Review.json) to a csv file (Review.csv) using Python. 
  
#  "ReadClean.R"
  The "ReadClean.R" provides R code for converting the JSON files with business information and attributes (including location, number of reviews, number of starts, etc.) (Business.json) and user data (including user id and friends) (User.json) to csv files.
  
#  "Merging data.R"
  This file provides R code for merging and subsetting the business file and review file (Review.csv) based on Business id.
  It then gives the code to merge this new file with User.csv based on User id. This results in the final file we will use to perform our analyses.
  
#  "soda501maps.r"
  This file provides R code for finding the geolocation of the business and changing the size and color of the businesses according to the number of reviews and stars. Additionally, 2000 Decennial Census data is used to add contextual information such as tract-level poverty to the maps.
  
# "LISAMaps.py (LISAMaps.ipynb)" 

This file produces Population and Poverty cluster maps at census tract level using LISA statistics. 

# "soda501_processing_maps.R" 

This file produces maps that went into the report and presentation, specially some maps included in the Appendix. There are other codes that were used for data processing and for trying out and comparing different R packages for map making. 
  
 # "Friend network.R"
  This file provides code for plotting a basic network structure for reviewer-friend network. We will include network attributes in the next step. This a preliminary step in order to look into the friendship structure of the networks. For this, we separated the data into three different networks (for each city respectively). 
  
  # "Business Network.R"
  This file provides code for examining the relationship between businesses and users, in order to see how popular the businesses are and how many reviews the businesses received. We used a bipartite network to show the businesses and users within the network and changed the size of the businesses to reflect the rating of the business.
  
  # "Descriptive Graphs.R"
  This file provides the code for analyses of descriptive statistics in R. Such analyses include histograms and box plots of average star ratings of various types of businesses and average stars given by reviewers.
