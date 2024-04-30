provider "aws" {
  region = "us-east-1"
  access_key = "AKIATWYVMDOSGAHG"
  secret_key = "yaLn+bhuKD86aQZPAt0o2AUuAZdehvBHMxVV"
}

terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 3.0"
    }
  }
}
