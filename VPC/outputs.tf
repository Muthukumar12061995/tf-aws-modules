output "vpc_id" { value = aws_vpc.custom-vpc.id}

output "public_subnets" { value = aws_subnet.public-subnets }