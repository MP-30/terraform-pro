provider "aws" {
  region = "us-east-1"
}
terraform {
  required_version = ">=1.10"
  required_providers {
    aws = {
      source = "hashicorp/aws"
      version = "~>6.0"
    }
  }
}

resource "aws_instance" "my_instance" {
  ami = var.ami_value
  instance_type = var.instance_type
  tags = {
    Name = "my-instance"
  }
}

variable "ami_value" {
  type = string
  # default = "ami-0b6d9d3d33ba97d99"
}
variable "instance_type" {
  type = string
}

output "my_output" {
  value = aws_instance.my_instance.public_ip
}