# Getting and Cleaning Data
## Peer-graded Assignment Submission
## **Name**: Ralph P. Goddard
### **Submission Date**: February 17, 2017

## Background (this information is taken from the features_info.txt file included with the assignment)
 
The features selected for this database come from the accelerometer and gyroscope 3-axial raw signals tAcc-XYZ and tGyro-XYZ. These time domain signals (prefix 't' to denote time) were captured at a constant rate of 50 Hz. Then they were filtered using a median filter and a 3rd order low pass Butterworth filter with a corner frequency of 20 Hz to remove noise. Similarly, the acceleration signal was then separated into body and gravity acceleration signals (tBodyAcc-XYZ and tGravityAcc-XYZ) using another low pass Butterworth filter with a corner frequency of 0.3 Hz. 

Subsequently, the body linear acceleration and angular velocity were derived in time to obtain Jerk signals (tBodyAccJerk-XYZ and tBodyGyroJerk-XYZ). Also the magnitude of these three-dimensional signals were calculated using the Euclidean norm (tBodyAccMag, tGravityAccMag, tBodyAccJerkMag, tBodyGyroMag, tBodyGyroJerkMag). 

Finally a Fast Fourier Transform (FFT) was applied to some of these signals producing fBodyAcc-XYZ, fBodyAccJerk-XYZ, fBodyGyro-XYZ, fBodyAccJerkMag, fBodyGyroMag, fBodyGyroJerkMag. (Note the 'f' to indicate frequency domain signals). 

These signals were used to estimate variables of the feature vector for each pattern:  
'-XYZ' is used to denote 3-axial signals in the X, Y and Z directions.

tBodyAcc-XYZ
tGravityAcc-XYZ
tBodyAccJerk-XYZ
tBodyGyro-XYZ
tBodyGyroJerk-XYZ
tBodyAccMag
tGravityAccMag
tBodyAccJerkMag
tBodyGyroMag
tBodyGyroJerkMag
fBodyAcc-XYZ
fBodyAccJerk-XYZ
fBodyGyro-XYZ
fBodyAccMag
fBodyAccJerkMag
fBodyGyroMag
fBodyGyroJerkMag

The set of variables that were estimated from these signals are: 

mean(): Mean value
std(): Standard deviation
mad(): Median absolute deviation 
max(): Largest value in array
min(): Smallest value in array
sma(): Signal magnitude area
energy(): Energy measure. Sum of the squares divided by the number of values. 
iqr(): Interquartile range 
entropy(): Signal entropy
arCoeff(): Autorregresion coefficients with Burg order equal to 4
correlation(): correlation coefficient between two signals
maxInds(): index of the frequency component with largest magnitude
meanFreq(): Weighted average of the frequency components to obtain a mean frequency
skewness(): skewness of the frequency domain signal 
kurtosis(): kurtosis of the frequency domain signal 
bandsEnergy(): Energy of a frequency interval within the 64 bins of the FFT of each window.
angle(): Angle between to vectors.

Additional vectors obtained by averaging the signals in a signal window sample. These are used on the angle() variable:

gravityMean
tBodyAccMean
tBodyAccJerkMean
tBodyGyroMean
tBodyGyroJerkMean

The complete list of variables of each feature vector is available in 'features.txt'

# Tidying

The original data set was modified to produce a tidy data set. Only variables related to the mean and standard deviation were retained and the data which was supplied in separate files train\subject_train.txt, train\X_train.txt, train\Y_train.txt, test\subject_test.txt, test\X_test.txt and test\Y_test.txt were combined. The variable names described above were changed to make the them more readable as outlined below.

# Renaming of original variable names

A custom function "tidy_columnnames" was used to apply the following regular expression cumulativly to the old variable names and to lower case the names

| Regex        | Replacement String  |
|--------------|---------------------|
| ^t           | time.               |
| ^f           | freq.               |
| BodyAccJerk  | LinearAcceleration. |
| BodyGyroJerk | AngularVelocity.    |
| BodyGyro     | BodyGyroscope.      |
| BodyAcc      | BodyAcceleration.   |
| GravityAcc   | GravityAcceleration.|

Variable names consist of 4 segments

* The first segments is either "time" or "freq" to differentiate tial doman signals from frequency domain signals.
* The second segment is one of the five measurements included in the original data set linear acceleration, angular velocity, body acceleration, gravity acceleration and body gyroscope.
* The third segment is either "mean", "std" (standard deviation) or "mag" (magnitude)
* The fourth segment is either "X", "Y", "Z" for 3 axials measurements and for variables where the third segment is "mag" the fourth is either "mean" or "std" (standard deviation)

### Example tidy variable names

* time.bodyacceleration.mean.x
* freq.angularveloctiy.mag.mean
* time.bodygyroscope.std.z
* freq.bodyacceleration.mean.y
* time.gravityacceleration.mag.std

# Complete list of variable names

* subject
* activity
* time.bodyacceleration.mean.x
* time.bodyacceleration.mean.y
* time.bodyacceleration.mean.z
* time.bodyacceleration.std.x
* time.bodyacceleration.std.y
* time.bodyacceleration.std.z
* time.gravityacceleration.mean.x
* time.gravityacceleration.mean.y
* time.gravityacceleration.mean.z
* time.gravityacceleration.std.x
* time.gravityacceleration.std.y
* time.gravityacceleration.std.z
* time.linearacceleration.mean.x
* time.linearacceleration.mean.y
* time.linearacceleration.mean.z
* time.linearacceleration.std.x
* time.linearacceleration.std.y
* time.linearacceleration.std.z
* time.bodygyroscope.mean.x
* time.bodygyroscope.mean.y
* time.bodygyroscope.mean.z
* time.bodygyroscope.std.x
* time.bodygyroscope.std.y
* time.bodygyroscope.std.z
* time.angularvelocity.mean.x
* time.angularvelocity.mean.y
* time.angularvelocity.mean.z
* time.angularvelocity.std.x
* time.angularvelocity.std.y
* time.angularvelocity.std.z
* time.bodyacceleration.mag.mean
* time.bodyacceleration.mag.std
* time.gravityacceleration.mag.mean
* time.gravityacceleration.mag.std
* time.linearacceleration.mag.mean
* time.linearacceleration.mag.std
* time.bodygyroscope.mag.mean
* time.bodygyroscope.mag.std
* time.angularvelocity.mag.mean
* time.angularvelocity.mag.std
* freq.bodyacceleration.mean.x
* freq.bodyacceleration.mean.y
* freq.bodyacceleration.mean.z
* freq.bodyacceleration.std.x
* freq.bodyacceleration.std.y
* freq.bodyacceleration.std.z
* freq.linearacceleration.mean.x
* freq.linearacceleration.mean.y
* freq.linearacceleration.mean.z
* freq.linearacceleration.std.x
* freq.linearacceleration.std.y
* freq.linearacceleration.std.z
* freq.bodygyroscope.mean.x
* freq.bodygyroscope.mean.y
* freq.bodygyroscope.mean.z
* freq.bodygyroscope.std.x
* freq.bodygyroscope.std.y
* freq.bodygyroscope.std.z
* freq.bodyacceleration.mag.mean
* freq.bodyacceleration.mag.std
* freq.linearacceleration.mag.mean
* freq.linearacceleration.mag.std
* freq.bodygyroscope.mag.mean
* freq.bodygyroscope.mag.std
* freq.angularvelocity.mag.mean
* freq.angularvelocity.mag.std

# Variables explained

subject - integer - valid values:  1 to 30
activity - character - valid values: WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING, STANDING, LAYING
all other variables - numeric - valid values -1 to 1 in gravitational units except for the bodygyroscope variables which are in radian/second