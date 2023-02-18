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

#  provisioner "file" {
#    source      = "files/installK3sServer.sh"
#    destination = "/tmp/installK3sServer.sh"
#  }

  user_data = file("files/installK3sServer.sh")

  tags = {
    Name = "controller"
  }
}

# Trial 750h/month free UNTIL Dec 31st 2023! Revisit after trial over!
resource "aws_instance" "node" {
  ami           = "ami-0abaf6cca7f5c0e6a" # Ubuntu 22.04 ARM LTS in Frankfurt
  instance_type = "t4g.small"
  count = 3

  tags = {
    Name = "node.${count.index}"
  }

  depends_on = [
    aws_instance.controller
  ]
}
