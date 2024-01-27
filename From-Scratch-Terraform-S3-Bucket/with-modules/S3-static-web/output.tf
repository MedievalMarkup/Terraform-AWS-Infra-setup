output "s3_name" {
  description = "s3 bucket name"
  value       = aws_s3_bucket.testwebsite.name
}

output "s3_arn" {
  description = "s3 bucket arn"
  value       = aws_s3_bucket.testwebsite.arn
}

output "bucket_domain_name" {
  description = "bucket domain name"
  value       = aws_s3_bucket.testwebsite.bucket_domain_name
}

output "regional_domain_name" {
  description = "bucket regional name"
  value       = aws_s3_bucket.testwebsite.bucket_regional_domain_name
}

output "bucket_region" {
  description = "bucket region"
  value       = aws_s3_bucket.testwebsite.region 
}

output "static_web_url" {
  description = "static web url"
  value       = "http://${aws_s3_bucket.testwebsite.bucket}.s3-website.${aws_s3_bucket.testwebsite.region}.amazonaws.com"
}

