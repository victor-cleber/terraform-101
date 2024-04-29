terraform {
  required_providers {    
    aws= {
      source ="hashicorp/aws"
      #version = "~>4.0.0"
    }
  }
}
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

