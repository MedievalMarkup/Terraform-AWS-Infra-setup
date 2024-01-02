module "private_sg" {
  source  = "terraform-aws-modules/security-group/aws"
  version = "5.1.0"

  name = "private-sg"
  description = "security group with http & ssh port open for entire vpc block"

  vpc_id = module.vpc.vpc_id

  #Ingress & CIDR
  ingress_rules       = ["ssh-tcp", "http-80-tcp"]
  ingress_cidr_blocks = [module.vpc.vpc_cidr_block]

	#Egress
  egress_rules = ["all-all"]

	tags = local.common_tags
}