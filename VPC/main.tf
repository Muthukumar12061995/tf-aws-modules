resource "aws_vpc" "custom-vpc" {
  cidr_block = var.networking.cidr_block

  tags = {
    Name = "${var.networking.tag_name}-vpc"
  }
}

# Public Subnets
resource "aws_subnet" "public-subnets" {
  for_each = var.networking.public_subnets != null && var.networking.public_subnets != {} ? toset(var.networking.public_subnets) : {}
  vpc_id = aws_vpc.custom-vpc.id
  cidr_block = each.value
  count = var.azs
  availability_zone = var.networking.azs[count.index]
  map_public_ip_on_launch = true

  tags = {
    Name = "${var.networking.tag_name}-${var.networking.public_subnets}-public-subnet"
  }
}

# Internet Gateway
resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.custom-vpc.id

  tags = {
    Name = "${var.networking.tag_name}-igw"
  }
}

# Public Route table 
resource "aws_route_table" "public-table" {
  vpc_id = aws_vpc.custom-vpc.id

  tags = {
    Name = "${var.networking.tag_name}-public-table"
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
resource "aws_subnet" "private-subnets" {
  for_each = var.networking.private_subnets != null && var.networking.private_subnets != [] ? toset(var.networking.private_subnets) : {}
  vpc_id = aws_vpc.custom-vpc.id
  cidr_block = cidrsubnet(aws_vpc.custom-vpc.cidr_block,8,length(var.networking.private_subnets)+20)
  availability_zone = each.value
  map_public_ip_on_launch = false

  tags = {
    Name = "${var.networking.tag_name}-${var.networking.public_subnets}-private-subnet"
  }
}