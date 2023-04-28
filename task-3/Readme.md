# AWS S3 Website Hosting Setup Script

This is a Bash script that automates the process of setting up an AWS S3 bucket for website hosting. It prompts the user for the necessary information, such as the AWS account ID, access key ID, secret access key, region, IAM user name, S3 bucket name, and local file directory path. Then, it installs the AWS CLI, configures it, creates an S3 bucket, copies the local files to the bucket, sets the bucket policy for public access, enables website hosting, and displays the website URL.

## Requirements

To run this script, you need:

- AWS account
- AWS CLI installed on your machine
- shell

## Usage

1. Download the tar file and copy script code to a file on your local machine.
2. Open a terminal window and navigate to the directory where the script is located.
3. Make the script executable by running the command `chmod +x script.sh`.
4. Run the script by running the command `./script.sh`.
5. Follow the prompts and enter the required information.
6. After the script finishes executing, visit the website URL displayed to see your aws s3 bucket.

## Note

This script sets the bucket policy for public access, which means that anyone can access the files in the S3 bucket. If you don't want your files to be publicly accessible, you need to modify the bucket policy accordingly.