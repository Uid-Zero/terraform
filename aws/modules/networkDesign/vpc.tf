resource "aws_vpc" "main" {
  cidr_block       = var.vpcCidr
  enable_dns_support = true
  enable_dns_hostnames = true
  tags = merge(
    var.tags,
    {
      owner = var.ownerEmail,
      Name = "${var.environment}-${var.application}-vpc"
    }
  )
}