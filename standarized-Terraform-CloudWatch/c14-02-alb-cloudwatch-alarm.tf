resource "aws_cloudwatch_metric_alarm" "alb_4xx_errors" {
  alarm_name          = "APP1-ALB-CPU-HTTP-4xx-ALARM"
  comparison_operator = "GreaterThanOrEqualToThreshold"
  evaluation_periods  = 3
  datapoints_to_alarm = 2
  metric_name         = "HTTPCODE_Target_4XX_Count"
  namespace           = "AWS/ApplicationELB"
  period              = 120
  statistic           = "Sum"
  threshold           = 5
	treat_missing_data  = "missing" 
  dimensions          = {
    LoadBalancer      = module.alb.arn_suffix
  }

  alarm_description   = "This metric monitors ALB HTTP 4xx errors & if they are above 100"
  ok_actions          = [aws_sns_topic.asg_updates.arn]
  alarm_actions       = [
    aws_sns_topic.asg_updates.arn
  ]
}