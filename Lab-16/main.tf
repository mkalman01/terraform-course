provider "aws" {
  region = "eu-central-1"
}

data "aws_region" "current" {}
data "aws_availability_zones" "available" {}

locals {
  Region_fullname   = data.aws_region.current.description
  Number_of_AZs     = length(data.aws_availability_zones.available.names)
  Names_of_AZs      = join(",", data.aws_availability_zones.available.names)
  Full_project_name = "${var.project_name} running in ${local.Region_fullname}"
}

locals {
  Region_info_v1 = "This Resource is in ${data.aws_region.current.description} consist of ${length(data.aws_availability_zones.available)} AZs"
  Region_info_v2 = "This Resource is in ${local.Region_fullname} consist of ${local.Number_of_AZs}"
}

locals {
  tags_for_eip = {
    Environment     = var.environment
    Region_fullname = local.Region_info_v2
    Project_name    = local.Full_project_name
  }
}

resource "aws_vpc" "main" {
  cidr_block = "10.3.0.0/16"
  tags = {
    Name           = "MyVPC"
    Region_info_v1 = local.Region_info_v1
    Region_info_v2 = local.Region_info_v2
    AZ_names       = local.Names_of_AZs
  }
}

resource "aws_eip" "my_static_ip" {
  tags = merge(var.tags, local.tags_for_eip, {
    Name           = "My EIP"
    Region_info_v2 = local.Region_info_v2
  })
}
