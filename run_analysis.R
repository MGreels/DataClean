# Data Cleaning Script for accelerometer testing data
# 30 Users performing 6 different activities
#each instance contains 561 activity accelerometer readings.
# this script combines test and training data, selects only 
#means and sds and adds appropriate labels to the data.
# return is a DF with 180 rows and 88 columns (86 operations)


library(dplyr)

#####   Step 1 - Merge All Data Sets
        #load 3 training data frames - subject = subject IDs, y_train = activity IDs, X_train = bulk of accel data
trainx <- read.table("train/X_train.txt")
trainy <- read.table("train/y_train.txt")
trainsub <- read.table("train/subject_train.txt")

        #load 3 test data frames - subject = subject IDs, y_train + activity IDs, X_train = bulk of accel data
testx <- read.table("test/X_test.txt")
testy <- read.table("test/y_test.txt")
testsub <- read.table("test/subject_test.txt")

        # load activity names and accelerometer readings
features <- (read.table("features.txt", stringsAsFactors = FALSE))
featurevect <- make.names(features$V2, unique = TRUE, allow_ = TRUE)
rm(features)
acts <- read.table("activity_labels.txt")

        #Combine all datasets to one table dataframe and remove partials
fulldata <- tbl_df(bind_rows( bind_cols(testsub, testy, testx), bind_cols(trainsub, trainy, trainx)))
rm(trainsub, trainx, trainy, testy, testx, testsub) #removes raw datasets from env

#####   Step 2 - Extracts only the measurements on the mean and SD of each measurement 
        #extracts mean and std data column locations using Regex, then selects only those columns from fulldata
meansdlocs <- grep("*.[Mm]ean*.|*.[Ss]td*.", featurevect)
meandata <- fulldata[ ,c(1,2,meansdlocs+2)]
rm(fulldata)


#####   Step 3 - assigns descriptive names to the activities
        #swaps out integer values with char desciptions
meandata <- mutate(meandata, V1100 = acts$V2[V1100]) 
rm(acts) #remove acts vector from env

#####   Step 4 - Assigns descriptive names to feature columns
        #assigns feature names to DF columns
colnames(meandata) <- c("userid", "activity", featurevect[meansdlocs]) 

#####   Step 5 - create new tidy data set with only the mean of all values for every unique User-Activity pair
        #groups DF by userid-activity pair, then takes the mean of 561 acceleration vals
Means <- meandata %>%
                group_by(userid, activity) %>%
                summarise_all(mean) 
rm(meandata, featurevect, meansdlocs)

        # Write final table of Mean values for 180 userid-activity pairs "
write.table(Means, file = "Fulldata.txt")


