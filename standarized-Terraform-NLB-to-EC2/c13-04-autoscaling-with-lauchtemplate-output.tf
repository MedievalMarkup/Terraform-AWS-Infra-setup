# launch template id
output "launch_template_id" {
  description = "launch template id"
  value       = aws_launch_template.first_launch_template.id
}

# launch template version

output "launch_template_version" {
  description = "launch template id"
  value       = aws_launch_template.first_launch_template.latest_version
}

# autoscaling group id

output "autoscaling_group_id" {
  description = "auto scaling group id"
  value       = aws_autoscaling_group.first_autoscaling_group.id
}

# autoscaling group name

output "autoscaling_group_name" {
  description = "auto scaling group name"
  value       = aws_autoscaling_group.first_autoscaling_group.name
}

# autoscaling group arn

output "autoscaling_group_arn" {
  description = "auto scaling group arn"
  value       = aws_autoscaling_group.first_autoscaling_group.arn
}