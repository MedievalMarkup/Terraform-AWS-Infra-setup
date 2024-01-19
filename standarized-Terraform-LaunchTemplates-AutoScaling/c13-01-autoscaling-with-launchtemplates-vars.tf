variable "launch_template_name" {
  description = "name launch template"
  type = string
  default = "first_launch_template"
}

variable "ebs-optimized" {
  description = "enable ebs optimizations"
  type = bool
  default = true
}

variable "update-default-version" {
  description = "enable default version"
  type = bool
  default = true
}

variable "block-device-mapping-delete-on-termination" {
  description = "enable delete-on-termination"
  type = bool
  default = true
}

variable "block-device-mapping-device-name" {
  description = "device name"
  type = string
  default = "/dev/sda1"
}

variable "block-device-mapping-volume-size" {
  description = "device size"
  type = number
  default = 10
}

variable "block-device-mapping-volume-type" {
  description = "device type"
  type = string
  default = "gp2"
}

variable "monitoring-enable" {
  description = "enable monitoring"
  type = bool
  default = true
}

variable "asg_name_prifex" {
  description = "ASG name prefix"
  type = string
  default = "myasg-"
}

variable "asg_desired_capacity" {
  description = "asg desired capacity"
  type = number
  default = 2
}

variable "asg_max_size" {
  description = "asg max size"
  type = number
  default = 5
}

variable "asg_min_size" {
  description = "asg min size"
  type = number
  default = 2
}

variable "asg_health_check_type" {
  description = "ASG health check type"
  type = string
  default = "EC2"
}

variable "asg_health_check_grace_period" {
  description = "asg health check grace period"
  type = number
  default = 300
}

variable "asg_instance_refresh_strategy" {
  description = "ASG instance refresh strategy"
  type = string
  default = "Rolling"
}

variable "asg_instance_refresh_warmup" {
  description = "asg instance refresh warmup"
  type = number
  default = 300
}

variable "asg_instance_refresh_min_health_percent" {
  description = "asg min health percen"
  type = number
  default = 50
}

variable "autoscaling_notifications" {
  description = "notifications for autoscaling"
  type        = list(string)
  default = [
    "autoscaling:EC2_INSTANCE_LAUNCH",
    "autoscaling:EC2_INSTANCE_TERMINATE",
    "autoscaling:EC2_INSTANCE_LAUNCH_ERROR",
    "autoscaling:EC2_INSTANCE_TERMINATE_ERROR",
  ]
}

variable "aws_sns_topic_subscription_protocol" {
  description = "aws_sns_topic_subscription_protocol"
  type = string
  default = "email"
}

variable "aws_sns_topic_subscription_endpoint" {
  description = "aws_sns_topic_subscription_endpoint"
  type = string
  default = "adilnehal80@gmail.com"
}

variable "autoscaling_policy_name" {
  description = "autoscaling_policy_name"
  type = string
  default = "avg-cpu-policy-greater-than-xx"
}

variable "autoscaling_policy_name_alb" {
  description = "autoscaling_policy_name"
  type = string
  default = "alb-target-requests-greater-than-yy"
}

variable "autoscaling_policy_type" {
  description = "autoscaling_policy_type"
  type = string
  default = "TargetTrackingScaling" 
}

variable "autoscaling_policy_estimated_instance_warmup" {
  description = "autoscaling_policy_estimated_instance_warmup"
  type = number
  default = 180 
}

variable "autoscaling_policy_predefined_metric_type_cpu" {
  description = "autoscaling_policy_predefined_metric_type"
  type = string
  default = "ASGAverageCPUUtilization"
}

variable "autoscaling_policy_predefined_metric_type_alb" {
  description = "autoscaling_policy_predefined_metric_type"
  type = string
  default = "ALBRequestCountPerTarget"
}