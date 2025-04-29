terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
      version = "5.94.1"
    }
  }

  backend "s3" {
    bucket = "81s-remot-state"
    key    = "expense-rds-dev"
    region = "us-east-1"
    dynamodb_table = "81s-locking-dev"
  }
}

provider "aws" {
  # Configuration options
  region = "us-east-1"
}