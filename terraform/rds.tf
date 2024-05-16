resource "aws_db_subnet_group" "private_subnets" {
  name       = "rds-private-subnets"
  subnet_ids = [
    module.network.subnets["private-subnet-1"].id,
    module.network.subnets["private-subnet-2"].id,
  ]
  tags = {
    Name = "${var.prefix_resource_name}-rds-subnet-group"
  }
}

resource "aws_db_instance" "my_rds_instance" {
  identifier             = "rds-instance"
  db_name                = "${var.prefix_resource_name}_rds"
  allocated_storage      = 10
  engine                 = "mysql"
  engine_version         = "5.7"
  instance_class         = "db.t3.micro"
  username               = var.rds_credentials["username"]
  password               = var.rds_credentials["password"]
  db_subnet_group_name   = aws_db_subnet_group.private_subnets.name
  vpc_security_group_ids = [aws_security_group.rds_security_group.id]
  skip_final_snapshot    = true
  

}
