terraform {
  required_providers {
    mongodbatlas = {
      source = "mongodb/mongodbatlas"
      version = "= 1.14.0"
    }
    aws = {
      source = "hashicorp/aws"
      version = "= 5.31.0"
    }
  }
  required_version = ">= 0.13"
}

provider "mongodbatlas" {
  public_key = "<public_key>"
  private_key  = "<private_key>"
}

provider "aws" {
  region  = "<aws_region>"
  access_key = "<aws_access_Key>"
  secret_key = "<aws_secret_Key>"
}