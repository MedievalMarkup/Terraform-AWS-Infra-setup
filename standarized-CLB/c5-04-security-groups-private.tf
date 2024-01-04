module "private_sg" {
  source  = "terraform-aws-modules/security-group/aws"
  version = "5.1.0"

  name = "private-sg"
  description = "security group with http & ssh port open for entire vpc block"

  vpc_id = module.vpc.vpc_id

  #Ingress & CIDR
  ingress_rules       = ["ssh-tcp", "http-80-tcp"]
  ingress_cidr_blocks = [module.vpc.vpc_cidr_block]

  # Open to CIDRs blocks (rule or from_port+to_port+protocol+description) - above way also work, and this also. 
  ingress_with_cidr_blocks = [
    {
      from_port   = 81
      to_port     = 81
      protocol    = 6
      description = "Allow port 81 from internet"
      cidr_blocks = "0.0.0.0/0"
    }
  ]

	#Egress
  egress_rules = ["all-all"]

	tags = local.common_tags
}