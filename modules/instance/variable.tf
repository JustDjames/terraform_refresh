variable "ami" { }

variable "type" {
    default = "t2.micro"
}

variable "key" { }

variable "subnet" { }

variable "security_groups" {
    type = list(string)
}

variable "public_ip" {
    default = false
}

variable "name" { }