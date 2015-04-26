# Getting and Cleaning Data Course Project (JH Data Science Project)

Files in repo:
	README.md
	CodeBook.md
	run_analysis.r
each are detailed further below, as well as more information about source data and credits

OVERVIEW:
=====================================
The code/script to run the data transformation (run_analysis.r) will run as long as it is in the same directory with the data files (described below)
Health Warning:  Have had a family emergency the last two weeks, so coding has been left at functional stage, not the most elegant and compact as I would have preferred.  Apologies for that, but it is probably easier to follow this way.

CODEBOOK:
===========================================
'CodeBook.md' contains 
	- a definition of dataset and columns

DATA FILES:
===========================================
In order for the script to run, the data files are required in the same structure as the downloaded zip file with "features.txt" and "activity_labels" at the root alongside two directories (test and train) below

Specifically:
	- 'features.txt': List of all features.
	- 'activity_labels.txt': Links the class labels with their activity name.
	- 'train/X_train.txt': Training set.
	- 'train/y_train.txt': Training labels.
	- 'train/subject_train.txt': Each row identifies the subject who performed the activity for each window sample. 
	- 'test/X_test.txt': Test set.
	- 'test/y_test.txt': Test labels.
	- 'train/subject_test.txt': Each row identifies the subject who performed the activity for each window sample. 

Additional information about source data and measures is below, including:
	- description of experiements
	- detailed definitions of data measurements
	- license and background information 

SCRIPT:
========================================
run_analysis.R - The code is commented, but a brief overview of steps taken is below.

Packages Required
  The code reads 'dplyr' and 'data.table' into the library

URLs - 8 Urls are defined.  
    	(1-6) for the data (3 each for test and train)
    	(7) activity_labels to give the activities meaningful names
    	(8) and features.txt in order to identify the variable columns required and give them meaningful names.

Read data into dataframes
	All six files from the test and train directories are read into dataframes
	As well as the activity and variable names

Keep Mean and Standard Deviation measures
	The column names with mean and STD variable names are each pulled into a list then combined into one list ("colkeep")

Assign column names (or variable) to the 6 working data frames; column names are assigned to the activity table to that it can be joined to final table in order to update the activity names (vs ID#)

Create subsets of x data and features, with just needed variables
	The test x-dataframe, train x-dataframe and featurenames are created with just the identified mean and std variables using the "keep" list created earlier

Merge and format final dataset
	Test and Train x data tables (limited to mean and std) are each combined with their subject and activity identifiers (with cbind)
	Then combined together into one data table (using rbind), then converted to a dplyr dataframe
	The combined data table is joined with the activity table in order to include Activity labels, then the activity ID is dropped
	The variable columns are gathered into rows, then grouped by Subject + Activity + Variable
	The mean of Subject + Activity + Variable column is calculated and inserted into a column labelled "MEAN"
	Final data exported to "tidydata.txt"



=================================================================
More information about underlying source data:
==================================================================


============================================================
Credits, license and experiment description:
=============================================================

Human Activity Recognition Using Smartphones Dataset
Version 1.0
------------------------------------------------------------------
Jorge L. Reyes-Ortiz, Davide Anguita, Alessandro Ghio, Luca Oneto.
Smartlab - Non Linear Complex Systems Laboratory
DITEN - Università degli Studi di Genova.
Via Opera Pia 11A, I-16145, Genoa, Italy.
activityrecognition@smartlab.ws
www.smartlab.ws
------------------------------------------------------------------

The experiments have been carried out with a group of 30 volunteers within an age bracket of 19-48 years. Each person performed six activities (WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING, STANDING, LAYING) wearing a smartphone (Samsung Galaxy S II) on the waist. Using its embedded accelerometer and gyroscope, we captured 3-axial linear acceleration and 3-axial angular velocity at a constant rate of 50Hz. The experiments have been video-recorded to label the data manually. The obtained dataset has been randomly partitioned into two sets, where 70% of the volunteers was selected for generating the training data and 30% the test data. 

The sensor signals (accelerometer and gyroscope) were pre-processed by applying noise filters and then sampled in fixed-width sliding windows of 2.56 sec and 50% overlap (128 readings/window). The sensor acceleration signal, which has gravitational and body motion components, was separated using a Butterworth low-pass filter into body acceleration and gravity. The gravitational force is assumed to have only low frequency components, therefore a filter with 0.3 Hz cutoff frequency was used. From each window, a vector of features was obtained by calculating variables from the time and frequency domain. See 'features_info.txt' for more details. 

Provided for each record was:
-----------------------------------

- Triaxial acceleration from the accelerometer (total acceleration) and the estimated body acceleration.
- Triaxial Angular velocity from the gyroscope. 
- A 561-feature vector with time and frequency domain variables. 
- Its activity label. 
- An identifier of the subject who carried out the experiment.

More information about the features included in the tidy data summary, see "Feature Selection" below. 
 

License:
-----------
Use of this dataset in publications must be acknowledged by referencing the following publication [1] 

[1] Davide Anguita, Alessandro Ghio, Luca Oneto, Xavier Parra and Jorge L. Reyes-Ortiz. Human Activity Recognition on Smartphones using a Multiclass Hardware-Friendly Support Vector Machine. International Workshop of Ambient Assisted Living (IWAAL 2012). Vitoria-Gasteiz, Spain. Dec 2012

This dataset is distributed AS-IS and no responsibility implied or explicit can be addressed to the authors or their institutions for its use or misuse. Any commercial use is prohibited.

Jorge L. Reyes-Ortiz, Alessandro Ghio, Luca Oneto, Davide Anguita. November 2012.


=================================
Feature Selection 
=================================

The features selected for this database come from the accelerometer and gyroscope 3-axial raw signals tAcc-XYZ and tGyro-XYZ. 
These time domain signals (prefix 't' to denote time) were captured at a constant rate of 50 Hz. 
Then they were filtered using a median filter and a 3rd order low pass Butterworth filter with a corner frequency of 20 Hz to remove noise. 
Similarly, the acceleration signal was then separated into body and gravity acceleration signals (tBodyAcc-XYZ and tGravityAcc-XYZ) using another low pass Butterworth filter with a corner frequency of 0.3 Hz. 

Subsequently, the body linear acceleration and angular velocity were derived in time to obtain Jerk signals (tBodyAccJerk-XYZ and tBodyGyroJerk-XYZ). Also the magnitude of these three-dimensional signals 
were calculated using the Euclidean norm (tBodyAccMag, tGravityAccMag, tBodyAccJerkMag, tBodyGyroMag, tBodyGyroJerkMag). 

Finally a Fast Fourier Transform (FFT) was applied to some of these signals producing fBodyAcc-XYZ, fBodyAccJerk-XYZ, fBodyGyro-XYZ, 
fBodyAccJerkMag, fBodyGyroMag, fBodyGyroJerkMag. (Note the 'f' to indicate frequency domain signals). 

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

The set of variables that were estimated from these signals (and included in the tidy data set): 

mean(): Mean value
std(): Standard deviation

Additional vectors obtained by averaging the signals in a signal window sample. These are used on the angle() variable (and included in the tidy data set):

gravityMean
tBodyAccMean
tBodyAccJerkMean
tBodyGyroMean
tBodyGyroJerkMean
