#To generate a random name
terraform {

  #  cloud {
  #   organization = "hamzaali"

  #   workspaces {
  #     name = "terraform-beginner-bootcamp_2023"
  #   }
  # }

  required_providers {
    random = {
      source  = "hashicorp/random"
      version = "3.5.1"
    }

    aws = {
      source  = "hashicorp/aws"
      version = "5.16.2"
    }
  }
  
}

provider "random" {
  # Configuration options
}

provider "aws" {
  # Configuration options
}



resource "random_string" "bucket_name" {
  length  = 16
  special = false
  upper   = false
  numeric = false

}

output "My_bucket_name" {
  value = random_string.bucket_name.result
}

resource "aws_s3_bucket" "bucket_1" {
  bucket = random_string.bucket_name.result

  tags = {
    Name        = "My bucket"
    Environment = "Dev"
  }
}