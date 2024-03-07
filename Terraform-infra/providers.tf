provider "aws" {
  region = "us-west-2"
}

terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "5.38.0"
    }
  }
}
terraform {
  backend "s3" {
    bucket = "miniprojectremotebackend23d3"
    key    = "state/terraform.tfstate" # Store the state file in the "state" folder
    region = "us-west-2"
  }
}

