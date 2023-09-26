output "My_bucket_name" {
  value = aws_s3_bucket.bucket_1.bucket
}

output "website-endpoint" {
  description = "website_url"
  value = aws_s3_bucket_website_configuration.static_website.website_endpoint
}
# output "website_url" {
#   value = "http://${aws_s3_bucket.my-static-website.bucket}.s3-website.${var.region}.amazonaws.com"
# }