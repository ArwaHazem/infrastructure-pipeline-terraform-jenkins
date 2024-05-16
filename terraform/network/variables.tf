variable "vpc_cidr" {
  type        = string
  description = "The CIDR block for the VPC. This defines the IP address range that can be used within the VPC."
}

variable "prefix_resource_name" {
  type        = string
  default     = "iti44"
  description = "A common name prefix for resources. This name will be used as a prefix for resource names."
}

variable "subnets_info" {
  type        = list(object({
    name              = string
    cidr_block        = string
    availability_zone = string
  }))
  description = "Defines the configuration details for subnets to be created within the VPC. Each subnet must have a unique name, CIDR block and the availability zone for each subnet should be specified."
}
