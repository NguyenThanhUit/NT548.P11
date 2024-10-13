resource "aws_vpc" "lab1-vpc" {
  cidr_block = var.cidr_block
  tags       = { Name = var.vpc_name }
}

resource "aws_subnet" "public" {
  vpc_id                 = aws_vpc.lab1-vpc.id
  cidr_block             = var.public_subnet_cidr
  availability_zone      = var.public_subnet_az
  map_public_ip_on_launch = true
  tags                   = { Name = "Public Subnet" }
}

resource "aws_subnet" "private" {
  vpc_id            = aws_vpc.lab1-vpc.id
  cidr_block        = var.private_subnet_cidr
  availability_zone = var.private_subnet_az
  tags              = { Name = "Private Subnet" }
}

resource "aws_internet_gateway" "gw" {
  vpc_id = aws_vpc.lab1-vpc.id
  tags   = { Name = "Internet Gateway" }
}