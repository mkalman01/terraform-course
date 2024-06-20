aws_region    = "eu-central-1"
port_list     = ["80", "443", "22", "8443"]
instance_size = "t3.large"
key_pair      = "TerraformKey"

tags = {
  Owner       = "Mk"
  Environment = "Prod"
  Project     = " DevOps"
  Code        = "342251"
}



