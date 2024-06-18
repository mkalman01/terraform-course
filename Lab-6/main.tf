# Simpel WebServer with External File

provider "aws" {
  region = "eu-central-1"
}
resource "aws_eip" "web" {
  instance = aws_instance.web.id
  tags = {
    Name  = "EIP for WebServer built by Terraform"
    Owner = "Mkalman"
  }
}
resource "aws_instance" "web" {
  ami                         = "ami-09e647bf7a368e505"
  instance_type               = "t3.micro"
  vpc_security_group_ids      = [aws_security_group.web.id]
  user_data                   = file("user_data.sh")
  user_data_replace_on_change = true
  tags = {
    Name  = "WebServer built by Terraform"
    Owner = "Mkalman"
  }

  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_security_group" "web" {
  name        = "WebServer-SG"
  description = "Security Group for my Webserver"

  dynamic "ingress" {
    for_each = ["80", "443"]
    content {
      description = "Allow Port Web"
      from_port   = ingress.value
      to_port     = ingress.value
      protocol    = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
    }
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
