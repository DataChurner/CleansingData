# CleansingData
Repo for the cleansing data course

The run_analysis.R script is trying to extrapolate the mean of some of the variables
in a collection of both test and training data from a samsung accelerometer device.
the collection is from an audience of 30 subjects who were given 6 activities like
walking, walking upstairs, laying, etc. and teh gyroscopic accelerometer recordings is
the data we are cleansing. The data has undergone previous calculations/computation, 
but its in an unaltered state for this exercise, and will be considered raw.

The accelerometer data is condensed, and attached to the subjects and given a meaningful
variable name, as well as the activity id is supported by the factor of the name as well.
once we have the relevent data, we are calculating the average gyroscopic readings at an 
activity and a subject level and has not been rounded.
 