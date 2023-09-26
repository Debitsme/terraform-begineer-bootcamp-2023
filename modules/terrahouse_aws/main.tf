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

# block for static website configurations
resource "aws_s3_bucket_website_configuration" "static_website" {
  bucket = aws_s3_bucket.bucket_1.bucket
  index_document {
    suffix = "index.html"
  }
  error_document {
    key = "error.html"
  }
}

#block to upload the index.html file
resource "aws_s3_object" "index_html" {
  bucket = aws_s3_bucket.bucket_1.bucket
  key    = "index.html"
  #The issue here is that tfstate check the resource and not the data so if we 
  #will change the data inside the index.htl and rerun it. Nothings will be changed.
  # For this purpose we will use etags
  source = "${path.root}/public/index.html"
  #its a function that will create a hash based on the content of the file
  etag = filemd5("${path.root}/public/index.html")
}

#block to upload the error.html file
resource "aws_s3_object" "error_html" {
  bucket = aws_s3_bucket.bucket_1.bucket
  key    = "error.html"
  #The issue here is that tfstate check the resource and not the data so if we 
  #will change the data inside the index.htl and rerun it. Nothings will be changed.
  # For this purpose we will use etags
  source = "${path.root}/public/error.html"
  #its a function that will create a hash based on the content of the file
  etag = filemd5("${path.root}/public/error.html")
}