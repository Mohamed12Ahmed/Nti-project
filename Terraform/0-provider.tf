provider "aws" {
  region = "us-east-1"
  access_key = "AKIATWYVSWGAHGYY7"
  secret_key = "yaLn+bhuKaQFby8ZPAt0o2AUuAZdehvBHMxVV"
}

terraform {
  required_providers {
     aws = {
       source  = "hashicorp/aws"
       version = "~> 3.0"    }
   }
 }
