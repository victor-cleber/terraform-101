# terraform {
#   required_providers {    
#     aws= {
#       source ="hashicorp/aws"
#       version = "~>4.0.0"
#     }
#   }
# }
provider "aws" {
  region = "ap-southeast-2"
  #profile= "default"
}


terraform {
  backend "s3" {
    bucket = "vc-workshop-17"
    key    = "infra"
    region = "ap-southeast-2"
    encrypt        = true
  }
}

resource "aws_vpc" "main" {
  cidr_block           = "10.0.0.0/16"
  enable_dns_hostnames = true
  enable_dns_support   = true
  tags = {
    Name    = "my_vpc"
    Project = "AWS_lab"
  }
}
