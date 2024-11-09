resource "aws_subnet" "private" {
  count = length(var.availabilityZones)

  vpc_id                  = aws_vpc.main.id
  cidr_block              = element(var.privateSubnetCidrs, count.index)
  availability_zone       = element(var.availabilityZones, count.index)
  map_public_ip_on_launch = false

  tags = merge(
    var.tags,
    {
      owner = var.ownerEmail,
      Name = "${var.environment}-${var.application}-subnet-${element(var.availabilityZones, count.index)}"
    }
  )
}