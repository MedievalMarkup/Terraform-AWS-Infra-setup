#S3 bucket
resource "aws_s3_bucket" "testwebsite" {
  bucket        = var.bucket_name
	tags          = var.tags
	force_destroy = true
}

#S3 bucket webiste configurations
resource "aws_s3_bucket_website_configuration" "testwebsite-configurations" {
  bucket = aws_s3_bucket.testwebsite.id

  index_document {
    suffix = "index.html"
  }

  error_document {
    key = "error.html"
  }

  # routing_rule {
  #   condition {
  #     key_prefix_equals = "docs/"
  #   }
  #   redirect {
  #     replace_key_prefix_with = "documents/"
  #   }
  # }
}

#versioning
resource "aws_s3_bucket_versioning" "versioning_testwebsite" {
  bucket = aws_s3_bucket.testwebsite.id
  versioning_configuration {
    status = "Enabled"
  }
}

#ownership
resource "aws_s3_bucket_ownership_controls" "ownership_testwebiste" {
  bucket = aws_s3_bucket.testwebsite.id

  rule {
    object_ownership = "BucketOwnerPreferred"
  }
}

#public access control
resource "aws_s3_bucket_public_access_block" "public_access_block_testwebsite" {
  bucket = aws_s3_bucket.testwebsite.id

  block_public_acls       = false
  block_public_policy     = false
  ignore_public_acls      = false
  restrict_public_buckets = false
}

#s3 acl
resource "aws_s3_bucket_acl" "testwebsite_acl" {
  depends_on = [
		aws_s3_bucket_ownership_controls.ownership_testwebiste,
		aws_s3_bucket_public_access_block.public_access_block_testwebsite
	]

  bucket = aws_s3_bucket.testwebsite.id
  acl    = "public-read"
}

#policy for s3 getting from data resource
resource "aws_s3_bucket_policy" "allow_access_from_another_account" {
  bucket = aws_s3_bucket.testwebsite.id
  policy = data.aws_iam_policy_document.allow_access_from_another_account.json
}

# datasource to get policy json
data "aws_iam_policy_document" "allow_access_from_web" {
  statement {

    principals {
			# https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document - NOTE 
      type        = "Federated"
      identifiers = ["*"]
    }

    actions = [
			"s3:*"
      # "s3:GetObject",
      # "s3:ListBucket",
    ]

    resources = [
      aws_s3_bucket.testwebsite.arn,
      "${aws_s3_bucket.testwebsite.arn}/*",
    ]
  }
}