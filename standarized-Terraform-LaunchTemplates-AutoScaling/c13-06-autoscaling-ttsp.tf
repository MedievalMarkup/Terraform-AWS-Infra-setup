#TTS policy - based on CPU utilization
resource "aws_autoscaling_policy" "avg_cpu_policy_greater_than_xx" {
  name                      = var.autoscaling_policy_name
  policy_type               = var.autoscaling_policy_type
  autoscaling_group_name    = aws_autoscaling_group.first_autoscaling_group.name
  estimated_instance_warmup = var.autoscaling_policy_estimated_instance_warmup
  target_tracking_configuration {
    predefined_metric_specification {
      predefined_metric_type = var.autoscaling_policy_predefined_metric_type_cpu
    }

    target_value = 50.0
  }
}

#TTS policy - based on ALB Target Requests
resource "aws_autoscaling_policy" "alb_target_requests_greater_than_yy" {
  name                      = var.autoscaling_policy_name_alb
  policy_type               = var.autoscaling_policy_type
  autoscaling_group_name    = aws_autoscaling_group.first_autoscaling_group.name
  estimated_instance_warmup = var.autoscaling_policy_estimated_instance_warmup
  target_tracking_configuration {
    predefined_metric_specification {
      predefined_metric_type = var.autoscaling_policy_predefined_metric_type_alb
      resource_label         = "${module.alb.arn_suffix}/${module.alb.target_groups["alb1tg"].arn}" 
    }

    target_value = 10.0
  }
}