resource "aws_vpc" "development-vpc" {
  cidr_block           = var.vpc_cidr_block
  enable_dns_hostnames = true
  tags = {
    Name = "development-vpc"
  }
}

variable "vpc_cidr_block" {
  type    = string
  default = "10.0.0.0/16"
}
resource "aws_subnet" "public-subnet-1" {
  vpc_id            = aws_vpc.development-vpc.id
  cidr_block        = var.public_subnet_cidr_block
  availability_zone = "${var.aws_region}a"
  tags = {
    Name = "public-subnet-${var.aws_region}a-1"
  }
}

resource "aws_subnet" "public-subnet-1" {
  vpc_id            = aws_vpc.development-vpc.id
  cidr_block        = var.public_subnet_cidr_block
  availability_zone = "${var.aws_region}a"
  tags = {
    Name = "public-subnet-${var.aws_region}b-1"
  }
}

resource "aws_subnet" "public-subnet-1" {
  vpc_id            = aws_vpc.development-vpc.id
  cidr_block        = var.public_subnet_cidr_block
  availability_zone = "${var.aws_region}a"
  tags = {
    Name = "public-subnet-${var.aws_region}c-1"
  }
}

resource "aws_route_table" "public-route-table" {
  vpc_id = aws_vpc.development-vpc.id
  tags = {
    Name = "public-route-table"
  }
}

resource "aws_route_table_association" "public-route-association" {
  subnet_id = aws_subnet.public-subnet-1.id
  route_table_id = aws_route_table.public-route-table.id
}

variable "public_subnet_cidr_block" {
  type    = string
  default = "10.0.0.0/24"
}

