resource "aws_launch_template" "first_launch_template" {
  name                   = var.launch_template_name
  image_id               = data.aws_ami.amzlinux2
  instance_type          = var.instance_type
  vpc_security_group_ids = [module.private_sg.security_group_id]
  key_name               = var.instance_keypair
  user_data              = filebase64("${path.module}/app1-install.sh")
  ebs_optimized          = var.ebs-optimized
  # default_version        = 1
  update_default_version = var.update-default-version
  block_device_mappings {
    device_name = var.block-device-mapping-device-name
    ebs {
      volume_size           = var.block-device-mapping-volume-size
      delete_on_termination = var.block-device-mapping-delete-on-termination
      volume_type           = var.block-device-mapping-volume-type
    }
  }

  monitoring {
    enabled = var.monitoring-enable
  }
}