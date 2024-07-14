resource "aws_vpc" "custom-vpc" {
  cidr_block = var.vpc_cidr_block

  tags = {
    Name = "${var.tag_name}-vpc"
  }
}

locals {
  valid-public-subnet-info- = {
    for k,v in var.public_subnets : k=>v
    if v.cidr_block != "" && v.azs != "" 
  }
}

# Public Subnets
resource "aws_subnet" "public-subnets" {
  for_each = { for k,v in var.public_subnets : k => v if v.cidr_block != "" && v.azs != "" }
  vpc_id = aws_vpc.custom-vpc.id
  cidr_block = each.value.cidr_block
  availability_zone = each.value.azs
  map_public_ip_on_launch = each.value.map_public_ip_on_launch

  tags = {
    Name = "${var.tag_name}-${each.value.azs}-public-subnet"
  }
}

# Internet Gateway
resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.custom-vpc.id

  tags = {
    Name = "${var.tag_name}-igw"
  }
}

# Public Route table 
resource "aws_route_table" "public-table" {
  vpc_id = aws_vpc.custom-vpc.id

  tags = {
    Name = "${var.tag_name}-public-table"
  }
}

# Public Route 
resource "aws_route" "public-route" {
  route_table_id = aws_route_table.public-table.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id = aws_internet_gateway.igw.id
}

# Public route associate with table
resource "aws_route_table_association" "public-associate" {
  for_each = aws_subnet.public-subnets
  subnet_id = each.value.id
  route_table_id = aws_route_table.public-table.id
}



# Private Subnets
# resource "aws_subnet" "private-subnets" {
#   for_each = var.private_subnets != null && var.private_subnets != [] ? toset(var.private_subnets) : {}
#   vpc_id = aws_vpc.custom-vpc.id
#   cidr_block = cidrsubnet(aws_vpc.custom-vpc.cidr_block,8,length(var.private_subnets)+20)
#   availability_zone = each.value
#   map_public_ip_on_launch = false

#   tags = {
#     Name = "${var.tag_name}-${each.value}}-private-subnet"
#   }
# }