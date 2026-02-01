# GettingAndCleaningDataCourseProject
Repository for Getting and Cleaning Data Course on Coursera

# Human Activity Recognition Using Smartphones - Data Cleaning and Summarization

## Project Description
This project processes the **Human Activity Recognition Using Smartphones Dataset (UCI HAR Dataset)**.  
The goal is to clean and tidy the data by:

- Merging training and test datasets
- Extracting only measurements on the mean and standard deviation
- Labeling activities with descriptive names
- Creating a second tidy dataset with the average of each variable for each activity and each subject

The resulting datasets are suitable for further analysis or reporting.

## Files in the Repository

- `get_data.R`
  R script that automatically downloads and unzips the UCI HAR Dataset

- `run_analysis.R`  
  R script that performs the data cleaning, labeling, and summarization.

- `results/human_activity_recognition_using_smartphones_tidy.csv`  
  Tidy dataset with selected measurements and descriptive variable names.

- `results/human_activity_mean_summary_by_subject_and_activity.csv`  
  Dataset with the average of each variable for each activity and each subject.


