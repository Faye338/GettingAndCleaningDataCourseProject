#Read libraries
library(tidyverse)
# Read files
column_names <- read.table("./human_activity_dataset/UCI HAR Dataset/features.txt")
train <- read.table("./human_activity_dataset/UCI HAR Dataset/train/X_train.txt")
test <- read.table("./human_activity_dataset/UCI HAR Dataset/test/X_test.txt")
subject_train <- read.table("./human_activity_dataset/UCI HAR Dataset/train/subject_train.txt")
subject_test <- read.table("./human_activity_dataset/UCI HAR Dataset/test/subject_test.txt")
activity_train <- read.table("./human_activity_dataset/UCI HAR Dataset/train/y_train.txt")
activity_test <- read.table("./human_activity_dataset/UCI HAR Dataset/test/y_test.txt")
activity_labels <- read.table("./human_activity_dataset/UCI HAR Dataset/activity_labels.txt")

#Concat subjects data sets
subject <- rbind(subject_train, subject_test)

#Add column name to subject df
names(subject) <- "Subject"

#Concat activity data sets 
activities <- rbind(activity_train, activity_test)

# Add column name to labels df
names(activities) <- "ActivityNumber"

# Concat train and test data sets
human_activity <- rbind(train, test)

#Add column names
names(human_activity) <- column_names[,2]

#Merge subject, activity and measurments
human_activity1 <- cbind(subject, activities, human_activity)

# Add descriptive activity names
names(activity_labels) <- c("ActivityNumber", "ActivityLabel")

# Extract mean and standard deviation columns
# Add decriptive activity names
human_activity1 %>% 
    select(
        grep("subject|activity|mean\\(|std\\(",
             names(human_activity1),
             value = T,
             ignore.case = T)
    ) %>%
    left_join(
        activity_labels,
        by = "ActivityNumber"
    ) %>%
    relocate(
        last_col(),
        .after = 2
    ) -> human_activity2

# Label data set with descriptive variable names

names(human_activity2) <- gsub("^t", "Time",
                            gsub("^f", "Frequency",
                                gsub("Acc", "Accelerometer",
                                    gsub("Gyro", "Gyroscope",
                                        gsub("Mag", "Magnitude",
                                             gsub("-mean\\(\\)\\-", "Mean",
                                                  gsub("-std\\(\\)\\-", "Std",
                                                    names(human_activity2))))))))

# Group by activity and subject
human_activity2 %>%
    group_by(
        Subject, ActivityLabel
        ) %>%
    summarise(
        across(where(is.numeric), \(x) mean(x, na.rm = TRUE)),
        .groups = "drop"
    ) -> human_activity_mean_summary_by_subject_and_activity


# Save result 
if(!dir.exists("results")){
    dir.create("results")
}

write.csv(human_activity2, "results/human_activity_recognition_using_smartphones_tidy.csv")
write.csv(human_activity_mean_summary_by_subject_and_activity, 
          "results/human_activity_mean_summary_by_subject_and_activity.csv")
