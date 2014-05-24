#Raw Data

Raw data downloaded from https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip

Detailed discription of data here: http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones

Short summary: 30 subjects, 6 activities, 561 features measured (time and frequency domain variables) from Samsung Galaxy S II.


#Steps producing tidy data set:

Read in x_train and x_test (feature measurments)
Combined these two datasets into a data frame called data (10299 observations)

Read in y_train and y_test (activity labels)
Combined labels into data frame called label

Read in subject_train and subject_test (subject ids)
Combine labels into data frame called subject

Read in feature list ("feature.txt" file, stings as characters, not factors)
Looked through the feature names (561) using grep() (had to escape parantheses using \\) and find all entries with "mean()" or "std()", got a total of 66.

Put all 10299 observations for those selected 66 variables into "data_subset" data frame
Labeled columns of data_subset with strings from feature list

Added activity labels and subject IDs as columns (as factors)

Read in activity labels with descriptive activity names from "activity_labels.txt"
Merged data_subset with those descriptive activity names
Got rid of column with activity labeled as numbers (just because it's not necessary now that we have the descriptive activity labels)

#Variables of tidy data set:

*68 variables:
	*ActivityName: name of activity
	*ID: ID of subject
	*66 features labeled as in "features.txt" of raw data

*180 observations:
	*6 Activities
	*30 ssubjects