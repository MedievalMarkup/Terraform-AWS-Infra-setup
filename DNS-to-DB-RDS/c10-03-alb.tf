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
    my-http-https-redirect = {
      port     = 80
      protocol = "HTTP"
      redirect = {
        port        = "443"
        protocol    = "HTTPS"
        status_code = "HTTP_301"
      }
    }
    my-https-listener = {
      port            = 443
      protocol        = "HTTPS"
      ssl_policy      = "ELBSecurityPolicy-TLS13-1-2-Res-2021-06"
      certificate_arn = module.acm.acm_certificate_arn

      forward = {
        target_group_key = "alb2tg"
      }


      rules = {
        fixed-response = {
          priority = 3
          actions = [{
            type         = "fixed-response"
            content_type = "text/plain"
            status_code  = 200
            message_body = "This is a fixed response"
          }]
        }

        myapp1-rule = {
          priority = 10
          actions = [{
            type = "weighted-forward"
            target_groups = [
              {
                target_group_key = "alb1tg"
                weight           = 1
              }
            ]
            stickiness = {
              enabled  = true
              duration = 3600
            }
          }]
          conditions = [{
            # ------------ context path based routing --------- #
            # path_pattern = {
            #   values = ["/app2*"]
            # }
            # ------------ host header based routing --------- #
            # host_header = {
            #   values = [var.app2_dns_name]
            # }
            host_header = {
              http_header_name = "custom-header"
              values = ["app-1", "app1", "my-app-1"]
            }
          }]
        }# End of myapp1-rule

        # Rule-2: myapp2-rule
        myapp2-rule = {
          priority = 20
          actions = [{
            type = "weighted-forward"
            target_groups = [
              {
                target_group_key = "alb2tg"
                weight           = 1
              }
            ]
            stickiness = {
              enabled  = true
              duration = 3600
            }
          }]
          conditions = [{
            # ------------ context path based routing --------- #
            # path_pattern = {
            #   values = ["/app2*"]
            # }
            # ------------ host header based routing ---------- #
            # host_header = {
            #   values = [var.app2_dns_name]
            # }
            host_header = {
              http_header_name = "custom-header"
              values = ["app-2", "app2", "my-app-2"]
            }
          }]
        }# End of myapp2-rule Block

        myapp3-rule = {
          priority = 30
          actions = [{
            type = "weighted-forward"
            target_groups = [
              {
                target_group_key = "alb3tg"
                weight           = 1
              }
            ]
            stickiness = {
              enabled  = true
              duration = 3600
            }
          }]
          conditions = [{
            # ------------ context path based routing --------- #
            path_pattern = {
              values = ["/*"]
            }
            # ------------ host header based routing ---------- #
            # host_header = {
            #   values = [var.app2_dns_name]
            # }
            # host_header = {
            #   http_header_name = "custom-header"
            #   values = ["app-2", "app2", "my-app-2"]
            # }
          }]
        }

        # ----------- Query String Redirect Rule ----------- #
        my-query-redirect = {
          priority = 3
          actions = [{
            type        = "redirect"
            status_code = "HTTP_302"
            host        = "test.com"
            path        = "/aws-eks/"
            query       = ""
            protocol    = "HTTPS"
          }]

          conditions = [{
            query_string = {
              key = "website"
              value = "aws_eks"
            }
          }]
        }# End Rules Block

      }
    my-http-listener = {
      port            = 80
      protocol        = "HTTP"

      forward = {
        target_group_key = "alb1tg"
      }
    }
  }

  target_groups = {
    alb1tg = {
      # https://github.com/terraform-aws-modules/terraform-aws-alb/issues/316 
      create_attachment                 = false
      name_prefix                       = "alb1tg"
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

    alb2tg = {
      # https://github.com/terraform-aws-modules/terraform-aws-alb/issues/316 
      create_attachment                 = false
      name_prefix                       = "alb2tg"
      protocol                          = "HTTP"
      port                              = 80
      target_type                       = "instance"
      deregistration_delay              = 10
      load_balancing_cross_zone_enabled = false

      health_check = {
        enabled             = true
        interval            = 30
        path                = "/app2/index.html"
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

    alb3tg = {
      # https://github.com/terraform-aws-modules/terraform-aws-alb/issues/316 
      create_attachment                 = false
      name_prefix                       = "alb3tg"
      protocol                          = "HTTP"
      port                              = 8080
      target_type                       = "instance"
      deregistration_delay              = 10
      load_balancing_cross_zone_enabled = false

      health_check = {
        enabled             = true
        interval            = 30
        path                = "/login"
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

  }
} 



resource "aws_lb_target_group_attachment" "alb1tg" {
  # k -> ec2 instance
  # v -> ec2 instance details
  for_each         = {
    for k, v in module.ec2-private-app1: k => v
  }
  target_group_arn = module.alb.target_groups["alb1tg"].arn
  target_id        = each.value.id
  port             = 80
}

resource "aws_lb_target_group_attachment" "alb2tg" {
  # k -> ec2 instance
  # v -> ec2 instance details
  for_each         = {
    for k, v in module.ec2-private-app2: k => v
  }
  target_group_arn = module.alb.target_groups["alb2tg"].arn
  target_id        = each.value.id
  port             = 80
}

resource "aws_lb_target_group_attachment" "alb3tg" {
  # k -> ec2 instance
  # v -> ec2 instance details
  for_each         = {
    for k, v in module.ec2-private-app2: k => v
  }
  target_group_arn = module.alb.target_groups["alb3tg"].arn
  target_id        = each.value.id
  port             = 8080
}