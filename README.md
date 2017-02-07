# Getting-and-Cleaning-Data---Course-Project
'run_analysis.R' is an R file with code which downloads the samsung smartphone data, merges the training and test data, and keeps only the variables which have 'mean()' or 'std()' in the variable name. It then creates a tidy dataset with the average each of these measures for each subject and activity. This new dataset is written to a text file at the end of the code.  This entire code can be run to produce the final data set as long as the original samsung smartphone data in is the working directory. 

'CodeBook.md' explains what each variable/data frame in the R code is, and how it was created by transforming another variable/data frame. 

'Subject and activity averages.txt' is the final tidy data set required by the project (the output of the R code)
