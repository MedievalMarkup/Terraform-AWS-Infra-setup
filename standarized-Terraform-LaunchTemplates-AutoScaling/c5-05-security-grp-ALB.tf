module "sg_loadbalancer" {
  source  = "terraform-aws-modules/security-group/aws"
  version = "5.1.0"

  name = "loadbalancer-sg"
  description = "security group with http port open for entire internet"

  vpc_id = module.vpc.vpc_id

  #Ingress & CIDR
  ingress_rules       = ["http-80-tcp"]
  ingress_cidr_blocks = ["0.0.0.0/0"]

	#Egress
  egress_rules = ["all-all"]

	tags = local.common_tags
}