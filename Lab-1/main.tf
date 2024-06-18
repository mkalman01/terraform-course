provider "aws" {
  region = "eu-central-1"

}

resource "aws_instance" "my_server" {
  ami           = "ami-01e444924a2233b07"
  instance_type = "t3.micro"
  key_name      = "terraform-key"

  tags = {
    Name = "My-First-Ubuntu-Server"
  }
}

resource "aws_instance" "Prometheus" {
  ami           = "ami-08188dffd130a1ac2"
  instance_type = "t3.micro"

  tags = {
    Name    = "Prometheus-Monitoring"
    Owner   = "Mkalman"
    project = "Monitoring"
  }
}
