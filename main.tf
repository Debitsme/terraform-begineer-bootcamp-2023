# resource "random_string" "bucket_name" {
#   length  = 16
#   special = false
#   upper   = false
#   numeric = false

# }



resource "aws_s3_bucket" "bucket_1" {
  bucket = var.bucket_name

  tags = {
    userID = var.UUID
  }
}