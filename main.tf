provider "aws"{
    profile = var.profile
    region = var.region
}

module "vpc" {
    source = "./modules/vpc"
    cidr = "10.1.0.0/16"
}

module "public_subnet" {
    source = "./modules/subnet"
    vpc = module.vpc.vpc_id
    public_ips = true
    sub_cidr = "10.1.1.0/24"
}