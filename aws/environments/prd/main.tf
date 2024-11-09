# Provider Configuration. 

provider "aws" {
  region = "us-east-1"
  alias  = "primary"
}

/*

# Reference S3 module with values passed dynamically from the AWS caller identity. 

module "awsConfig" {
  source = "git@github.com:Uid-Zero/terraform.git//aws/modules/awsConfig"
  accountID = data.aws_caller_identity.uidZero.account_id
}

*/

# Reference billingAlarm module. 

module "billingAlarm" {
  source = "git@github.com:Uid-Zero/terraform.git//aws/modules/billingAlarm"
  billingAlarmEmail = var.billingAlarmEmail
}