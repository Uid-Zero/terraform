# Create IAM password policy to enforce account security rules

resource "aws_iam_account_password_policy" "passwordPolicy" {
  minimum_password_length        = 14
  require_uppercase_characters   = true
  require_lowercase_characters   = true
  require_numbers                = true
  require_symbols                = true
  allow_users_to_change_password = true
  max_password_age               = 60
  password_reuse_prevention      = 10
  hard_expiry                    = true
}

# Create CloudTrail to log account activity

resource "aws_cloudtrail" "accountTrail" {
  name                         = "account-activity-trail"
  s3_bucket_name               = aws_s3_bucket.cloudTrialBucket.bucket
  include_global_service_events = true
  is_multi_region_trail        = true
  enable_log_file_validation   = true
}

# Set up Config Rules to monitor compliance

resource "aws_config_config_rule" "s3BucketVersioning" {
  name   = "s3-bucket-versioning-enabled"
  source {
    owner            = "AWS"
    source_identifier= "S3_BUCKET_VERSIONING_ENABLED"
  }
}

resource "aws_config_config_rule" "iamUserMfa" {
  name   = "iam-user-mfa-enabled"
  source {
    owner            = "AWS"
    source_identifier = "IAM_USER_MFA_ENABLED"
  }
}