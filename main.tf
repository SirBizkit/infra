provider "aws" {
  region = "eu-central-1"
}

resource "aws_instance" "controller" {
  ami           = "ami-0d1ddd83282187d18" # Ubuntu 22.04 LTS in Frankfurt
  instance_type = "t2.micro"
}