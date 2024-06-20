provider "aws" {
  region = var.aws_region
}

data "aws_ami" "latest_amazon_linux" {
  owners      = ["137112412989"]
  most_recent = true
  filter {
    name   = "name"
    values = ["al2023-ami-*-x86_64"]
  }
}

resource "aws_eip" "web" {
  instance = aws_instance.web.id
  tags     = merge(var.tags, { Name = "${var.tags["Environment"]}-EIP for WebServer built by Terraform" })
}

resource "aws_instance" "web" {
  ami                    = "ami-09e647bf7a368e505"
  instance_type          = var.instance_size
  vpc_security_group_ids = [aws_security_group.web.id]
  # key_name = var.key_pair
  user_data                   = file("user_data.sh")
  user_data_replace_on_change = true
  tags                        = merge(var.tags, { Name = "${var.tags["Environment"]}-WebServer built by Terraform" })

  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_security_group" "web" {
  name        = "${var.tags["Environment"]}-WebServer-SG"
  description = "Security Group for my ${var.tags["Environment"]}- Webserver"

  dynamic "ingress" {
    for_each = var.port_list
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
  tags = merge(var.tags, { Name = "${var.tags["Environment"]}-SG for WebServer built by Terraform" })
}
