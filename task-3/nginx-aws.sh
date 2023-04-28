#!/bin/bash

# Installing AWS CLI
sudo yum install awscli -y

# Prompt user to enter AWS account ID
read -p "Enter your AWS account ID: " account_id

# Prompt user to enter AWS access key ID
read -p "Enter your AWS access key ID: " access_key_id

# Prompt user to enter AWS secret access key
read -p "Enter your AWS secret access key: " secret_access_key

# Prompt user to enter AWS region
read -p "Enter your AWS region: " region

# Prompt user to enter IAM user name
read -p "Enter your IAM user name: " user_name

# Prompt user to enter S3 bucket name
read -p "Enter your S3 bucket name: " bucket_name

# Prompt user to enter local file directory path
read -p "Enter the path of your local file directory: " local_file_path

# Configure AWS CLI
echo "Configuring AWS CLI..."
aws configure set aws_access_key_id $access_key_id
aws configure set aws_secret_access_key $secret_access_key
aws configure set default.region $region

# Check S3 buckets
echo "Checking existing S3 buckets..."
aws s3 ls

# Create S3 bucket
echo "Creating S3 bucket..."
aws s3api create-bucket --bucket $bucket_name --region $region

# Turn off block public access for the bucket
aws s3api put-public-access-block --bucket "${bucket_name}" --public-access-block-configuration "BlockPublicAcls=false,IgnorePublicAcls=false,BlockPublicPolicy=false,RestrictPublicBuckets=false"

# Copy local files to S3 bucket
echo "Copying files to S3 bucket..."
aws s3 cp $local_file_path s3://$bucket_name --recursive

# Display result
echo "Displaying contents of S3 bucket..."
aws s3 ls s3://$bucket_name/


# Set bucket policy for website hosting
bucket_policy=$(cat <<EOF
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Sid": "PublicReadGetObject",
            "Effect": "Allow",
            "Principal": "*",
            "Action": [
                "s3:GetObject"
            ],
            "Resource": [
                "arn:aws:s3:::$bucket_name/*"
            ]
        }
    ]
}
EOF
)
aws s3api put-bucket-policy --bucket $bucket_name --policy "$bucket_policy"

# Enable website hosting
aws s3 website s3://$bucket_name/ --index-document index.html

# Display website URL
website_url=$(aws s3api get-bucket-website --bucket $bucket_name | grep -o 'http://.*')
echo "Website URL: $website_url"
