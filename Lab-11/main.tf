provider "aws" {}

data "aws_region" "curent" {}
data "aws_caller_identity" "current" {}
data "aws_availability_zones" "working" {}
data "aws_vpcs" "vpcs" {}

data "aws_vpc" "prod" {
  tags = {
    Name = "PROD"
  }
}

resource "aws_subnet" "sub1" {
  vpc_id            = data.aws_vpc.prod.id
  availability_zone = data.aws_availability_zones.working.names[0]
  cidr_block        = "10.0.1.0/24"

  tags = {
    Name = "Sub1"
    Info = "AZ: ${data.aws_availability_zones.working.names[0]} in Region: ${data.aws_region.curent.description}"
  }
}

resource "aws_subnet" "sub2" {
  vpc_id            = data.aws_vpc.prod.id
  availability_zone = data.aws_availability_zones.working.names[1]
  cidr_block        = "10.0.2.0/24"

  tags = {
    Name = "Sub2"
    Info = "AZ: ${data.aws_availability_zones.working.names[1]} in Region: ${data.aws_region.curent.description}"
  }
}

output "region_name" {
  value = data.aws_region.curent.name
}

output "region_description" {
  value = data.aws_region.curent.description
}

output "account_id" {
  value = data.aws_caller_identity.current.account_id
}

output "working" {
  value = data.aws_availability_zones.working.names
}

output "all_vpc_ids" {
  value = data.aws_vpcs.vpcs.ids
}
