terraform {
  required_providers {    
    aws= {
      source ="hashicorp/aws"
      version = "~>4.0.0"
    }
  }
}
provider "aws" {
    region = "ap-southeast-2"
    profile= "default"
}

resource "aws_vpc" "main" {
 cidr_block = "10.0.0.0/16"
 enable_dns_hostnames =  true
 enable_dns_support = true
 tags = {
   Name = "VPC Project"
 }
}

resource "aws_subnet" "private_subnet" {
  vpc_id     = aws_vpc.main.id
  cidr_block = "10.0.1.0/24"

  tags = {
    Name = "private"
  }
}

resource "aws_subnet" "public_subnet1" {
  vpc_id     = aws_vpc.main.id
  cidr_block = "10.0.1.0/24"

  tags = {
    Name = "public1"
  }
}


resource "aws_subnet" "public_subnet2" {
  vpc_id     = aws_vpc.main.id
  cidr_block = "10.0.2.0/24"

  tags = {
    Name = "public2"
  }
}

resource "aws_internet_gateway" "ig_gw" {
  vpc_id = aws_vpc.main.id

  tags = {
    Name = "main_ig"
  }
}

resource "aws_route_table" "public_rt" {
  vpc_id = aws_vpc.main.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.ig_gw.id
  }

  tags = {
    Name = "public_route_table"
  }
}

