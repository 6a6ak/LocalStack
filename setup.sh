#!/bin/bash

# Function to pull the latest LocalStack Docker image
pull_localstack() {
  echo "Pulling LocalStack Docker image..."
  docker pull localstack/localstack
}

# Function to start LocalStack container
start_localstack() {
  echo "Starting LocalStack container..."
  docker run --rm -d -p 4566:4566 -p 4571:4571 --name localstack_main localstack/localstack
  echo "Waiting for LocalStack to initialize..."
  sleep 10
}

# Function to install awscli and awscli-local (awslocal)
install_awscli_local() {
  echo "Installing awscli and awscli-local..."
  pip install awscli awscli-local
  echo "Creating aliases for awslocal commands..."
  alias awslocal="aws --endpoint-url=http://localhost:4566"
}

# Function to verify installation
verify_installation() {
  echo "Verifying LocalStack and awslocal..."
  docker ps | grep localstack
  awslocal --version
  echo "Listing S3 buckets using awslocal..."
  awslocal s3api list-buckets
}

# Menu options
echo "Choose an option:"
echo "1. Pull LocalStack Docker image"
echo "2. Start LocalStack container"
echo "3. Install awscli and awscli-local"
echo "4. Verify installation"
echo "5. All of the above"

read -p "Enter your choice [1-5]: " choice

case $choice in
  1)
    pull_localstack
    ;;
  2)
    start_localstack
    ;;
  3)
    install_awscli_local
    ;;
  4)
    verify_installation
    ;;
  5)
    pull_localstack
    start_localstack
    install_awscli_local
    verify_installation
    ;;
  *)
    echo "Invalid choice, please run the script again and choose a valid option."
    ;;
esac

echo "Operation complete."
