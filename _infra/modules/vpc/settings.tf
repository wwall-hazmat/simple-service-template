terraform {

  backend "s3" {
    bucket = "ecs-infra-template"
    key    = "state.tfstate"
    region = "us-west-2"
  }

  required_providers {
    aws = {
      source  = "hashicorp/aws"
    }
  }
}