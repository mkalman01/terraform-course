provider "aws" {
  region = "eu-central-1"
}

# resource "aws_instance" "myserver" {
#   ami = "data.aws_ami.latest_ubuntu24.id"
#   instance_type = "t3.micro"
# }

data "aws_ami" "latest_ubunut24" {
  owners      = ["099720109477"]
  most_recent = true
  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd-gp3/ubuntu-noble-24.04-amd64-server-*"]
  }
}

data "aws_ami" "latest_amazonlinux" {
  owners      = ["137112412989"]
  most_recent = true
  filter {
    name   = "name"
    values = ["al2023-ami-*-x86_64"]
  }
}

data "aws_ami" "latest_windowserver2022" {
  owners      = ["801119661308"]
  most_recent = true
  filter {
    name   = "name"
    values = ["Windows_Server-2022-English-Full-Base-*"]
  }
}

output "latest_ubuntu_ami" {
  value = data.aws_ami.latest_ubunut24.id
}

output "latest_amazon_ami" {
  value = data.aws_ami.latest_amazonlinux.id
}

output "latest_windowserver2022" {
  value = data.aws_ami.latest_windowserver2022.id
}
