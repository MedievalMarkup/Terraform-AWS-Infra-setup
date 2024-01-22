resource "aws_route53_record" "apps_dns" {
  zone_id = data.aws_route53_zone.mydomain.zone_id
  name    = "asg-lt1.test.com"
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