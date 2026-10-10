locals {
  env = terraform.workspace
}
provider "aws" {
  region = var.aws_region

  default_tags {
    tags = {
      Project   = "terraform-pro"
      ManagedBy = "terraform"
      Environment = local.env
    }
  }
}

variable "aws_region" {
  type    = string
  default = "ap-south-1"
}