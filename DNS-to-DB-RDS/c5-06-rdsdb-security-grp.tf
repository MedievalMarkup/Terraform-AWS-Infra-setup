module "sg_rds" {
  source  = "terraform-aws-modules/security-group/aws"
  version = "5.1.0"

  name = "rds-sg"
  description = "security group with http port open for entire internet"

  vpc_id = module.vpc.vpc_id

  # Open to CIDRs blocks (rule or from_port+to_port+protocol+description) - above way also work, and this also. 
  ingress_with_cidr_blocks = [
    {
      from_port   = 3306
      to_port     = 3306
      protocol    = "tcp"
      description = "MSSQL Access from within VPC"
      cidr_blocks = "0.0.0.0/0"
    }
  ]

	#Egress
  egress_rules = ["all-all"]

	tags = local.common_tags
}