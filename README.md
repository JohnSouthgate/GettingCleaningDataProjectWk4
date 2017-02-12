---
title: "Tidy Data README"
author: "John Southgate"
date: "12 February 2017"
output: html_document
---

```{r setup, include=FALSE}
knitr::opts_chunk$set(echo = TRUE)
```

# Tidy Data Project


## Objective

The purpose of this project is to provide two(2) tidy files for further analysis from a dataset of observations and reference files on tests and training samples for wearable technology.

## Output files

The output files are:

### cleanData.txt
sampled feature observations (mean, std) over time for each subject (person wearing the technology) and activity e.g. SITTING, WALKING.

### cleanDataAvg.txt
mean feature observations for each subject and activity for the 66 feature variables with "mean"" or "std"" in names.

## Input files

These files were containined within the zip file DataSet.zip and described in the associated README.txt file. The main files were:

- 'README.txt'
- 'features_info.txt': 	Shows information about the variables used on the feature vector.
- 'features.txt': 		List of all features.
- 'activity_labels.txt': Links the class labels with their activity name.
- 'train/X_train.txt': 	Training set.
- 'train/y_train.txt': 	Training labels.
- 'test/X_test.txt': 	Test set.
- 'test/y_test.txt': 	Test labels.

## Methodology		

To produce the output files, a single script run_analysis.R was run on the input files.
No packages were required.

The script performs these steps:

1. Merges the training and the test sets to create one data set.
2. Extracts only the measurements on the mean and standard deviation for each measurement.
3. Uses descriptive activity names to name the activities in the data set.
4. Appropriately labels the data set with descriptive activity names.
5. Creates a second, independent tidy data set with the average of each variable for each activity and each subject.

## Reference - codebook

Accompanying the two output files is a codebook or data dictionary describing all items in the output. Refer to codebook.Rmd for details
