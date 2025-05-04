terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
      version = ">= 5.0.0, < 6.0.0"
    }
  }

  backend "s3" {
    bucket = "81-remot-stat-dev"
    key    = "expense-eks"
    region = "us-east-1"
    dynamodb_table = "81s-locking-dev"
  }
}

provider "aws" {
  region = "us-east-1"
}
