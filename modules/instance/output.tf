output "instance_ip" {
    value = var.public_ip ? aws_instance.instance.public_ip:aws_instance.instance.private_ip
}