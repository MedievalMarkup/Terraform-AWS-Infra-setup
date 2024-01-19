module "public_bastion_sg" {
  source  = "terraform-aws-modules/security-group/aws"
  version = "5.1.0"

  name = "public-bastion-sg"
  description = "security group with ssh port open"

  vpc_id = module.vpc.vpc_id

  #Ingress & CIDR
  ingress_rules       = ["ssh-tcp"]
  ingress_cidr_blocks = ["0.0.0.0/0"]
  
	#Egress
  egress_rules = ["all-all"]

	tags = local.common_tags
}