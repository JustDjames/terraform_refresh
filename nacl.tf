module "public_nacl" {
  source      = "./modules/nacl"
  vpc_id      = module.vpc.vpc_id
  subnet_list = [module.public_subnet.subnet_id]
  name = "refresh_public_nacl"
}

resource "aws_network_acl_rule" "vpc_http_ingress" {
  network_acl_id = module.public_nacl.nacl_id
  rule_number    = 100
  egress         = false
  protocol       = "tcp"
  rule_action    = "allow"
  cidr_block     = module.vpc.vpc_block
  from_port      = 80
  to_port        = 80  
}

resource "aws_network_acl_rule" "vpc_http_egress" {
  network_acl_id = module.public_nacl.nacl_id
  rule_number    = 100
  egress         = true
  protocol       = "tcp"
  rule_action    = "allow"
  cidr_block     = module.vpc.vpc_block
  from_port      = 80
  to_port        = 80  
}

resource "aws_network_acl_rule" "vpc_https_ingress" {
  network_acl_id = module.public_nacl.nacl_id
  rule_number    = 200
  egress         = false
  protocol       = "tcp"
  rule_action    = "allow"
  cidr_block     = module.vpc.vpc_block
  from_port      = 443
  to_port        = 443  
}

resource "aws_network_acl_rule" "vpc_https_egress" {
  network_acl_id = module.public_nacl.nacl_id
  rule_number    = 200
  egress         = true
  protocol       = "tcp"
  rule_action    = "allow"
  cidr_block     = module.vpc.vpc_block
  from_port      = 443
  to_port        = 443  
}

resource "aws_network_acl_rule" "public_http_ingress" {
  network_acl_id = module.public_nacl.nacl_id
  rule_number    = 300
  egress         = false
  protocol       = "tcp"
  rule_action    = "allow"
  cidr_block     = "0.0.0.0/0"
  from_port      = 80
  to_port        = 80
}

resource "aws_network_acl_rule" "public_http_egress" {
  network_acl_id = module.public_nacl.nacl_id
  rule_number    = 300
  egress         = true
  protocol       = "tcp"
  rule_action    = "allow"
  cidr_block     = "0.0.0.0/0"
  from_port      = 80
  to_port        = 80
}

resource "aws_network_acl_rule" "public_https_ingress" {
  network_acl_id = module.public_nacl.nacl_id
  rule_number    = 400
  egress         = false
  protocol       = "tcp"
  rule_action    = "allow"
  cidr_block     = "0.0.0.0/0"
  from_port      = 443
  to_port        = 443
}

resource "aws_network_acl_rule" "public_https_egress" {
  network_acl_id = module.public_nacl.nacl_id
  rule_number    = 400
  egress         = true
  protocol       = "tcp"
  rule_action    = "allow"
  cidr_block     = "0.0.0.0/0"
  from_port      = 443
  to_port        = 443
}

resource "aws_network_acl_rule" "ssh_ingress" {
  network_acl_id = module.public_nacl.nacl_id
  rule_number    = 500
  egress         = false
  protocol       = "tcp"
  rule_action    = "allow"
  cidr_block     = var.local_ip
  from_port      = 22
  to_port        = 22
}

resource "aws_network_acl_rule" "ssh_egress" {
  network_acl_id = module.public_nacl.nacl_id
  rule_number    = 500
  egress         = true
  protocol       = "tcp"
  rule_action    = "allow"
  cidr_block     = var.local_ip
  from_port      = 22
  to_port        = 22
}

resource "aws_network_acl_rule" "icmp_ingress" {
  network_acl_id = module.public_nacl.nacl_id
  rule_number          = 600
  egress         = false
  protocol       = "icmp"
  rule_action    = "allow"
  cidr_block     = module.private_subnet.subnet_block
  icmp_type      = -1
  icmp_code      = -1
}

resource "aws_network_acl_rule" "icmp_egress" {
  network_acl_id = module.public_nacl.nacl_id
  rule_number          = 600
  egress         = true
  protocol       = "icmp"
  rule_action    = "allow"
  cidr_block     = module.private_subnet.subnet_block
  icmp_type      = -1
  icmp_code      = -1
}
