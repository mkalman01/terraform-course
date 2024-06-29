provider "aws" {
  region = "eu-central-1"
}

resource "aws_instance" "server" {
  count         = 4
  ami           = "ami-01e444924a2233b07"
  instance_type = "t3.micro"
  tags = {
    Name = "Server Number ${count.index + 1}"
  }
}

resource "aws_iam_user" "user" {
  count = length(var.aws_users)
  name  = element(var.aws_users, count.index)
}

resource "aws_instance" "bastion_server" {
  count         = var.create_bastion == "Yes" ? 1 : 0
  ami           = "ami-01e444924a2233b07"
  instance_type = "t3.micro"
  tags = {
    Name  = "bastion server"
    Owner = "MK"
  }
}
