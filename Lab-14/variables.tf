variable "aws_region" {
  description = "Region where you provision EC2 instance"
  type        = string
  default     = "eu-central-1"
}

variable "port_list" {
  description = "List of ports to open for out Webserver"
  type        = list(any)
  default     = ["80", "443"]
}

variable "instance_size" {
  description = "EC2 Instnace Size toProvision"
  type        = string
  default     = "t3.micro"
}

variable "tags" {
  description = "Tags to apply to resources"
  type        = map(any)
  default = {
    Owner       = "Mk"
    Environment = "Prod"
    Project     = " DevOps"
  }
}

# variable "key_pair" {
#   description = "SSH Key pair name to ingest into EC2"
#   type        = string
#   default     = "TerraformKey"
#   sensitive   = true
# }

# variable "password" {
#   description = "Enter Password lenght of 10 char"
#   type        = string
#   sensitive   = true
#   validation {
#     condition     = length(var.password) == 10
#     error_message = "Your password must be 10 char exactly"
#   }
# }
