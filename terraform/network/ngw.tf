#NAT Gateway
resource "aws_nat_gateway" "my_nat_gateway" {
  allocation_id = aws_eip.my_eip.id
  subnet_id     = aws_subnet.subnets["public-subnet-1"].id

  tags = {
    Name = "${var.prefix_resource_name}-ngw"
  }
}

resource "aws_eip" "my_eip" {
    tags = {
    "Name" = "${var.prefix_resource_name}-eip"
  }
}