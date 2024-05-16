data "aws_ami" "ubuntu" {
  most_recent = true

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-jammy-22.04-amd64-server-*"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }
  owners = ["099720109477"]
}

resource "aws_instance" "bastion" {
  ami             = data.aws_ami.ubuntu.id
  instance_type   = var.instance_type
  subnet_id       = module.network.subnets["public-subnet-1"].id 
  key_name        = aws_key_pair.deployer.key_name
  vpc_security_group_ids = [aws_security_group.ssh_from_anywhere.id]
  associate_public_ip_address = true

  user_data = <<-EOF
              #!/bin/bash
              echo '${tls_private_key.myprivatekey.private_key_pem}' > /home/ubuntu/.ssh/id_rsa
              chmod 400 /home/ubuntu/.ssh/id_rsa
              chown ubuntu:ubuntu /home/ubuntu/.ssh/id_rsa
              EOF
  tags = {
    Name = "${var.prefix_resource_name}-bastion"
  }
  provisioner "local-exec" {
    command = "echo 'Public IP: ${self.public_ip}'"
  }
}

resource "aws_instance" "application" {
  ami             = data.aws_ami.ubuntu.id
  instance_type   = var.instance_type
  subnet_id       = module.network.subnets["private-subnet-1"].id 
  key_name        = aws_key_pair.deployer.key_name
  vpc_security_group_ids = [aws_security_group.ssh_and_3000_from_vpc.id]
  associate_public_ip_address = false

  tags = {
    Name = "${var.prefix_resource_name}-application"
  }
}