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
   Name = "my_vpc"
   Project = "AWS_lab"
 }
}

resource "aws_subnet" "public_subnet1" {
  vpc_id     = aws_vpc.main.id
  cidr_block = "10.0.1.0/24"
  availability_zone = "ap-southeast-2a"

 tags = {
    Name = "public_subnet_1"
    Project = "AWS_lab"
   }
}

resource "aws_subnet" "public_subnet2" {
  vpc_id     = aws_vpc.main.id
  cidr_block = "10.0.2.0/24"
  availability_zone = "ap-southeast-2b"

 tags = {
    Name = "public_subnet_2"
    Project = "AWS_lab"
   }
}

resource "aws_internet_gateway" "ig_gw" {
  vpc_id = aws_vpc.main.id

  tags = {
    Name = "main_ig"
    Type = "internet_gateway"
    Project = "AWS_lab"
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
    Project = "AWS_lab"
   }
}

resource "aws_route_table_association" "PublicSubnetRouteTableAssociation1"{
  subnet_id = aws_subnet.public_subnet1.id
  route_table_id = aws_route_table.public_rt.id
}

resource "aws_route_table_association" "PublicSubnetRouteTableAssociation2"{
  subnet_id = aws_subnet.public_subnet2.id
  route_table_id = aws_route_table.public_rt.id
}

resource "aws_subnet" "private_subnet1" {
  vpc_id     = aws_vpc.main.id
  cidr_block = "10.0.3.0/24"

  tags = {
    Name = "private_subnet_1"
    Project = "AWS_lab"
   }
}

resource "aws_subnet" "private_subnet2" {
  vpc_id     = aws_vpc.main.id
  cidr_block = "10.0.4.0/24"

 tags = {
    Name = "private_subnet_2"
    Project = "AWS_lab"
   }
}

resource "aws_nat_gateway" "nat_gw"{
  subnet_id = aws_subnet.private_subnet1.id
  tags = {
    Name = "nat_gw"
    Project = "AWS_lab"
  }

  depends_on = [aws_internet_gateway.ig_gw]
}


resource "aws_route_table" "private_rt" {
  vpc_id = aws_vpc.main.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_nat_gateway.nat_gw.id
  }

  tags = {
    Name = "public_route_table"
    Project = "AWS_lab"
   }
}

resource "aws_route_table_association" "PrivateSubnetRouteTableAssociation1"{
  subnet_id = aws_subnet.private_subnet1.id
  route_table_id = aws_route_table.private_rt.id
}

resource "aws_route_table_association" "PrivateSubnetRouteTableAssociation2"{
  subnet_id = aws_subnet.private_subnet2.id
  route_table_id = aws_route_table.private_rt.id
}

