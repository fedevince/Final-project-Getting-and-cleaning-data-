# **Codebook**

The script included tries to clean the data provided in the original data set in these five steps, as requested for the assignment. 

First of all, the the script calls a function to download and unzip the files from the dataset. Then the content of the file texts in the downloaded folders is saved into R objects with the read.table() function. The variables are named while being read by these functions.
* features.txt contains two columns which are named **n** and **functions**
* activity_labels.txt contains two columns and six observations. The variables are saved as **id** (an integer from 1 to 6) and **activity**
* then the files inside the test and train folders are read
  * the subject_test.txt and the subject_train.txt, and the y_test.txt and y_train.txt files contain only one column each which are named   respectively **subject** and **code** 
  * the x_test.txt and x_train.txt files columns are named using the values from the functions column in the feature table

Once the data are read and saved, the script procedes with the main assignments:
## 1. Merges the training and the test sets to create one data set.
  This is accomplised using the *rbind()* and *cbind()* functions. The merged table is named **full_data**
  
## 2. Extracts only the measurements on the mean and standard deviation for each measurement.
  This is accomplished using the *dplyr* library and the function *select()*. The result is called **tidy_data**
  
## 3. Uses descriptive activity names to name the activities in the data set
 The activity names are present in the second column of **full_data** which are renamed assigning them the values present in the activities tables
 
## 4. Appropriately labels the data set with descriptive variable names.
 Most of the columns were already assigned descriptive names with the *read.table()* function. The name of the second column is changed to "Activity" using the *rename()* dplyr function.
 
## 5. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.
  This is accomplished using the *group_by()* and *summarise_all()* dplyr functions. The result is saved into an object called **final_tidy_data**
