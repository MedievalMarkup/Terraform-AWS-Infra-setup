module "acm" {
  source  = "terraform-aws-modules/acm/aws"
  version = "5.0.0"

  #---this thing will be invalid for internal domain 'test.com.something' to make that work use 'trimsuffix(data.aws_route53_zone.mydomain.name, ".")'---#
  #---below will work for non internal domain 'test.com'

  # domain_name  = data.aws_route53_zone.mydomain.name
  domain_name  = trimsuffix(data.aws_route53_zone.mydomain.name, ".")
  zone_id      = data.aws_route53_zone.mydomain.zone_id

  validation_method = "DNS"

  subject_alternative_names = [
    "*.${data.aws_route53_zone.mydomain.name}",
  ]

  wait_for_validation = true

  tags = local.common_tags
}

output "acm_certificate_arn" {
  description = "The ARN of the certificate"
  value       = module.acm.acm_certificate_arn
}