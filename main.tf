provider "aws" {
  region = "eu-central-1"
}

terraform {
  backend "s3" {
    bucket         = "sirbizkit-infra-terraform-state"
    key            = "global/s3/terraform.tfstate"
    region         = "eu-central-1"

    dynamodb_table = "sirbizkit-infra-terraform-locks"
    encrypt        = true
  }
}

resource "aws_instance" "controller" {
  ami           = "ami-0d1ddd83282187d18" # Ubuntu 22.04 LTS in Frankfurt
  instance_type = "t2.micro"

  tags = {
    Name = "controller"
  }
}