data "aws_route53_zone" "mydomain" {
  name         = "test.com"
#   private_zone = true
}

output "mydomain_zone_id" {
  description = "get the hosted zone id"
  value = data.aws_route53_zone.mydomain.zone_id
}

output "mydomain_zone_name" {
  description = "get the hosted zone name"
  value = data.aws_route53_zone.mydomain.name
}