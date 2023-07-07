<center><img src="images/netography_logo_white.png" alt="Negography logo, white background" /></center>

# Netography Interview Project

This project is a coding challenge from Netography assigned to candidate Russell Jurney.

## Assignment Email

This email was received from David Meltzer on July 6, 2023 at 8:59AM PST. I began work at 6:00PM that day.

> Hi Russell,
>
> As I mentioned last week, the challenge is the last step in our interview process.  I have provided the instructions below, but if you need any clarification or have problems with how we have defined this, please let us know.  To the extent you incur any AWS costs as part of this, we will reimburse you.  There is no fixed deadline for this, but we are hoping to have it back within the next week or so to be able to make a decision.  
>
> ----
>
> Use the IOT intrusion detection dataset for a supervised anomaly detection task. The label column indicates whether each row's data is normal or anomalous.
You can choose an ML classifier for training on this dataset.
>
> The task is to build a classifier using the train dataset and deploy a trained model in Sagemaker.
You can use your personal AWS account to do this.
The classifier should be able to generate robust classification metrics on a held-out test/validation dataset. You can use a portion of your train set for validation metrics.
>
> As for output, please send us a link to the code and classification results in your git repository when you are done. Configuration should be through an orchestration system so we can re-create the environment programmatically.
>
> We will use a held-out test set to evaluate your model's performance.
>
> Test data can be found here: https://github.com/netography/ml-engineer/archive/refs/heads/main.zip
>
> It can also be found here: https://www.dropbox.com/scl/fi/oz1fspqu4mago3wxeb9dp/IoT-network-intrustion-dataset-train.csv?rlkey=d6hblxlw4t163tt386w16gldi&dl=0
>
> -Dave

## Language: Python

This project uses Python 3.10.

Netography is a Go shop, but I will be using Python for all phases of this project. The reason for this is that there is a lot to do, so I am deferring learning Go until the onboarding phase of my hiring. I have familiarized myself with Go's features and look forward to doing so :)

## Project Dataset

...

## Project Structure

There are seven phases to this project. I will attempt to perform all seven in the next week.

1) Setup a clean VPC using CloudFormation
2) Setup SageMaker profiles and start a notebook
3) Perform exploratory data analysis of the IoT data
4) Develop a baseline anomaly detection model
5) Iteratively improve and tune the model 
6) Deploy the model using SageMaker
7) Create a simple Streamlit frontend

### 1. Setup a Clean VPC with CloudFormation

When time permits, I like to setup my infrastructure using DevOps principles from the beginning of a project. I like CloudFormation for AWS DevOps over Terraform because Terraform has interfaces that vary widely across clouds, creating duplicate work. I am familiar with Terraform but that is not an issue in this project so I chose CloudFormation.

### 2. Setup SageMarker Notebooks

I have a dual GPU deep learning machine at home but there is overlap between SageMaker notebook setup and the MLOps profile for model deployment.

### 3. Exploratory Data Analysis

I can't model what I don't understand. In this phase I will explore the data to determine how best to model it.

### 4. Baseline Anomaly Detection Model

I always create a baseline model first to compare with more sophisticated models and determine if time spent refining them is well spent. Exploratory data analysis will indicate what baseline model to begin with. The goal is to build a model that works, although poor performance is tolerable at this stage.

### 5. Iteratively Improve and Tune the Model

* I will select and implement a more powerful anomaly detection model
* I will instrument the model using Weights & Biases in the [rjurney/netography-iot-anomaly](https://wandb.ai/rjurney/netography-iot-anomaly) project.
* I will iteratively fiddle with the data, the model architecture and its hyperparameters to optimize performance.

### 6. Deploy the Model on SageMaker

I will extend the AWS network and SageMaker notebook setup from steps 1 and 2 to create an MLOps profile and deploy a model using SageMaker to perform inference at an API endpoint.

### 7. Steamlit Frontend

[Streamlit](https://streamlit.io/) makes it so easy to build Pythonic web frontends for Python models in order to give them a human face that it is a shame not to whip something up if I have time :) This will be as simple as possible. I will have to evaluate this step versus SageMaker's own capabilities.

