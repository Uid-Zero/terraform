# Output the SNS topic ARN for reference
output "sns_topic_arn" {
  value = aws_sns_topic.billingAlarmTopic.arn
}