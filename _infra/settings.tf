terraform {
  backend "s3" {
    bucket = "simple-service-template"
    key    = "state.tfstate"
    region = "us-east-1"
  }

  required_providers {
    aws = {
      source  = "hashicorp/aws"
    }
  }
}

provider "aws" {
  region = var.region
}
