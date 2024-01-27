variable "s3_aws_region" {
  description = "Region in which AWS Resources to be created"
  type = string
}

variable "s3_bucket_name" {
  description = "S3 Bucket Name"
  type = string 
}

variable "s3_tags" {
  description = "S3 Bucket Name"
  type = map(string)
}