provider "aws" {
  region = "eu-central-1"
}

resource "aws_instance" "WebServer2" {
  ami                    = "ami-01e444924a2233b07"
  instance_type          = "t3.micro"
  vpc_security_group_ids = [aws_security_group.WebServer2.id]
  key_name               = "WebServer2"
  tags = {
    Name  = "EC2 with remote exec"
    Owner = "MK"
  }

  provisioner "remote-exec" {
    inline = [
      "mkdir /home/ubuntu/terraform",
      "cd /home/ubuntu/terraform",
      "touch hello.txt",
      "echo 'Terraform was here...' > hello.txt"
    ]
    connection {
      type        = "ssh"
      user        = "ubuntu"
      host        = self.public_ip //aws_instance.WebServer2.public_ip
      private_key = file("WebServer2.pem")
    }
  }

}

resource "aws_security_group" "WebServer2" {
  name = "MyWebServer2"
  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  egress {
    description = "Allow all ports"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
  tags = {
    Name  = " SG with Terraform "
    Owner = "MK"
  }
}
