resource "aws_subnet" "subnet" {
    vpc_id = var.vpc
    cidr_block = var.sub_cidr
    map_public_ip_on_launch = var.public_ips

    tags = {
        Name = var.name
    }
}