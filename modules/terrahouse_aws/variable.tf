variable "UUID" {
  type        = string
  description = "The exam pro id."
}

variable "bucket_name" {
  type        = string
  description = "Our S3 bucket name."
}

variable "content_version" {
  description = "The content version. Should be a positive integer starting at 1."
  type        = number

  validation {
    condition     = var.content_version > 0 && floor(var.content_version) == var.content_version
    error_message = "The content_version must be a positive integer starting at 1."
  }
}