variable "aws_users" {
  description = "List of IAM Users to create"
  default = [
    "pisti@mkhome.org",
    "gusti@mkhome.org",
    "iuti@mkhome.org",
    "jancsi@mkhome.org"
  ]
}

variable "create_bastion" {
  description = "Provision Bastion Server Yes/No"
  default     = "No"
}
