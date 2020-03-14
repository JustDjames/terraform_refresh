provider "aws"{
    profile = var.profile
    region = var.region
}

module "vpc" {
    source = "./modules/vpc"
    cidr = "10.1.0.0/16"
    name = "refresh_vpc"
}

module "internet_gateway" {
    source = "./modules/ig_gateway"
    vpc = module.vpc.vpc_id
    name = "refresh_ig"
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

module "nat_gateway" {
    source = "./modules/nat_gateway"
    eip_name = "refresh_nat_eip"
    subnet = module.public_subnet.subnet_id
}