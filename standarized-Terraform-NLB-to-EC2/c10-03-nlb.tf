module "nlb" {
  source = "terraform-aws-modules/alb/aws"
  version = "9.4.1"

  name                       = "my-nlb"
  load_balancer_type         = "network"
  vpc_id                     = module.vpc.vpc_id
  subnets                    = module.vpc.public_subnets
  enable_deletion_protection = false  
  # Security Group
  security_groups            = [module.sg_loadbalancer.security_group_id]
  # security_group_ingress_rules = {
  #   all_http = {
  #     from_port   = 80
  #     to_port     = 82
  #     ip_protocol = "tcp"
  #     description = "HTTP web traffic"
  #     cidr_ipv4   = "0.0.0.0/0"
  #   }
  #   all_https = {
  #     from_port   = 443
  #     to_port     = 445
  #     ip_protocol = "tcp"
  #     description = "HTTPS web traffic"
  #     cidr_ipv4   = "0.0.0.0/0"
  #   }
  # }
  # security_group_egress_rules = {
  #   all = {
  #     ip_protocol = "-1"
  #     cidr_ipv4   = "10.0.0.0/16"
  #   }
  # }

  # access_logs = {
  #   bucket = "my-nlb-logs"
  # }

  listeners = {
    ex-tcp-udp = {
      port     = 81
      protocol = "TCP_UDP"
      forward = {
        target_group_key = "mytg1"
      }
    }

    ex-udp = {
      port     = 82
      protocol = "UDP"
      forward = {
        target_group_key = "mytg1"
      }
    }

    ex-tcp = {
      port     = 83
      protocol = "TCP"
      forward = {
        target_group_key = "mytg1"
      }
    }

    ex-tls = {
      port            = 84
      protocol        = "TLS"
      certificate_arn = module.acm.acm_certificate_arn
      forward = {
        target_group_key = "mytg1"
      }
    }
  }

  target_groups = {
    ex-target = {
      name_prefix = "mytg1"
      protocol    = "TCP"
      port        = 80
      target_type = "ip"
    }
  }

  tags = {
    Environment = "Development"
    Project     = "Example"
  }
}