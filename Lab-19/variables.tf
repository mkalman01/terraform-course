variable "env" {
  default = "test"
}

variable "server_size" {
  default = {
    prod       = "t3.large"
    staging    = "t3.medium"
    dev        = "t3.small"
    my_default = "t3.nano"
  }
}

variable "ami_id_per_region" {
  description = "My Custom AMI id per Region"
  default = {
    "eu-central-1" = "ami-01e444924a2233b07"
    "eu-west-1"    = "ami-0776c814353b4814d"
    "eu-west-2"    = "ami-053a617c6207ecc7b"
    "eu-north-1"   = "ami-0705384c0b33c194c"
  }
}

variable "allow_port" {
  default = {
    prod = ["80", "443"]
    rest = ["80", "443", "8080", "22"]
  }
}
