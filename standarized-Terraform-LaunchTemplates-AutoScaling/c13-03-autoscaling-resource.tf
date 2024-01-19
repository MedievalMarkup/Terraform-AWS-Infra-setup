resource "aws_autoscaling_group" "first_autoscaling_group" {
  name_prefix               = var.asg_name_prifex
  desired_capacity          = var.asg_desired_capacity
  max_size                  = var.asg_max_size
  min_size                  = var.asg_min_size
  vpc_zone_identifier       = module.vpc.private_subnets
  target_group_arns         = [module.alb.target_groups["albtg1"].arn]
  health_check_type         = var.asg_health_check_type
  health_check_grace_period = var.asg_health_check_grace_period
  launch_template {
    id      = aws_launch_template.first_launch_template.id
    version = aws_launch_template.first_launch_template.latest_version
  }

  instance_refresh {
    strategy = var.asg_instance_refresh_strategy
    preferences {
      instance_warmup        = var.asg_instance_refresh_warmup
      min_healthy_percentage = var.asg_instance_refresh_min_health_percent
    }
    triggers = ["desired_capacity"] # any args from autoscaling group
  }
}