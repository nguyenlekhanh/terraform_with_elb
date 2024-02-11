terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
    }
  }
  backend "s3" {
    bucket  = "s3-devops-tfstate-999"
    key     = "devops-app.tfstate"
    region  = "us-east-1"
    encrypt = true
  }
}

provider "aws" {
  region                   = "us-east-1"
  shared_credentials_files = ["~/.aws/credentials"]
  profile                  = "vscode"
}