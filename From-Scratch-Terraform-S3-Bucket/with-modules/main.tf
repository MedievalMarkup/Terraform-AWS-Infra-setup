module "s3_bucket_static_web" {
  source      = "./S3-static-web/main.tf"
  bucket_name = var.s3_bucket_name
  tags        = var.s3_tags
}