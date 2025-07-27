terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = ">= 6.0.0" # Ensures the latest 5.x version, but avoids 6.x
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