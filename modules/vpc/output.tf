output "vpc_id" {
    value = aws_vpc.vpc.id
}

output "vpc_block" {
    value = aws_vpc.vpc.cidr_block
}