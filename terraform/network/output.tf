output "vpc_cidr_block" {
  value       = aws_vpc.my_vpc.cidr_block
  description = "The CIDR block of the VPC. This defines the IP address range that can be used within the VPC."
}

output "vpc_id" {
  value       = aws_vpc.my_vpc.id
  description = "The unique identifier (ID) of the VPC. This ID is used to reference the VPC in other AWS resources and operations."
}

output "subnets" {
  value       = aws_subnet.subnets
  description = "A list of subnets created within the VPC and their info."
}
