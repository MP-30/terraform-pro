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
#public subnet and route tables
resource "aws_subnet" "public-subnet-1" {
  vpc_id                  = aws_vpc.development-vpc.id
  cidr_block              = var.public_subnet_cidr_blocks[0]
  availability_zone       = "${var.aws_region}a"
  map_public_ip_on_launch = true
  tags = {
    Name = "public-subnet-${var.aws_region}a-1"
  }
}

resource "aws_subnet" "public-subnet-2" {
  vpc_id                  = aws_vpc.development-vpc.id
  cidr_block              = var.public_subnet_cidr_blocks[1]
  availability_zone       = "${var.aws_region}b"
  map_public_ip_on_launch = true
  tags = {
    Name = "public-subnet-${var.aws_region}b-1"
  }
}

resource "aws_subnet" "public-subnet-3" {
  vpc_id                  = aws_vpc.development-vpc.id
  cidr_block              = var.public_subnet_cidr_blocks[2]
  availability_zone       = "${var.aws_region}c"
  map_public_ip_on_launch = true
  tags = {
    Name = "public-subnet-${var.aws_region}c-1"
  }
}

resource "aws_internet_gateway" "development-igw" {
  vpc_id = aws_vpc.development-vpc.id
  tags = {
    Name = "development-igw"
  }
}

resource "aws_route_table" "public-route-table" {
  vpc_id = aws_vpc.development-vpc.id
  tags = {
    Name = "public-route-table"
  }
}

resource "aws_route" "public-internet-route" {
  route_table_id         = aws_route_table.public-route-table.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.development-igw.id
}

resource "aws_route_table_association" "public-route1-association" {
  subnet_id      = aws_subnet.public-subnet-1.id
  route_table_id = aws_route_table.public-route-table.id
}

resource "aws_route_table_association" "public-route2-association" {
  subnet_id      = aws_subnet.public-subnet-2.id
  route_table_id = aws_route_table.public-route-table.id
}

resource "aws_route_table_association" "public-route3-association" {
  subnet_id      = aws_subnet.public-subnet-3.id
  route_table_id = aws_route_table.public-route-table.id
}

resource "aws_subnet" "private-subnet-1" {
  vpc_id            = aws_vpc.development-vpc.id
  cidr_block        = var.private_subnet_cidr_blocks[0]
  availability_zone = "${var.aws_region}a"
  tags = {
    Name = "private-subnet-${var.aws_region}a-1"
  }
}

resource "aws_subnet" "private-subnet-2" {
  vpc_id            = aws_vpc.development-vpc.id
  cidr_block        = var.private_subnet_cidr_blocks[1]
  availability_zone = "${var.aws_region}b"
  tags = {
    Name = "private-subnet-${var.aws_region}b-1"
  }
}
resource "aws_subnet" "private-subnet-3" {
  vpc_id            = aws_vpc.development-vpc.id
  cidr_block        = var.private_subnet_cidr_blocks[2]
  availability_zone = "${var.aws_region}c"
  tags = {
    Name = "private-subnet-${var.aws_region}c-1"
  }
}
# private subnet and route table
resource "aws_route_table_association" "private-route1-association" {
  subnet_id      = aws_subnet.private-subnet-1.id
  route_table_id = aws_route_table.private-route-table.id
}

resource "aws_route_table_association" "private-route2-association" {
  subnet_id      = aws_subnet.private-subnet-2.id
  route_table_id = aws_route_table.private-route-table.id
}

resource "aws_route_table_association" "private-route3-association" {
  subnet_id      = aws_subnet.private-subnet-3.id
  route_table_id = aws_route_table.private-route-table.id
}

resource "aws_route_table" "private-route-table" {
  vpc_id = aws_vpc.development-vpc.id
  tags = {
    Name = "private-route-table"
  }
}

variable "public_subnet_cidr_blocks" {
  type    = list(string)
  default = ["10.0.0.0/24", "10.0.1.0/24", "10.0.2.0/24"]
}

variable "private_subnet_cidr_blocks" {
  type    = list(string)
  default = ["10.0.10.0/24", "10.0.11.0/24", "10.0.12.0/24"]
}

