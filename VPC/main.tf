locals {
  valid_public_subnet_info = {
    for k,v in var.public-subnets : k=>v
    if v.cidr_block != "" && v.azs != "" 
  }
  valid_private_subnet_info = {
    for k,v in var.var.private_subnets : k=>v
    if v.cidr_block != "" && v.azs !=""
  }
}

resource "aws_vpc" "custom_vpc" {
  cidr_block = var.vpc-cidr-block

  tags = {
    Name = "${var.tag-name}-vpc"
  }
}

# Public Subnets
resource "aws_subnet" "public_subnets" {
  for_each = local.valid_public_subnet_info
  vpc_id = aws_vpc.custom_vpc.id
  cidr_block = each.value.cidr_block
  availability_zone = each.value.azs
  map_public_ip_on_launch = each.value.map_public_ip_on_launch

  tags = {
    Name = "${var.tag-name}-${each.value.azs}-public-subnet"
  }
}

# Internet Gateway
resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.custom_vpc.id

  tags = {
    Name = "${var.tag-name}-igw"
  }
}

# Public Route table 
resource "aws_route_table" "public_table" {
  vpc_id = aws_vpc.custom_vpc.id
  
  route {
    cidr_block = aws.vpc.custom_vpc.cidr_block
    gateway_id = "local"
  }
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
  }

  tags = {
    Name = "${var.tag-name}-public-route-table"
  }
}

# Public route associate with table
resource "aws_route_table_association" "public_associate" {
  for_each = aws_subnet.public_subnets
  subnet_id = each.value.id
  route_table_id = aws_route_table.public_table.id
}

# Private Subnets
resource "aws_subnet" "private-subnets" {
  for_each = local.valid_private_subnet_info
  vpc_id = aws_vpc.custom_vpc.id
  cidr_block = each.value.cidr_block
  availability_zone = each.value.azs
}

# Private Route table
resource "aws_route_table" "private_table" {
  vpc_id = aws_vpc.custom_vpc.id

  route {
    cidr_block = aws_vpc.custom_vpc.cidr_block
    gateway_id = "local"
  }

  tags = {
    Name = "{var.tag-name}-private-route-table"
  }
}

# Private route table associate
resource "aws_route_table_association" "private_associate" {
  for_each = aws_subnet.private-subnets
  subnet_id = each.value.id
  route_table_id = aws_route_table.private_table.id
}