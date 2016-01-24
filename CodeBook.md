# Code Book
The codebook describes the variables, the data, and any transformations or work that were performed to clean up the data.

##Data Sources

[Original Data Source](https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip)

[Original Description of the Data Set](http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones)

##Data Set

###Input Data

- `features_info.txt`: Shows information about the variables used on the feature vector.
- `features.txt`: List of all features.
- `activity_labels.txt`: Links the class labels with their activity name.
- `train/X_train.txt`:Training set.
- `train/y_train.txt`: Training labels.
- `train/subject_train.txt`: Subjects from whom Training data was collected.
- `test/X_test.txt`: Test set.
- `test/y_test.txt`: Test labels.
- `test/subject_test.txt`: Subjects from whom Test data was collected.

##Variables & Transformations
This are the transformations made and variables the (intermediate results) were saved in:

- `features.txt` is read into `features`
- `X_train.txt` is read into table `train_x`
- `y_train.txt` is read into table `train_y`
- `subject_train.txt` is read into table `train_sub`
- `features` are applied to `train_x`
- only mean and std data from train data is saved to new data frame `train_x_ms`
- subjects and labels from  `train_sub` and `train_y` are added to the `train_x_ms`

- `X_test.txt` is read into table `test_x`
- `y_test.txt` is read into table `test_y`
- `subject_test.txt` is read into table `test_sub`
- `features` are applied to `test_x`
- only mean and std data from test data is saved to new data frame `test_x_ms`
- subjects and labels from  `test_sub` and `test_y` are added to the `test_x_ms`

- `train_x_ms`, `test_x_ms` are merged and saved to `merge_train_test`

- `activity_labels.txt` is read into `activity_labels`
- `activity_labels` are joined to `merge_train_test` ans saved to `merge_train_test_act`

- existing variable names are replaced with more descriptive ones

- means are being created on a subject and activity level and saved to `aggr_tidy`
- data is ordered by `subject` and `activity`

- finally, data in `aggr_tidy` data frame is extracted to `tidy.txt`


## Output Data Set
The output data in `tidy.txt` is space delimited, whereas the first line contains the names of the variables. It contains the mean and standard deviation values of the data contained in the input files, aggregated by the subjects and their activities.