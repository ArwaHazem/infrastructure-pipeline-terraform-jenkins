resource "aws_subnet" "subnets" {
for_each = { for subnet in var.subnets_info : subnet.name => subnet }
  vpc_id            = aws_vpc.my_vpc.id
  cidr_block        = each.value.cidr_block
  availability_zone = each.value.availability_zone
  tags = {
    Name = "${var.prefix_resource_name}-${each.value.name}-subnet"
  }
}