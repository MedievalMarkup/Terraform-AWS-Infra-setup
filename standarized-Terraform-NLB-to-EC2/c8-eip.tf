resource "aws_eip" "bastion-eip" {
  instance = module.ec2-public.id
  domain   = "vpc"
  tags     = local.common_tags
  depends_on = [ 
    module.vpc,
		module.ec2-public
  ]
}