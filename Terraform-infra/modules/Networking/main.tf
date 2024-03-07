resource "aws_vpc" "project_vpc" {
  cidr_block = var.vpc_cidr_block
  enable_dns_support = true
  enable_dns_hostnames = true
  tags = {
    Name = var.project_vpc
  }
}

resource "aws_subnet" "public_subnet_1" {
  vpc_id            = aws_vpc.project_vpc.id
  cidr_block        = var.public_subnet_1_cidr_block
  availability_zone = var.availability_zone_1
  map_public_ip_on_launch = true
  tags = {
    Name = "${var.project_vpc}-public-subnet-1"
  }
}

resource "aws_subnet" "public_subnet_2" {
  vpc_id            = aws_vpc.project_vpc.id
  cidr_block        = var.public_subnet_2_cidr_block
  availability_zone = var.availability_zone_2
  map_public_ip_on_launch = true
  tags = {
    Name = "${var.project_vpc}-public-subnet-2"
  }
}

resource "aws_subnet" "private_subnet_1" {
  vpc_id            = aws_vpc.project_vpc.id
  cidr_block        = var.private_subnet_1_cidr_block
  availability_zone = var.availability_zone_1
  tags = {
    Name = "${var.project_vpc}-private-subnet-1"
  }
}

resource "aws_subnet" "private_subnet_2" {
  vpc_id            = aws_vpc.project_vpc.id
  cidr_block        = var.private_subnet_2_cidr_block
  availability_zone = var.availability_zone_2
  tags = {
    Name = "${var.project_vpc}-private-subnet-2"
  }
}

resource "aws_internet_gateway" "gw" {
  vpc_id = aws_vpc.project_vpc.id
}

resource "aws_route_table" "public" {
  vpc_id = aws_vpc.project_vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.gw.id
  }

  tags = {
    Name = "public"
  }
}

resource "aws_route_table_association" "public_subnet_1" {
  subnet_id      = aws_subnet.public_subnet_1.id
  route_table_id = aws_route_table.public.id
}

resource "aws_route_table_association" "public_subnet_2" {
  subnet_id      = aws_subnet.public_subnet_2.id
  route_table_id = aws_route_table.public.id
}
