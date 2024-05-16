resource "tls_private_key" "myprivatekey" {
  algorithm = "RSA"
  rsa_bits  = 2048
}

resource "aws_key_pair" "deployer" {
  key_name   = "terraform-test"
  public_key = tls_private_key.myprivatekey.public_key_openssh
}

resource "local_file" "private_key" {
  content  = tls_private_key.myprivatekey.private_key_pem
  filename = "./terraform-test.pem"
  file_permission = "0600"
}