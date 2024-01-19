# SNS TOPIC
resource "aws_sns_topic" "asg_updates" {
  name = "asg-sns-topic-${random_pet.this.id}"
}

# SNS SUBSCRIPTION
resource "aws_sns_topic_subscription" "asg_sns_topic_subscription" {
  topic_arn = aws_sns_topic.asg_updates.arn
  protocol  = var.aws_sns_topic_subscription_protocol
  endpoint  = var.aws_sns_topic_subscription_endpoint
}

#AUTOSCALING NOTIFICATION

resource "aws_autoscaling_notification" "asg_notifications" {
  group_names   = [
    aws_autoscaling_group.first_autoscaling_group.name
  ]
  notifications = var.autoscaling_notifications
  topic_arn     = aws_sns_topic.asg_updates.arn
}
