resource "aws_vpc" "vpc"{
    cidr_block = var.cidr
    
    tags = {
        Name = var.vpc_name
    }
}

resource "aws_internet_gateway" "ig"{
    vpc_id = aws_vpc.vpc.id

    tags = {
        Name = var.ig_name
    }
}