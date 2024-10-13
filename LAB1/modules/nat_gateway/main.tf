resource "aws_eip" "nat_eip" {
  tags = { Name = "NAT EIP" }
}

resource "aws_nat_gateway" "nat_gw" {
  allocation_id = aws_eip.nat_eip.id
  subnet_id     = var.public_subnet_id
  depends_on    = [var.internet_gateway_id]
  tags          = { Name = "NAT Gateway" }
}