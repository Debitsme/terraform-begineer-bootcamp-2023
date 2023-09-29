#To generate a random name
terraform {

  #  cloud {
  #   organization = "hamzaali"

  #   workspaces {
  #     name = "terraform-beginner-bootcamp_2023"
  #   }
  # }

  # required_providers {
  #   # random = {
  #   #   source  = "hashicorp/random"
  #   #   version = "3.5.1"
  #   # }


  # }

}

# provider "random" {
#   # Configuration options
# }




# resource "random_string" "bucket_name" {
#   length  = 16
#   special = false
#   upper   = false
#   numeric = false

# }

module "terrahouse" {
  source      = "./modules/terrahouse_aws"
  bucket_name = var.bucket_name
  UUID        = var.UUID

}