output "vpc_id" {
    value = module.vpc.vpc_id 
}

output "public_subnet_name" {
    value = module.public_subnet.subnet_name
}

output "public_subnet_block" {
    value = module.public_subnet.subnet_block
}

output "private_subnet_name" {
    value = module.private_subnet.subnet_name
}

output "private_subnet_block" {
    value = module.private_subnet.subnet_block
}