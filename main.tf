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

resource "aws_key_pair" "accessKey" {
  key_name   = "deployer-key"
  public_key = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQCw3aP7dogXFwwSV0eiD8m6PL/Txy8gluW3Ec2aXZou4IZxwqmgXNw5W3aN5ITjF5A60yLJLrgEWYETMrh+DFEKmXdcV1eFqdELZb5w7cjUnLNn66vLMVdojq+wY8gxijw5ikrttWLhD47KTKwaRH1w5n5zR4BjLNDCe5Qfj54EmgR5VH/0R2fbh974Q87nqlgvOpTWtFHwsmgp3jh2mWLdMM69unakt7zO6DyALqBQ2hfnLHnRUyot5H4+x82z8zgzL92EHvCPB6cVIVMuJbcZjKXk71BqPr7MMtgxZgmrG3Ru/m/eS1bsoc6h+GvU6tQDhz5uIBRCXN8KbMLDhpYR ec2KeyPair@bizkit"
}

#resource "aws_instance" "controller" {
#  ami           = "ami-0d1ddd83282187d18" # Ubuntu 22.04 LTS in Frankfurt
#  instance_type = "t2.micro"
#
#  tags = {
#    Name = "controller"
#  }
#}

resource "aws_instance" "controller" {
  ami           = "ami-0abaf6cca7f5c0e6a" # Ubuntu 22.04 ARM LTS in Frankfurt
  instance_type = "t4g.small"
  key_name      = aws_key_pair.accessKey

#  provisioner "file" {
#    source      = "files/installK3sServer.sh"
#    destination = "/tmp/installK3sServer.sh"
#  }

  user_data = file("files/installK3sServer.sh")

  tags = {
    Name = "controller"
  }
}

## Trial 750h/month free UNTIL Dec 31st 2023! Revisit after trial over!
#resource "aws_instance" "node" {
#  ami           = "ami-0abaf6cca7f5c0e6a" # Ubuntu 22.04 ARM LTS in Frankfurt
#  instance_type = "t4g.small"
#  count = 3
#
#  tags = {
#    Name = "node.${count.index}"
#  }
#
#  depends_on = [
#    aws_instance.controller
#  ]
#}
