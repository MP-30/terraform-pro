provider "aws" {
  region = var.aws_region

  default_tags {
    tags = {
      Project   = "terraform-pro"
      ManagedBy = "terraform"
    }
  }
}

variable "aws_region" {
  type    = string
  default = "ap-south-1"
}