variable "vpc" {
    type = string
}
variable "sub_cidr" {
    default = "10.0.1.0/24"
}

variable "public_ips"{
    default = false
}

variable "name"{
    default = "subnet"
}