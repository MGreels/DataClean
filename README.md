### DataClean Project
#1 

run analysis.R performs a 5 step process for cleaning the dataset provided at this links 

# 1. Step 1 
Downloads all test and training data for subjects (1-30), activities (1-6) and 561 acceleration measurements per instance.  Creates 1 large dataset with all of these together

# Step 2
using Regex, identifies all measurements that are means or standard deviations and modifies the full data set to only include these columns

# Step 3
Using the list of activity descriptions in the original (activity_labels.txt) assigns actual descriptive labels to the activities vector

# Step 4
Searches the features vector (features.txt) for means and stds column names based on the location vector created in Step 2.

# step 5 
groups the new dataset by User and by Activity.  calculates average of the 86 remaining variables for each of the 180 unique User-Activity pairing

