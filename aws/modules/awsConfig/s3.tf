# Bucket to store AWS Config data [configBucket]

# This bucket will store AWS Config logs, configuration history, compliance reports,
# and configuration snapshots. The bucket name is dynamically generated using the account ID.
resource "aws_s3_bucket" "configBucket" {
    bucket = lower("awsConfigBucket-${var.accountID}")
    force_destroy = true
    tags = {
        Name        = "AWS Config Bucket"
        Description = "Bucket for AWS Config logs and resources."
    }
}
resource "aws_s3_bucket_versioning" "configBucketVersioning" {
  bucket = aws_s3_bucket.configBucket.id
  versioning_configuration {
    status = "Enabled"
  }
}
resource "aws_s3_bucket_public_access_block" "configBucketPublicAccess" {
  bucket = aws_s3_bucket.configBucket.id
  block_public_acls   = true
  block_public_policy = true
  ignore_public_acls  = true
  restrict_public_buckets = true
}
resource "aws_s3_bucket_lifecycle_configuration" "configBucketLifecycle" {
  bucket = aws_s3_bucket.configBucket.id
  rule {
    id     = "Move old versions to Glacier"
    status = "Enabled"
    noncurrent_version_transition {
      storage_class = "GLACIER"
      noncurrent_days = 15
    }
    noncurrent_version_expiration {
      noncurrent_days = 180
    }
  }
}
resource "aws_s3_bucket_policy" "configBucketPolicy" {
  bucket = aws_s3_bucket.configBucket.id
  policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Action = [
          "s3:PutObject",
          "s3:GetObject"
        ],
        Effect = "Allow",
        Resource = "${aws_s3_bucket.configBucket.arn}/*",
        Principal = {
          Service = "config.amazonaws.com"
        }
      },
      {
        Action = [
          "s3:GetBucketAcl",
          "s3:ListBucket"
        ],
        Effect = "Allow",
        Resource = "${aws_s3_bucket.configBucket.arn}",
        Principal = {
          Service = "config.amazonaws.com"
        }        
      }
    ]
  })
}