variable "ami" {}

variable "type" {
  default = "t2.micro"
}

variable "key" {}

variable "subnet" {}

variable "security_groups" {
  type = list(string)
}

# variable to decide wheter to output private or public ip
variable "public_ip" {
  type    = bool
  default = false
}

variable "name" {}