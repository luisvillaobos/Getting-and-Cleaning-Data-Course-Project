Getting-and-Cleaning-Data-Course-Project
========================================

This is the repository for my project form the course Getting and Cleaning data

Dataset provided by:    
[1] Davide Anguita, Alessandro Ghio, Luca Oneto, Xavier Parra and Jorge L. Reyes-Ortiz. Human Activity Recognition on Smartphones using a Multiclass Hardware-Friendly Support Vector Machine. International Workshop of Ambient Assisted Living (IWAAL 2012). Vitoria-Gasteiz, Spain. Dec 2012

The link for raw datasets can be found here:
https://archive.ics.uci.edu/ml/machine-learning-databases/00240/UCI%20HAR%20Dataset.zip


This repository contains the following files:
1)CodeBook.md: a Code Book describing the varialbes contained in the dataset.
2)finaldata.txt: the database that resulted from the R script
3)run_analysis.R: the file containing R scripts to generate the databases.

Even if the file "run_analysis.R" contains in commentaries the instructions step by step, here is a brief narrative of how the scripts work:   

The first step is to include the "UCI HAR Dataset" folder in your working directory, otherwise you will not be able to load the files. The next set of scripts load the required files and creates a series of vectorized data frames. The next step is to create a two data frames which include the activities, participant's id and the measured variables which contain means and standard deviations, for this we use the "cbind" function to merge the databases and the "grep" function to select the variables including "mean" or "std" in their labels. At this point we had two datasets, which I merged using "rbind" function, then, i change the numeric values of the activities by strings describing such activities. 

The next scripts incluide coding to create the file "finaldata.txt" (which is also included in this repository) and the codes for obtaining the second database, this database was obtained using the function "aggregate". 

                                                                          AUTHOR: LUIS VILLALOBOS
