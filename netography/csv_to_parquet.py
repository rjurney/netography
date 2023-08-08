# This file converts the assignment CSV files to Parquet format

import pandas as pd

# Read the CSV files
test_df: pd.DataFrame = pd.read_csv("data/ml-engineer-main/IoT network intrustion dataset test.csv.gz")
train_df: pd.DataFrame = pd.read_csv("data/ml-engineer-main/IoT network intrustion dataset train.csv.gz")

# Convert the CSV files to Parquet format
test_df.to_parquet("data/ml-engineer-main/iot_network_intrustion_dataset_test.parquet")
train_df.to_parquet("data/ml-engineer-main/iot_network_intrustion_dataset_train.parquet")
