module "network" {
  source            = "./network"
  vpc_cidr          = var.vpc_cidr
  prefix_resource_name = var.prefix_resource_name
  subnets_info   = var.subnets_info
}