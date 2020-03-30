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

resource "aws_route_table" "public_rt" {
  vpc_id = module.vpc.vpc_id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = module.internet_gateway.ig_id
  }
  tags = {
      Name = "refresh_public_route_table"
  }
}

resource "aws_route_table_association" "public_association" {
  subnet_id      = module.public_subnet.subnet_id
  route_table_id = aws_route_table.public_rt.id
}

resource "aws_route_table" "private_rt" {
  vpc_id = module.vpc.vpc_id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = module.nat_gateway.nat_id
  }
  tags = {
      Name = "refresh_private_route_table"
  }
}

resource "aws_route_table_association" "private_association" {
  subnet_id      = module.private_subnet.subnet_id
  route_table_id = aws_route_table.private_rt.id
}