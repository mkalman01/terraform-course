# Simpel WebServer with external template file

provider "aws" {
  region = "eu-central-1"
}

resource "aws_security_group" "web" {
  name        = "WebServer-SG"
  description = "Security Group for my Webserver"

  dynamic "ingress" {
    for_each = ["80", "8080", "443", "1000", "8443"]
    content {
      description = "Allow Port HTTP"
      from_port   = ingress.value
      to_port     = ingress.value
      protocol    = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
    }
  }
  dynamic "ingress" {
    for_each = ["80", "8080", "443", "1000", "8443"]
    content {
      description = "Allow Port HTTP"
      from_port   = ingress.value
      to_port     = ingress.value
      protocol    = "udp"
      cidr_blocks = ["0.0.0.0/0"]
    }
  }

  ingress {
    description = "Allow Port SSH"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["79.118.102.137/32"]
  }

  egress {
    description = "Allow All Port "
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
  tags = {
    Name  = "WebServer SG by Terraform"
    Owner = "Mkalman"
  }
}
