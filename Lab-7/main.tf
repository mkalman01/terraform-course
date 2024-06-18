provider "aws" {
  region = "eu-central-1"
}

resource "aws_instance" "my_web_server" {
  ami                    = "ami-09e647bf7a368e505"
  instance_type          = "t3.micro"
  vpc_security_group_ids = [aws_security_group.general.id]
  tags                   = { Name = "Server-Web" }
  depends_on             = [aws_instance.my_web_db, aws_instance.my_web_app]
}

resource "aws_instance" "my_web_app" {
  ami                    = "ami-09e647bf7a368e505"
  instance_type          = "t3.micro"
  vpc_security_group_ids = [aws_security_group.general.id]
  tags                   = { Name = "Server-App" }
  depends_on             = [aws_instance.my_web_db]
}

resource "aws_instance" "my_web_db" {
  ami                    = "ami-09e647bf7a368e505"
  instance_type          = "t3.micro"
  vpc_security_group_ids = [aws_security_group.general.id]
  tags                   = { Name = "Server-DB" }
}

resource "aws_security_group" "general" {
  name = "My Security Group"

  dynamic "ingress" {
    for_each = ["80", "443", "22", "3389"]
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
