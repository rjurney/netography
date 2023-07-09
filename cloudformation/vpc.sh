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

# Check if the first argument is "create" and no parameters are supplied
if [[ $1 == "create" && $# -eq 1 ]]; then
    echo "First argument is 'create' and there are no additional parameters."
else
    echo "The conditions are not met."
fi

ACTION=$1
STACK_NAME=$2
PARAMETERS=${@:3} # Get all the rest of the arguments as parameter key/value pairs

MYIP=$(curl -s https://checkip.amazonaws.com)

case "$ACTION" in
    create)
        echo "Creating CloudFormation stack $STACK_NAME"
        aws cloudformation create-stack \
            --color 'on' \
            --stack-name "$STACK_NAME" \
            --template-body file://VPC_With_PublicIPs_And_DNS.template.yaml \
            --parameters ParameterKey=SSHLocation,ParameterValue="$MYIP/32"
        echo "CloudFormation stack $STACK_NAME created"
        ;;
    delete)
        echo "Deleting stack $STACK_NAME"
        aws cloudformation delete-stack \
            --color 'on' \
            --stack-name "$STACK_NAME"
        echo "CloudFormation stack $STACK_NAME deleted"
        ;;
    *)
        echo "Unknown action $ACTION. Usage: $0 {create|delete} stack-name"
        exit 1
esac