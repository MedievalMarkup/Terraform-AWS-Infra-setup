module "ec2-private" {
  source  = "terraform-aws-modules/ec2-instance/aws"
  version = "5.6.0"

	#in_case multiple instance
	for_each               = toset(["0", "1"])
  name                   = "private-ec2-${each.key}"
  ami                    = data.aws_ami.amzlinux2.id
  instance_type          = var.instance_type
  key_name               = var.instance_keypair
  # monitoring             = true
  subnet_id              = element(module.vpc.private_subnets, tonumber(each.key))
  vpc_security_group_ids = [module.private_sg.security_group_id]
	user_data              = file("${path.module}/app1-install.sh") 
	tags                   = local.common_tags
	depends_on             = [ module.vpc ]
}
