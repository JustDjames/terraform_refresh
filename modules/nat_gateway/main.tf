resource "aws_eip" "nat_eip" {
    tags = {
        Name = var.eip_name
    }
}

resource "aws_nat_gateway" "nat_gw" {
    allocation_id = aws_eip.nat_eip.id
    subnet_id = var.subnet
    tags = {
        Name = var.nat_name
    }
}