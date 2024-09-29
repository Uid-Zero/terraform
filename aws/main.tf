# Provider Configuration. 

provider "aws" {
  region = "us-east-1"
  alias  = "primary"
}

# Reference S3 module with values passed dynamically from the AWS caller identity. 

module "s3" {
  source = "./modules/s3"
  accountID = data.aws_caller_identity.uidZero.account_id
}

