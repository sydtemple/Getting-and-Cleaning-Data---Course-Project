# Getting-and-Cleaning-Data---Course-Project
run_analysis.R is R code which downloads the samsung smartphone data, keeps only the variables which have 'mean()' or 'std()' in the variable name. It then creates a tidy dataset with the average each of these measures for each subject and activity. This new dataset is written to a text file at the end of the code.  
## Variable Descriptions:
* `allFiles`:  a character vector of the names of all files (datasets) in the downloaded zip file. 
* `allData`: uses sapply to read all data sets into R

* `train`: single data frame with training data
  - first column is the activity label
  - last column is the subject label
  - all columns between are the measurement variables
* `test`: same as "train" but for the test data

* `trainAndTest`: data frame with training data and test data together
* column names of `trainAndTest` are changed using the `features.txt` file

* `trainAndTest2`: subset of 'trainAndTest' with only mean and std measurements

* `trainAndTest3`: new data frame made by merging `trainAndTest2` with the `activity labels` data set by the activity number variable

* `trainAndTest4`: rearrangement of columns of `trainAndTest3`

* `trainAndTest5`: removes `subject number` variable

* `averages`: aggregates `trainAndTest5` on activity number and subject number, taking the mean of every other column to create a new data frame that has one row per activity per subject and the average of each column

* `averages2`: removes `group` columns created by the aggregation

* `averages3`: adds names of the activities

* `averages4`: reorders the data frame by activity and then by subject number
