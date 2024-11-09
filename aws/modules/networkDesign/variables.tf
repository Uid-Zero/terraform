variable "vpcCidr" {
  description = "The CIDR block for the VPC"
  type        = string
  default     = "10.0.0.0/16"
}

variable "environment" {
  description = "Environment name (e.g., production, development)"
  type        = string
}

variable "application" {
  description = "Application name"
  type        = string
}

variable "availabilityZones" {
  description = "List of availability zones to be used"
  type        = list(string)
  default     = ["us-east-1a", "us-east-1b", "us-east-1c"]
}

variable "privateSubnetCidrs" {
  description = "CIDR blocks for private subnets"
  type        = list(string)
  default     = ["10.0.1.0/24", "10.0.2.0/24", "10.0.3.0/24"]
}

variable "ownerEmail" {
  description = "Email address of the owner for tagging purposes"
  type        = string
}

variable "tags" {
  description = "A map of tags to be assigned to resources"
  type        = map(string)
  default = {
    environment  = "prd"
    application  = "app"
    owner        = "var.ownerEmail"
  }
}