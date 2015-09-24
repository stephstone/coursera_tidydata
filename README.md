==================================================================
Tidy Data Set Assignment Using Smartphones Dataset
==================================================================

The data expressed in the Human Activity Recognition Using Smartphones Data Set located at http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones were 
used to create a subset of summary data pertaining to mean and standard deviation of accelerometer and gyroscope data.

The data were processed using two R functions in the run_analysis.R script, first combining training and test data, and layering in subject ID and activity associated with each record.  Subsequently, the data were subsetted by retaining only columns where mean or standard deviation values were recorded.  Finally, the data were grouped by subject and activity, and the mean value of each column in the subset was calculated and labeled as a new variable.

The resultant data set contains subject and activity group names, and an 80-feature vector with the mean values calculated as described above.


For each record the following are returned:
======================================

- An identifier of the subject who carried out the experiment.
- Activity ID and descriptive label
- An 80-feature vector with the mean value of each of the time and frequency domain variables where mean or standard deviation were expressed.



