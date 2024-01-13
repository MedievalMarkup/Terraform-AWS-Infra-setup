resource "aws_route53_record" "default_apps_dns" {
  zone_id = data.aws_route53_zone.mydomain.zone_id
  name    = "apps.test.com"
  type    = "A"
#---ttl for non alias records---#
#   ttl     = 300
#   records = [aws_eip.lb.public_ip]
  alias {
    name                   = module.alb.dns_name
    zone_id                = module.alb.zone_id
    evaluate_target_health = true
  }
}

resource "aws_route53_record" "apps1_dns" {
  zone_id = data.aws_route53_zone.mydomain.zone_id
  name    = var.app1_dns_name
  type    = "A"
#---ttl for non alias records---#
#   ttl     = 300
#   records = [aws_eip.lb.public_ip]
  alias {
    name                   = module.alb.dns_name
    zone_id                = module.alb.zone_id
    evaluate_target_health = true
  }
}

resource "aws_route53_record" "apps2_dns" {
  zone_id = data.aws_route53_zone.mydomain.zone_id
  name    = var.app2_dns_name
  type    = "A"
#---ttl for non alias records---#
#   ttl     = 300
#   records = [aws_eip.lb.public_ip]
  alias {
    name                   = module.alb.dns_name
    zone_id                = module.alb.zone_id
    evaluate_target_health = true
  }
}