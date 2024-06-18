# Simpel WebServer with External File

provider "aws" {
  region = "eu-central-1"
}

resource "aws_instance" "web" {
  ami                    = "ami-0c5823fd00977ca15"
  instance_type          = "t3.micro"
  vpc_security_group_ids = [aws_security_group.web.id]
  user_data              = file("user_data.sh")
  tags = {
    Name  = "WebServer built by Terraform"
    Owner = "Mkalman"
  }
}

resource "aws_security_group" "web" {
  name        = "WebServer-SG"
  description = "Security Group for my Webserver"

  ingress {
    description = "Allow Port HTTP"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    description = "Allow Port HTTPS"
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
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
