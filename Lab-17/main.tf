provider "aws" {
  region = "eu-central-1"
}

resource "null_resource" "command1" {
  provisioner "local-exec" {
    command = "echo Terraform START: $(date) >> log.txt"
  }
}

resource "null_resource" "command2" {
  provisioner "local-exec" {
    command = "ping -c 5 www.google.com"
  }
}

resource "null_resource" "pythoncommand" {
  provisioner "local-exec" {
    interpreter = ["python3", "-c"]
    command     = "print('hello terrafomr')"
  }
}

resource "null_resource" "command_env" {
  provisioner "local-exec" {
    command = "echo $NAME1 $NAME2 >> log.txt"
    environment = {
      NAME1 = "Billy"
      NAME2 = "Hill"
    }
  }
}

resource "aws_instance" "myserver" {
  ami           = "ami-01e444924a2233b07"
  instance_type = "t3.micro"
  provisioner "local-exec" {
    command = "echo ${aws_instance.myserver.private_ip} >> log.txt"
  }
}

resource "null_resource" "command_last" {
  provisioner "local-exec" {
    command = "echo Terraform FINISH: $(date) >> log.txt"
  }
  depends_on = [
    null_resource.command1,
    null_resource.command2,
    null_resource.command_env,
    null_resource.pythoncommand,
    aws_instance.myserver
  ]
}
