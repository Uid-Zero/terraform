output "vpcId" {
  description = "The ID of the VPC"
  value       = aws_vpc.main.id
}

output "privateSubnetIds" {
  description = "The IDs of the private subnets"
  value       = aws_subnet.private[*].id
}

output "natGatewayId" {
  description = "The ID of the NAT Gateway"
  value       = aws_nat_gateway.nat.id
}