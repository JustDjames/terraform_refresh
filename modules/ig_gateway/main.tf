resource "aws_internet_gateway" "ig"{
    vpc_id = var.vpc

    tags = {
        Name = var.name
    }
}