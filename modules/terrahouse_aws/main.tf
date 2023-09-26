terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "5.16.2"
    }
  }
  
}

provider "aws" {
  # Configuration options
}

# S3 storage
resource "aws_s3_bucket" "bucket_1" {
  bucket = var.bucket_name

  tags = {
    userID = var.UUID
  }
}