resource "aws_route_table" "route_tables" {
  count=2
  vpc_id = aws_vpc.my_vpc.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = count.index == 0? aws_internet_gateway.my_igw.id:aws_nat_gateway.my_nat_gateway.id
  }
  tags = {
    Name = "${var.prefix_resource_name}-${count.index == 0 ? "public" : "private"}-route-table"
  }
}

#---------------------------------------------associations------------------------------------------------

# Associate Public Route Table with Public Subnet 1
resource "aws_route_table_association" "public_subnet_1_association" {
  subnet_id      = aws_subnet.subnets["public-subnet-1"].id
  route_table_id = aws_route_table.route_tables[0].id
}

# Associate Public Route Table with Public Subnet 2
resource "aws_route_table_association" "public_subnet_2_association" {
  subnet_id      = aws_subnet.subnets["public-subnet-2"].id
  route_table_id = aws_route_table.route_tables[0].id
}

# Associate Private Route Table with Private Subnet 1
resource "aws_route_table_association" "private_subnet_1_association" {
  subnet_id      = aws_subnet.subnets["private-subnet-1"].id
  route_table_id = aws_route_table.route_tables[1].id
}

# Associate Private Route Table with Private Subnet 2
resource "aws_route_table_association" "private_subnet_2_association" {
  subnet_id      = aws_subnet.subnets["private-subnet-2"].id
  route_table_id = aws_route_table.route_tables[1].id
}