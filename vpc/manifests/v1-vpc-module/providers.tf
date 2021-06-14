terraform {
  required_version = "0.15.5" // use fixed version
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 3.0" // right most is lower and upper bound of version
    }
  }
  # backend "s3" {
  #   bucket         = "terraform-auto-scale-demo-state"
  #   key            = "terraform-auto-scale.tfstate"
  #   region         = "us-east-1"
  #   encrypt        = true
  #   dynamodb_table = "terraform-auto-scale-demo-state-lock"
  # }
}


provider "aws" {
  region = var.aws_region
  # access_key = var.AWS_ACCESS_KEY
  # secret_key = var.AWS_SECRET_KEY
}

