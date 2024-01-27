variable "aws_region" {
  description = "Region in which AWS Resources to be created"
  type = string
}

variable "bucket_name" {
  description = "S3 Bucket Name"
  type = string 
}

variable "tags" {
  description = "S3 Bucket Name"
  type = map(string)
}