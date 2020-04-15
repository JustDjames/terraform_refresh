resource "aws_security_group" "public_sg" {
  name = "refresh_public_sg"
  vpc_id = module.vpc.vpc_id

  ingress {
    description = "allow HTTP communication from internet"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  
  ingress {
    description = "allow HTTPS communication from internet"
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "allow icmp communication with instances in private subnet"
    from_port   = 0
    to_port     = 0
    protocol    = "icmp"
    cidr_blocks = [module.private_subnet.subnet_block]
  }

  ingress {
    description = "allow ssh access from your ip (WARNING: YOUR IP WILL CHANGE IF YOU RESTART YOUR PC )"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = [var.local_ip]
  }
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_security_group" "private_sg" {
  name = "refresh_private_sg"
  vpc_id = module.vpc.vpc_id

  ingress {
      description = " allow HTTPS communication with nat gateway"
      from_port   = 80
      to_port     = 80
      protocol    = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    description = "allow HTTPS communication from internet"
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    description = "allow icmp communication with instances in public subnet"
    from_port   = 0
    to_port     = 0
    protocol    = "icmp"
    cidr_blocks = [module.public_subnet.subnet_block]
  }
  ingress {
    description = "allow ssh access from your ip (WARNING: YOUR IP WILL CHANGE IF YOU RESTART YOUR PC )"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = [var.local_ip]
  }
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }  
}