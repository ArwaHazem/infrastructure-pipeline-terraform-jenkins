variable "vpc_cidr" {
  type        = string
  description = "The CIDR block for the VPC. This defines the IP address range that can be used within the VPC."
}

variable "region" {
  type        = string
  description = "The AWS region where resources will be provisioned."
}

variable "prefix_resource_name" {
  type        = string
  description = "A prefix used for naming resources. This helps ensure uniqueness and organization of resource names."
}

variable "instance_type" {
  type        = string
  description = "description"
}

variable "rds_credentials" {
  type        = object({
    username = string
    password = string
  })
  description = "Credentials for RDS"
}




variable "subnets_info" {
  type        = list(object({
    name              = string
    cidr_block        = string
    availability_zone = string
  }))
  description = "Defines the configuration details for subnets to be created within the VPC. Each subnet must have a unique name, CIDR block and the availability zone for each subnet should be specified."
}