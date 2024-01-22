resource "aws_autoscaling_policy" "high_cpu" {
  name                   = "high-cpu"
  scaling_adjustment     = 4
  adjustment_type        = "ChangeInCapacity"
  cooldown               = 300
  autoscaling_group_name = aws_autoscaling_group.first_autoscaling_group.name
}

#Cloud Watch alaram to trigger the aove scaling policy when CPU utilization is above 80%
#also send notification to the mails mentioned in SNS topic.

resource "aws_cloudwatch_metric_alarm" "alram_cpu_utilization" {
  alarm_name          = "APP1-ASG-CPU-UTILIZATION-ALARM"
  comparison_operator = "GreaterThanOrEqualToThreshold"
  evaluation_periods  = 2
  metric_name         = "CPUUtilization"
  namespace           = "AWS/EC2"
  period              = 120
  statistic           = "Average"
  threshold           = 80

  dimensions          = {
    AutoScalingGroupName = aws_autoscaling_group.first_autoscaling_group.name
  }

  alarm_description   = "This metric monitors ec2 cpu utilization"
  ok_actions          = [aws_sns_topic.asg_updates.arn]
  alarm_actions       = [
    aws_autoscaling_policy.high_cpu.arn,
    aws_sns_topic.asg_updates.arn
  ]
}