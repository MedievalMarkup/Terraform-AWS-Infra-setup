module "ec2-private-app3" {
  source  = "terraform-aws-modules/ec2-instance/aws"
  version = "5.6.0"

	#in_case multiple instance
  for_each               = toset(["0", "1"])
  name                   = "private-ec2-rds-${each.key}-app3"
  ami                    = data.aws_ami.amzlinux2.id
  instance_type          = var.instance_type
  key_name               = var.instance_keypair
  # monitoring             = true
  subnet_id              = element(module.vpc.database_subnets, tonumber(each.key))
  vpc_security_group_ids = [module.sg_rds.security_group_id]
	user_data              = templatefile("app3-ums-install.tmpl", {rds_db_endpoint = module.rds_db.db_instance_address}) 
	tags                   = local.common_tags
	depends_on             = [ module.vpc ]
}
