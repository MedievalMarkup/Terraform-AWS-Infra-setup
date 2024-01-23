resource "aws_cloudwatch_log_group" "log_group_for_cis_alarm" {
  name = "cis-log-group"
}

module "cloudwatch_example_cis-alarms" {
  source  = "terraform-aws-modules/cloudwatch/aws//examples/cis-alarms"
  version = "5.1.0"

  disabled_controls = ["DisableOrDeleteCMK", "VPCChanges"]
  create  = false
  log_group_name = aws_cloudwatch_log_group.log_group_for_cis_alarm.name
  alarm_actions  = [aws_sns_topic.asg_updates.arn]
}