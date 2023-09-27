
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
  #issue decalaring content types
  content_type = "text/html"
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

#Bucket_policy
resource "aws_s3_bucket_policy" "bucket_policy" {
  bucket = aws_s3_bucket.bucket_1.bucket
  #policy = data.aws_iam_policy_document.allow_access_from_another_account.json
  policy = jsonencode({
    "Version" = "2012-10-17",
    "Statement" = {
      "Sid" = "AllowCloudFrontServicePrincipalReadOnly",
      "Effect" = "Allow",
      "Principal" = {
        "Service" = "cloudfront.amazonaws.com"
      },
      "Action" = "s3:GetObject",
      "Resource" = "arn:aws:s3:::${aws_s3_bucket.bucket_1.id}/*",
      "Condition" = {
      "StringEquals" = {
          #"AWS:SourceArn": data.aws_caller_identity.current.arn
          "AWS:SourceArn" = "arn:aws:cloudfront::${data.aws_caller_identity.current.account_id}:distribution/${aws_cloudfront_distribution.s3_distribution.id}"
        }
      }
    }
  })
}
# For the  above policy we need a distribution and an account id. Account ID has been taken care of by 
# the data block as we are already familiar with aws sts get-caller-identity. 
# the distribution id will be taken from the cloud_front distribution block

# resource "terraform_data" "content_version" {
#   input = var.content_version
# }