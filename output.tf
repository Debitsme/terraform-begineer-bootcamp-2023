output "My_bucket_name" {
  description = "for getting outputs from inside the modules"
  value       = module.terrahouse.My_bucket_name
}

output "S3_website-endpoint" {
  description = "s3_endpoint"
  value       = module.terrahouse.website-endpoint
}

output "cloud_front_distribution" {
  description = "link for the cloud_front distributioin"
  value       = module.terrahouse.cloud_front_distribution
}