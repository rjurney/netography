#!/usr/bin/env bash

# Usage: ./keypair.sh {create|delete} keypair-name

# Ensure AWS CLI is installed
if ! command -v aws &> /dev/null; then
    echo "AWS CLI could not be found. Please install it before running this script."
    exit 1
fi

# Check if correct arguments are passed
if [[ $# -ne 2 ]]; then
    echo "Usage: $0 {create|delete} keypair-name"
    exit 1
fi

ACTION=$1
KEY_NAME=$2

case "$ACTION" in
    create)
        echo "Creating key pair $KEY_NAME"
        aws ec2 create-key-pair \
            --color 'on' \
            --key-type 'ed25519' \
            --key-format 'pem' \
            --key-name "$KEY_NAME" \
            --query 'KeyMaterial' \
            --output text > "$KEY_NAME.pem"
        chmod 400 "$KEY_NAME.pem"
        echo "Key pair $KEY_NAME created and stored in $KEY_NAME.pem"
        ;;
    delete)
        echo "Deleting key pair $KEY_NAME"
        aws ec2 delete-key-pair \
            --color 'on' \
            --key-name "$KEY_NAME"
        rm -f "$KEY_NAME.pem"
        echo "Key pair $KEY_NAME deleted"
        ;;
    *)
        echo "Unknown action $ACTION. Usage: $0 {create|delete} keypair-name"
        exit 1
esac