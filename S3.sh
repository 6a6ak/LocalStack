#!/bin/bash

# Function to list existing S3 buckets
list_s3_buckets() {
  echo "Listing S3 buckets using awslocal..."
  awslocal s3api list-buckets
}

# Function to create a new S3 bucket
create_s3_bucket() {
  read -p "Enter the name for the new S3 bucket: " bucket_name
  echo "Creating S3 bucket '$bucket_name' using awslocal..."
  awslocal s3api create-bucket --bucket "$bucket_name"
}

# Function to delete an S3 bucket
delete_s3_bucket() {
  echo "Listing S3 buckets using awslocal..."
  local buckets
  buckets=$(awslocal s3api list-buckets --query 'Buckets[].Name' --output text)
  echo "Existing buckets:"
  echo "$buckets"
  read -p "Enter the name of the bucket you want to delete: " bucket_name
  read -p "Are you sure you want to delete the bucket '$bucket_name'? (yes/no): " confirm
  if [[ "$confirm" == "yes" ]]; then
    echo "Deleting S3 bucket '$bucket_name' using awslocal..."
    awslocal s3api delete-bucket --bucket "$bucket_name"
    echo "Bucket '$bucket_name' deleted."
  else
    echo "Deletion cancelled."
  fi
}

# Menu options
echo "Choose an option:"
echo "1. List existing S3 buckets"
echo "2. Create a new S3 bucket"
echo "3. Delete an existing S3 bucket"

read -p "Enter your choice [1-3]: " choice

case $choice in
  1)
    list_s3_buckets
    ;;
  2)
    create_s3_bucket
    ;;
  3)
    delete_s3_bucket
    ;;
  *)
    echo "Invalid choice, please run the script again and choose a valid option."
    ;;
esac

echo "Operation complete."
