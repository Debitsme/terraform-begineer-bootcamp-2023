#To generate a random name
terraform {

   cloud {
    organization = "hamzaali"

    workspaces {
      name = "terraform-beginner-bootcamp_2023"
    }
  }

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
