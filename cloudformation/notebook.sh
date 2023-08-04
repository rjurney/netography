#!/usr/bin/env bash

# Usage: ./vpc.sh {create|delete} stack-name ParameterKey=Parm1,ParameterValue=test1 ...

# Ensure AWS CLI is installed
if ! command -v aws &> /dev/null; then
    echo "AWS CLI could not be found. Please install it before running this script."
    exit 1
fi

# Check if correct arguments are passed
if [[ $# -lt 2 ]]; then
    echo "Usage: $0 {create|delete} stack-name ParameterKey=Parm1,ParameterValue=test1 ..."
    exit 1
fi

ACTION=$1
STACK_NAME=$2
PARAMETERS=${@:3} # Get all the rest of the arguments as parameter key/value pairs

case "$ACTION" in
    create)
        echo "Creating CloudFormation SageMaker Notebook stack $STACK_NAME"
        aws cloudformation create-stack \
            --color 'on' \
            --stack-name "$STACK_NAME" \
            --capabilities CAPABILITY_NAMED_IAM \
            --template-body file://cloudformation/SageMaker_Notebook.template.yaml
        # Check the exit status of the 'aws cloudformation create-stack' command
        if [[ $? -ne 0 ]]; then
            echo "Error creating CloudFormation stack $STACK_NAME"
            exit 1
        else
            echo "CloudFormation stack $STACK_NAME created"
        fi
        ;;
    delete)
        echo "Deleting stack $STACK_NAME"
        aws cloudformation delete-stack \
            --color 'on' \
            --stack-name "$STACK_NAME"
        if [[ $? -ne 0 ]]; then
            echo "Error deleting CloudFormation stack $STACK_NAME"
            exit 1
        else
            echo "CloudFormation stack $STACK_NAME deleted"
        fi
        ;;
    *)
        echo "Unknown action $ACTION. Usage: $0 {create|delete} stack-name"
        exit 1
esac
