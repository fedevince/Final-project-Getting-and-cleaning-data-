# Download the zip file if it does not exist already, then unzip it 
uci_data <- "File.zip"
if (!file.exists(uci_data)){
url <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
download.file(url, uci_data)}
if (!file.exists("UCI HAR Dataset")){
unzip(uci_data)}

# Read the text files from the main folder and save it in the features and activities tables.
# Descriptive names are given to the variables (as required by step 4 of the assignement). 
# Then the process is repeated for the files contained in the test and train folders
features <- read.table("./UCI HAR Dataset/features.txt", col.names = c("n", "functions"))
activities <- read.table("./UCI HAR Dataset/activity_labels.txt", col.names = c("id", "activity"))
subject_test <- read.table("./UCI HAR Dataset/test/subject_test.txt", col.names = ("subject"))
y_test <- read.table("./UCI HAR Dataset/test/y_test.txt", col.names = c("code"))
subject_train <- read.table("./UCI HAR Dataset/train/subject_train.txt", col.names = ("subject"))
y_train <- read.table("./UCI HAR Dataset/train/y_train.txt", col.names = ("code"))

# The values from the function columns in the features table are also used to name the columns
# of these files
x_test <- read.table("./UCI HAR Dataset/test/X_test.txt", col.names = features$functions)
x_train <- read.table("./UCI HAR Dataset/train/X_train.txt", col.names = features$functions)

# Merge tables obtained in the previous steps
x <- rbind(x_train, x_test); y <- rbind(y_train, y_test)
subject <- rbind(subject_train, subject_test)
full_data <- cbind(subject, y, x)

# Extract columns that contain the mean and the standard deviation of the measurements u
tidy_data <- select(subject, code, contains("mean"), contains("std"))

# Use descriptive names to name the activities in the data set (the columns were already assigned
# some descriptive names when read with read.tables)
tidy_data$code <- activities[tidy_data$code, 2]

# Rename using descriptive variable names
tidy_data <- tidy_data %>% rename(Activity = code)

# From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.
final_tidy_data <- tidy_data %>% group_by(Activity, subject) %>% summarise_all(funs(mean))
write.table(final_tidy_data, "Final.txt", row.names = FALSE)
