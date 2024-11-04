# Create an SNS topic for billing alarm notifications

resource "aws_sns_topic" "billingAlarmTopic" {
  name = "billingAlarmTopic"
}

# Create an SNS topic subscription (e.g., Email notification)
resource "aws_sns_topic_subscription" "billingAlarmEmail" {
  topic_arn = aws_sns_topic.billingAlarmTopic.arn
  protocol  = "email"
  endpoint  = var.billingAlarmEmail # Email address will be provided as a variable
}

# Create a CloudWatch metric alarm for AWS billing
resource "aws_cloudwatch_metric_alarm" "billingAlarm" {
  alarm_name          = "awsBillingAlarm"
  comparison_operator = "GreaterThanThreshold"
  evaluation_periods  = 1
  metric_name         = "EstimatedCharges"
  namespace           = "AWS/Billing"
  period              = 21600 # 6 hours
  statistic           = "Maximum"
  threshold           = 20.0 # $$$$
  actions_enabled     = true
  alarm_actions       = [aws_sns_topic.billingAlarmTopic.arn]

  dimensions = {
    Currency = "USD"
  }

  depends_on = [
    aws_sns_topic_subscription.billingAlarmEmail
  ]
}