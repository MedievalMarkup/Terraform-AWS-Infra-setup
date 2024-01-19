module "alb" {

  source  = "terraform-aws-modules/alb/aws"
  version = "9.4.0"

  name    = "${local.name}-alb"
  vpc_id  = module.vpc.vpc_id
  subnets = module.vpc.public_subnets
  load_balancer_type = "application"
  security_groups = [module.sg_loadbalancer.security_group_id]

  # Security Group
  # security_group_ingress_rules = {
  #   all_http = {
  #     from_port   = 80
  #     to_port     = 80
  #     ip_protocol = "tcp"
  #     description = "HTTP web traffic"
  #     cidr_ipv4   = "0.0.0.0/0"
  #   }
  #   all_https = {
  #     from_port   = 443
  #     to_port     = 443
  #     ip_protocol = "tcp"
  #     description = "HTTPS web traffic"
  #     cidr_ipv4   = "0.0.0.0/0"
  #   }
  # }
  # security_group_egress_rules = {
  #   all = {
  #     ip_protocol = "-1"
  #     cidr_ipv4   = "0.0.0.0/0"
  #   }
  # }

  # access_logs = {
  #   bucket = "my-alb-logs"
  # }

  listeners = {
    # ex-http-https-redirect = {
    #   port     = 80
    #   protocol = "HTTP"
    #   redirect = {
    #     port        = "443"
    #     protocol    = "HTTPS"
    #     status_code = "HTTP_301"
    #   }
    # }
    my-http-listener = {
      # port            = 443
      # protocol        = "HTTPS"
      # certificate_arn = "arn:aws:iam::123456789012:server-certificate/test_cert-123456789012"

      port            = 80
      protocol        = "HTTP"

      forward = {
        target_group_key = "alb-tg-1"
      }
    }
  }

  target_groups = {
    albtg1 = {
      # https://github.com/terraform-aws-modules/terraform-aws-alb/issues/316 
      create_attachment                 = false
      name_prefix                       = "albtg1"
      protocol                          = "HTTP"
      port                              = 80
      target_type                       = "instance"
      deregistration_delay              = 10
      load_balancing_cross_zone_enabled = false

      health_check = {
        enabled             = true
        interval            = 30
        path                = "/app1/index.html"
        port                = "traffic-port"
        healthy_threshold   = 3
        unhealthy_threshold = 3
        timeout             = 6
        protocol            = "HTTP"
        matcher             = "200-399"
      }

      protocol_version = "HTTP1"
      # target_id        = aws_instance.this.id
      # port             = 80
      tags = local.common_tags
    }
  }

  tags = local.common_tags
}

resource "aws_lb_target_group_attachment" "albtg1" {
  # k -> ec2 instance
  # v -> ec2 instance details
  for_each         = {
    for k, v in module.ec2-private: k => v
  }
  target_group_arn = module.alb.target_groups["albtg1"].arn
  target_id        = each.value.id
  port             = 80
}