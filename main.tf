terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

# Dummy AWS credentials for LocalStack
provider "aws" {
  region                      = "us-east-1"
  access_key                  = "test"
  secret_key                  = "test"
  skip_credentials_validation = true
  skip_metadata_api_check     = true
  skip_requesting_account_id  = true
}

# 1. Create S3 Bucket (SAA-C03 Concept: Object Storage)
resource "aws_s3_bucket" "saa_demo_bucket" {
  bucket = "aditya-exam-practice-bucket"
}

# 2. Create DynamoDB Table (SAA-C03 Concept: Key-Value NoSQL Database)
resource "aws_dynamodb_table" "user_orders" {
  name         = "UserOrders"
  billing_mode = "PAY_PER_REQUEST" # On-Demand capacity
  hash_key     = "OrderId"

  attribute {
    name = "OrderId"
    type = "S" # String
  }
}