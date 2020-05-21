module "public_nacl" {
  source      = "./modules/nacl"
  vpc_id      = module.vpc.vpc_id
  subnet_list = [module.public_subnet.subnet_id]
  name = "refresh_public_nacl"
}

resource "aws_network_acl_rule" "public_vpc_http_ingress" {
  network_acl_id = module.public_nacl.nacl_id
  rule_number    = 100
  egress         = false
  protocol       = "tcp"
  rule_action    = "allow"
  cidr_block     = module.vpc.vpc_block
  from_port      = 80
  to_port        = 80  
}

resource "aws_network_acl_rule" "public_vpc_https_ingress" {
  network_acl_id = module.public_nacl.nacl_id
  rule_number    = 200
  egress         = false
  protocol       = "tcp"
  rule_action    = "allow"
  cidr_block     = module.vpc.vpc_block
  from_port      = 443
  to_port        = 443  
}

resource "aws_network_acl_rule" "public_outer_http_ingress" {
  network_acl_id = module.public_nacl.nacl_id
  rule_number    = 300
  egress         = false
  protocol       = "tcp"
  rule_action    = "allow"
  cidr_block     = "0.0.0.0/0"
  from_port      = 80
  to_port        = 80
}

resource "aws_network_acl_rule" "public_outer_https_ingress" {
  network_acl_id = module.public_nacl.nacl_id
  rule_number    = 400
  egress         = false
  protocol       = "tcp"
  rule_action    = "allow"
  cidr_block     = "0.0.0.0/0"
  from_port      = 443
  to_port        = 443
}

resource "aws_network_acl_rule" "public_ssh_ingress" {
  network_acl_id = module.public_nacl.nacl_id
  rule_number    = 500
  egress         = false
  protocol       = "tcp"
  rule_action    = "allow"
  cidr_block     = var.local_ip
  from_port      = 22
  to_port        = 22
}

resource "aws_network_acl_rule" "public_icmp_ingress" {
  network_acl_id = module.public_nacl.nacl_id
  rule_number    = 600
  egress         = false
  protocol       = "icmp"
  rule_action    = "allow"
  cidr_block     = module.private_subnet.subnet_block
  icmp_type      = -1
  icmp_code      = -1
}

# allows public instances to reply to requests from the private instances
resource "aws_network_acl_rule" "private_ephemeral_ingress" {
  network_acl_id = module.public_nacl.nacl_id
  rule_number    = 700
  egress         = false
  protocol       = "tcp"
  rule_action    = "allow"
  cidr_block     = module.private_subnet.subnet_block
  from_port      = 32768
  to_port        = 65535
}

# allows my pc to reply to requests from the public instances
resource "aws_network_acl_rule" "public_ephemeral_egress" {
  network_acl_id = module.public_nacl.nacl_id
  rule_number = 100
  egress      = true
  protocol    = "tcp"
  rule_action = "allow"
  cidr_block  = var.local_ip
  from_port   = 32768
  to_port     = 65535
}

# private nacl

module "private_nacl" {
  source      = "./modules/nacl"
  vpc_id      = module.vpc.vpc_id
  subnet_list = [module.private_subnet.subnet_id]
  name        = "refresh_private_nacl"
}

resource "aws_network_acl_rule" "private_vpc_http_ingress" {
  network_acl_id = module.private_nacl.nacl_id
  rule_number    = 100
  egress         = false
  protocol       = "tcp"
  rule_action    = "allow"
  cidr_block     = module.vpc.vpc_block
  from_port      = 80
  to_port        = 80
}

resource "aws_network_acl_rule" "private_vpc_https_ingress" {
  network_acl_id = module.private_nacl.nacl_id
  rule_number    = 200
  egress         = false
  protocol       = "tcp"
  rule_action    = "allow"
  cidr_block     = module.vpc.vpc_block
  from_port      = 443
  to_port        = 443
}

resource "aws_network_acl_rule" "private_ssh_ingress" {
  network_acl_id = module.private_nacl.nacl_id
  rule_number    = 300
  egress         = false
  protocol       = "tcp"
  rule_action    = "allow"
  cidr_block     = module.public_subnet.subnet_block
  from_port      = 22
  to_port        = 22
}

resource "aws_network_acl_rule" "private_icmp_ingress" {
  network_acl_id = module.private_nacl.nacl_id
  rule_number    = 400
  egress         = false
  protocol       = "icmp"
  rule_action    = "allow"
  cidr_block     = module.public_subnet.subnet_block
  icmp_type      = -1
  icmp_code      = -1
}

resource "aws_network_acl_rule" "private_nat_ephemeral_ingress" {
  network_acl_id = module.private_nacl.nacl_id
  rule_number    = 500
  egress         = false
  protocol       = "tcp"
  rule_action    = "allow"
  cidr_block     = "0.0.0.0/0"
  from_port      = 1024
  to_port        = 65535
}

resource "aws_network_acl_rule" "private_nat_ephemeral_egress" {
  network_acl_id = module.private_nacl.nacl_id
  rule_number    = 100
  egress         = true
  protocol       = "tcp"
  rule_action    = "allow"
  cidr_block     = "0.0.0.0/0"
  from_port      = 1024
  to_port        = 65535 
}