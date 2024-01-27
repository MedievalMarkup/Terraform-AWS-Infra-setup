output "s3_name" {
  description = "s3 bucket name"
  value       = module.s3_bucket_static_web.s3_name
}

output "s3_arn" {
  description = "s3 bucket arn"
  value       = module.s3_bucket_static_web.s3_arn
}

output "bucket_domain_name" {
  description = "bucket domain name"
  value       = module.s3_bucket_static_web.bucket_domain_name
}

output "regional_domain_name" {
  description = "bucket regional name"
  value       = module.s3_bucket_static_web.bucket_regional_domain_name
}

output "bucket_region" {
  description = "bucket region"
  value       = module.s3_bucket_static_web.bucket_region 
}

output "static_web_url" {
  description = "static web url"
  value       = module.s3_bucket_static_web.static_web_url
}

