output "vpc_id" {
    value = try(aws_vpc.custom_vpc.id,null)

    depends_on = [ aws_vpc.custom_vpc ]
}

output "public_subnets" { 
    value = aws_subnet.public_subnets 
}