provider "aws" {
  region = "eu-central-1"
}

terraform {
  backend "s3" {
    bucket         = "sirbizkit-infra-terraform-state"
    key            = "terraform.tfstate"
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

# ami-0abaf6cca7f5c0e6a # Ubuntu 22.04 ARM LTS in Frankfurt
