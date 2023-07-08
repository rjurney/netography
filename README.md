# Netography Interview Project

<p align="center">
    <a href="https://netography.com">
        <img src="images/netography_logo_white.png" alt="Netography logo, white background" width="500px" />
    </a>
</p>

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

## Project Dataset

The dataset is a GZip compressed CSV file. Parquet files perform much better at the scale of this dataset, so I converted it to Parquet format in [netography_iot_anomaly/csv_to_parquet.py](netography_iot_anomaly/csv_to_parquet.py).

The original CSV/GZip files are:

```bash
data/ml-engineer-main/IoT network intrustion dataset test.csv.gz
data/ml-engineer-main/IoT network intrustion dataset train.csv.gz
```

The resulting Parquet files are:

```bash
data/ml-engineer-main/iot_network_intrusion_dataset_test.parquet
data/ml-engineer-main/iot_network_intrusion_dataset_train.parquet
```

## Tools and Languages

Development started locally and then moved into SageMaker. The tools and languages used follow.

### AWS CLI v2

AWS CLI v1 may have issues running the commands. You should [upgrade from v1 to v2](https://docs.aws.amazon.com/cli/latest/userguide/getting-started-install.html#getting-started-install-instructions).

```bash
aws-cli/2.12.7 Python/3.11.4 Darwin/22.4.0 exe/x86_64 prompt/off
```

### Docker

Docker is used to build a notebook container for local work and the SageMaker container(s). The Dockerfile is in [netography_iot_anomaly/Dockerfile](netography_iot_anomaly/Dockerfile). It is orchestrated locally using [docker-compose.yml](docker-compose.yml).

```bash
docker compose up -d
docker logs netography-jupyter -f --tail 100
```

You will see the URL to connect to with an access token provided in the logs.

### Python 3.10

Netography is a Go shop, but I will be using Python for all phases of this project. The reason for this is that there is a lot to do, so I am deferring learning Go until the onboarding phase of my hiring. I have familiarized myself with Go's features and look forward to doing so :)

#### Anaconda Python

Locally, this project uses [Anaconda Python](https://docs.anaconda.com/free/anaconda/install/index.html) 3.10.11. To create a `conda` environment run:

```bash
conda create -n netography python=3.10 -y
conda activate netography
```

Then install the poetry dependencies to the `netography` conda environment.

### Pre-Commit

Code must pass `flake8`, `black`, `isort` and `mypy` checks before being committed. This is enforced using [pre-commit](https://pre-commit.com/). To install pre-commit into your local Git repository, run:

```bash
pre-commit install
```

### Poetry Package Manager

For Python tools I use the [Python Poetry](https://python-poetry.org/) as it makes things easy and reproducible.

* Package configuration is stored in [pyproject.toml](pyproject.toml)
* Dependencies are stored in [poetry.lock](poetry.lock)

#### Installing Poetry

To install poetry on *nix, use one of the following commands:

```bash
curl -sSL https://install.python-poetry.org | python3 -
```

or

```bash
pip install poetry
```

or on Windows:

```powershell
(Invoke-WebRequest -Uri https://install.python-poetry.org -UseBasicParsing).Content | py -
```

#### Installing Dependencies

To install dependencies, run:

```bash
poetry install
```

### VSCode Editor

You can use any editor, but there are common settings for VSCode in [.vscode/settings.json](.vscode/settings.json) that should be automatically picked up by VSCode.

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

I started with the template for `us-west-2` for [`VPC_With_PublicIPs_And_DNS.template`](https://s3.us-west-2.amazonaws.com/cloudformation-templates-us-west-2/VPC_With_PublicIPs_And_DNS.template). It was in JSON, so I converted it to YAML. The result is [cloudformation/vpc.yaml](cloudformation/vpc.yaml).

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

## About the Author - Russell Jurney

<p align="left">
    <a href="https://linkedin.com/in/russelljurney">
        <img align="left" src="images/russell_jurney_headshot.jpg" width="200px" alt="A bald man in a nice shirt smiles at you. You feel wonderful!"
    style="margin-right: 15px;" />
    </a>
</p>

My name is [Russell Jurney](https://linkedin.com/in/russelljurney). I work at the intersection of big data, large networks, representation learning, NLP and search. Lately I play with LLMs like everyone else.

I am looking for a job. In the meantime I run a consultancy called Graphlet AI focused on knowledge graphs and Large Language Models (LLMs). You can learn more about my work by viewing my [graph AI portfolio](https://bit.ly/rjurney_portfolio).

I am a startup product and engineering executive focused on building products driven by billion node+ networks using artificial intelligence (AI). I have worked at places like Ning, LinkedIn and Hortonworks. I co-founded Deep Discovery to use networks, GNNs and network visualization to build an explainable risk score for KYC / AML. In the end I developed business network risk motifs on our 3 billion node, 2.2 billion edge network.

I am a four-time O'Reilly author with 124 citations on Google Scholar for being the first to write about “agile data science” - agile development as applied to data science and machine learning. I am an applied researcher and product manager with 17 years of experience building and shipping data-driven products. I do network science, machine learning, NLP and search so I can get stuff done :)
