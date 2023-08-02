#!/bin/bash

set -e

# OVERVIEW
# This script sets username and email address in Git config

# PARAMETERS
YOUR_USER_NAME="rjurney"
YOUR_EMAIL_ADDRESS="russell.jurney@gmail.com"

sudo -u ec2-user -i <<EOF

git config --global user.name "$YOUR_USER_NAME"
git config --global user.email "$YOUR_EMAIL_ADDRESS"

EOF
