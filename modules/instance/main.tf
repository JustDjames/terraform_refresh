resource "aws_instance" "instance" {
    ami = var.ami
    instance_type = var.type
    key_name = var.key
    subnet_id = var.subnet
    vpc_security_group_ids = var.security_groups
    associate_public_ip_address = var.public_ip

    tags = {
        Name = var.name
        project = "refresh"
    }
}