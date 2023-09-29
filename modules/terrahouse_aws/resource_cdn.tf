#https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/cloudfront_origin_access_control

resource "aws_cloudfront_origin_access_control" "default" {
  name                              = "OAC ${var.bucket_name}"
  description                       = "Origin access control for ${var.bucket_name}"
  origin_access_control_origin_type = "s3"
  signing_behavior                  = "always"
  signing_protocol                  = "sigv4"
}

#https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/cloudfront_distribution
locals {
  s3_origin_id = "myS3Origin"
}
resource "aws_cloudfront_distribution" "s3_distribution" {
  origin {
    domain_name              = aws_s3_bucket.bucket_1.bucket_regional_domain_name
    origin_access_control_id = aws_cloudfront_origin_access_control.default.id
    origin_id                = local.s3_origin_id
  }

  enabled             = true
  is_ipv6_enabled     = true
  comment             = "Static website hosting for ${var.bucket_name}"
  default_root_object = "index.html"

  #aliases = ["mysite.example.com", "yoursite.example.com"]

  default_cache_behavior {
    allowed_methods  = ["DELETE", "GET", "HEAD", "OPTIONS", "PATCH", "POST", "PUT"]
    cached_methods   = ["GET", "HEAD"]
    target_origin_id = local.s3_origin_id

    forwarded_values {
      query_string = false

      cookies {
        forward = "none"
      }
    }

    viewer_protocol_policy = "allow-all"
    min_ttl                = 0
    default_ttl            = 3600
    max_ttl                = 86400
  }
  price_class = "PriceClass_200"

  restrictions {
    geo_restriction {
      restriction_type = "none"
      locations        = []
    }
  }

  tags = {
    User_uid = var.UUID
  }

  viewer_certificate {
    cloudfront_default_certificate = true
  }
}

#AWS_S3_CDN
#https://aws.amazon.com/blogs/networking-and-content-delivery/amazon-cloudfront-introduces-origin-access-control-oac/