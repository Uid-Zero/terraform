resource "aws_security_group" "eks" {
  vpc_id = aws_vpc.main.id

  tags = merge(
    var.tags,
    {
      owner = var.ownerEmail,
      Name = "${var.environment}-${var.application}-sg-eks"
    }
  )
}

# Add EKS specific rules based on AWS best practices
resource "aws_security_group_rule" "eksInbound" {
  type              = "ingress"
  from_port         = 443
  to_port           = 443
  protocol          = "tcp"
  security_group_id = aws_security_group.eks.id
  cidr_blocks       = ["0.0.0.0/0"]
}

resource "aws_security_group_rule" "eksOutbound" {
  type              = "egress"
  from_port         = 0
  to_port           = 0
  protocol          = "-1"
  security_group_id = aws_security_group.eks.id
  cidr_blocks       = ["0.0.0.0/0"]
}