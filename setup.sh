#!/bin/bash

# Pull the latest LocalStack Docker image
echo "Pulling LocalStack Docker image..."
docker pull localstack/localstack

# Start LocalStack container
echo "Starting LocalStack container..."
docker run --rm -d -p 4566:4566 -p 4571:4571 --name localstack_main localstack/localstack

# Wait for LocalStack to be fully initialized
echo "Waiting for LocalStack to initialize..."
sleep 10

# Install awscli and awscli-local (awslocal)
echo "Installing awscli and awscli-local..."
pip install awscli awscli-local

# Create aliases for awslocal commands
echo "Creating aliases for awslocal commands..."
alias awslocal="aws --endpoint-url=http://localhost:4566"

# Verify installation
echo "Verifying LocalStack and awslocal..."
docker ps | grep localstack
awslocal --version

# Example command: List S3 buckets
echo "Listing S3 buckets using awslocal..."
awslocal s3api list-buckets

echo "LocalStack setup complete."
