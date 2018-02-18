# Getting and Cleaning Data
## Peer-graded Assignment Submission
## **Name**: Ralph P. Goddard
### **Submission Date**: February 17, 2017

# What's contained in the Git Hub repo
1. run_analysis.R - used to reproduce the transformations and analysis perfomed on the original dataset.
2. README.md
3. Codebook.txt

# Explanation of steps taken in run_analysis.R

1. Load the dplyr library
2. Assign names of test files, training files, list of activities, variable names and subjects into variables.
3. Load the x test data using read.table with header=FALSE
4. Load the x train data using read.table with header=FALSE
5. Load the y test data using read.table with header=FALSE
6. Load the y train data using read.table with header=FALSE
7. Load variable names (features) using read.table with header=FALSE, stringsAsFactors=FALSE
8. Load activities with read.table with header=FALSE
9. Load test subject with read.table with header=FALSE
10. Load train subject with read.table with header=FALSE
11. Add column names to activities data frame
12. Add the column names to the x test and x train data frames
13. Add column names to the test subject and train subject data frames, called subjects
14. Use rbind to merge the x train and x test data frames
15. Use rbind to merge the y train and y test data frames
16. Make the column names in the merged x data data frame unique.
17. Use the following regular expression to select only the columns with mean and standard deviation data "\\.(mean|std)\\." with ignore.case=TRUE
18. Add column name to merged y data, called activity
19. Use rbind to merge the train subject and test subjects
20. Use cbind to merge the subjects, y data and x data
21. Use mutate to modify variable activity to a factor "activity = as.factor(activity)
22. Set the levels for the activity factor
23. Tidy up the variables names by replacing duplicate Body e.g. "BodyBody" with "Body"
24. Use a custom function "tidy_columnnames" to tidy the variables names
25. A regex was used to replace .. or ... with a single period
26. A regex was used to remove a period at the end of a variable name
27. A new data frame was created by grouping by subject and activity and then using summarise_all to calculate the mean of all variables.
28. Output the results of step 27 to a file called "tidy_ds.txt" with row.name=FALSE
