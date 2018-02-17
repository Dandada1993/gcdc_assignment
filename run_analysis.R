#this script should be run from a director that has the test and training
#data stored in subfolders called "test" and "train" respectively

#load the dplyr library
library(dplyr)
#name of measurements test data file
xtestfile <- paste(".", "test", "X_test.txt", sep="/")
#name of activity test data file
ytestfile <- paste(".", "test", "Y_test.txt", sep="/")
#name of file with test subjects
testsubjectsfile <- paste(".", "test", "subject_test.txt", sep="/")
#name of file with train subjects
trainsubjectsfile <- paste(".", "train", "subject_train.txt", sep="/")
#name of measurements training data file
xtrainfile <- paste(".", "train", "X_train.txt", sep="/")
#name of activity training data file
ytrainfile <- paste(".", "train", "Y_train.txt", sep="/")
#name of file containing variable names for measurements
headersfile <- "features.txt"
#name of activities
activitiesfile <- "activity_labels.txt"
#load xtest
raw_xtest <- read.table(xtestfile, header=FALSE)
#load ytest
raw_ytest <- read.table(ytestfile, header=FALSE)
#load xtrain
raw_xtrain <- read.table(xtrainfile, header=FALSE)
#load ytrain
raw_ytrain <- read.table(ytrainfile, header=FALSE)
#load variable names
raw_headers <- read.table(headersfile, header=FALSE, stringsAsFactors = FALSE)
#load activity names
activities <- read.table(activitiesfile, header=FALSE)
#load test subjects
testsubjects <- read.table(testsubjectsfile, header=FALSE)
#load train subjects
trainsubjects <- read.table(trainsubjectsfile, header=FALSE)
#change colnames in activities df
colnames(activities) <- c("value", "name")
#add imported variable names with actual variable names
colnames(raw_xtest) <- raw_headers$V2 #gsub("-", "_", gsub("\\)", "", gsub("\\(", "", gsub(",", ".", raw_headers$V2))))
colnames(raw_xtrain) <- raw_headers$V2 #gsub("-", "_", gsub("\\)", "", gsub("\\(", "", gsub(",", ".", raw_headers$V2))))
#add colnames to raw_ytest and raw_ytrain
colnames(raw_ytest) <- "activity"
colnames(raw_ytrain) <- "activity"
#add colnames to testsubjects and trainsubjects
colnames(testsubjects) <- "subject"
colnames(trainsubjects) <- "subject"
#merge the xtrain and xtest
raw_xcombined <- rbind(raw_xtrain, raw_xtest)
#merge the ytrain and ytest
raw_ycombined <- rbind(raw_ytrain, raw_ytest)
#The following calls makes the colnames unique otherwise the dplyr select fails
colnames(raw_xcombined) <- make.names(colnames(raw_xcombined), unique=TRUE)
#select only the variables for mean and standard deviation
xcombined <- raw_xcombined %>% select(matches("\\.(mean|std)\\.", ignore.case = TRUE))
#set the colnames of raw_ycombined
#colnames(raw_ycombined) <- "activity"
#combine subjects train and test data
combined_subjects <- rbind(trainsubjects, testsubjects)
#join y data to the df containing on mean and std columns
combined <- cbind(combined_subjects, raw_ycombined, xcombined)
## get an activity from activities based on the Value; activities[activities$Value==6,][,2]
combined <- combined %>% mutate(activity = as.factor(activity))
levels(combined$activity) <- activities$name
#tidy up the column names
cn <- colnames(combined)
cn <- gsub("(Body){2,}", "Body", cn)
#vector of regex patterns to be replaced
patterns <- c("^t", "^f", "BodyAccJerk", "BodyGyroJerk", "BodyGyro", "BodyAcc", "GravityAcc")
#vector of replacment string
repls <- c("time.", "freq.", "LinearAcceleration.", "AngularVelocity.", "BodyGyroscope.", "BodyAcceleration.", "GravityAcceleration.")
#create data.frame using patterns and repls
sub_params <- as.data.frame(cbind(patterns, repls))
#give a vector and replacement parameters for the sub function commulatively applies the 
#params to each value in the vector
tidy_columnnames <- function(data = vector(), params = data.frame())
{
    cummulative_replace <- function(value)
    {
        result <- NA
        for(i in 1:nrow(params))
        {
            if (is.na(result))
            {
                result <- sub(params[i,1], params[i,2], trimws(value))
            }
            else
            {
                result <- sub(params[i,1], params[i,2], result)
            }
        }
        tolower(result)
    }
    sapply(data, cummulative_replace)
}
#calculate the tidy column names
newcn <- tidy_columnnames(cn, sub_params)
newcn <- gsub("\\.{2,}", "\\.", newcn) #replace ... and .. with .
newcn <- gsub("\\.$", "", newcn) #remove . at end of name
#assign new column names
colnames(combined) <- newcn
#group by subject and activity and take the average of all the variables
group_combined <- combined %>% group_by(subject,activity) %>% summarise_all(mean)
write.table(group_combined, "tidy_ds.txt", row.name=FALSE)