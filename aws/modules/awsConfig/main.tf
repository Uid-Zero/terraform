# AWS Config delivery channel for compliance reports

resource "aws_config_configuration_recorder" "defaultConfig" {
  name     = "defaultConfig"
  role_arn = aws_iam_role.configRole.arn
  recording_group {
    all_supported = true
    include_global_resource_types = true
  }
  recording_mode {
    recording_frequency = "DAILY"
  }
}

# Enable AWS Config to deliver logs to the bucket
resource "aws_config_delivery_channel" "main" {
  name           = "default"
  s3_bucket_name = aws_s3_bucket.configBucket.bucket

  depends_on = [aws_config_configuration_recorder.defaultConfig]
}

# IAM Role for AWS Config
resource "aws_iam_role" "configRole" {
  name = "awsConfigRole"

  assume_role_policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Action = "sts:AssumeRole",
        Effect = "Allow",
        Principal = {
          Service = "config.amazonaws.com"
        }
      }
    ]
  })
}

# Attach necessary policies to the role
resource "aws_iam_role_policy_attachment" "config_role_policy" {
  role       = aws_iam_role.configRole.name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AWS_ConfigRole"
}
