aws_region    = "eu-central-1"
port_list     = ["80", "443", "22", "8443"]
instance_size = "t2.micro"
key_pair      = "TerraformKey"

tags = {
  Owner       = "Mk"
  Environment = "Staging"
  Project     = " DevOps"
  Code        = "34543768"
}



