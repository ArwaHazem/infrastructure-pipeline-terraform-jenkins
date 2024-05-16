terraform {
  backend "s3" {
    bucket = "terraform-lab1-task1-state-file"
    key    = "terraform.tfstate"
    region = "us-east-1"
    dynamodb_table = "terraform-state-lock"
  }
}