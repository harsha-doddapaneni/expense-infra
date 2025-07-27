terraform {
  required_version = ">= 1.3.0"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0" # Use latest 5.x
    }
  }

  backend "s3" {
    bucket         = "81s-remot-statt-dev"
    key            = "expense-eks"
    region         = "us-east-1"
    dynamodb_table = "81s-locking-dev"
  }
}

provider "aws" {
  region = "us-east-1"
}