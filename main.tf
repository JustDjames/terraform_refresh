provider "aws"{
    profile = var.profile
    region = var.region
}

module "vpc" {
    source = "./modules/vpc"
    cidr = "10.1.0.0/16"
    vpc_name = "refresh_vpc"
    ig_name = "refresh_ig"
}

module "public_subnet" {
    source = "./modules/subnet"
    vpc = module.vpc.vpc_id
    public_ips = true
    sub_cidr = "10.1.1.0/24"
    name = "refresh_public_subnet"
}

module "private_subnet" {
    source = "./modules/subnet"
    vpc = module.vpc.vpc_id
    public_ips = false
    sub_cidr = "10.1.2.0/24"
    name = "refresh_private_subnet"
}