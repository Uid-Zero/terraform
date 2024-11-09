resource "aws_eip" "nat" {
  count = 1
  domain   = "vpc"
  tags = merge(
    var.tags,
    {
      owner = var.ownerEmail,
      Name = "${var.environment}-nat-eip"
    }
  )
}

resource "aws_nat_gateway" "nat" {
  allocation_id = aws_eip.nat[0].id
  subnet_id     = aws_subnet.private[0].id
  depends_on    = [aws_internet_gateway.igw]

  tags = merge(
    var.tags,
    {
      owner = var.ownerEmail,
      Name = "${var.environment}-nat-${element(var.availabilityZones, 0)}"
    }
  )
}