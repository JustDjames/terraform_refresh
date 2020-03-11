provider "aws"{
    profile = var.profile
    region = var.region
}

module "vpc" {
    source = "./modules/vpc"
    cidr = "10.1.0.0/16"
}