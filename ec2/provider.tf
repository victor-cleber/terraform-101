
terraform {
  required_version = ">= 1.11.0"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "5.94.0"
    }
    tls = {
      source  = "hashicorp/tls"
      version = "~> 4.0"
    }
    local = {
      source  = "hashicorp/local"
      version = "~> 2.0"
    }

  }
}


provider "aws" {
  region = "sa-east-1" # South Brazil

  # shared_config_files = ""
  # profile = ""
  default_tags {
    tags = {
      project    = "udemmy-terraform-101"
      owner      = "Victor2025"
      managed_by = "terraform"
    }
  }
}