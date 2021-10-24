run_analysis.R produces two tidy data files (one raw and one aggregated with means) from Samsung Galaxy S II smartphone data collected and provided by the Center for Machine Learning and Intelligence Systems UCI.

See: http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones

The run_analysis.R script:
1) Downloads and unzips the Human Activity Recognication Using Smartphones Data Set
2) Creates dataframes for dataset data for features, activities, subjects, training data, test data
3) The dataset data is then merged, labelled and cleaned
4) tidy_dataset1.csv is produced from using average and standard deviation features in the dataset
5) tidy_dataset2.csv is produced by averaging the averages and standard deviations in the original dataset by activity and subject
