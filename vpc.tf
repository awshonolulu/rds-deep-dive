module "vpc" {
  source = "terraform-aws-modules/vpc/aws"

  name = "${var.service}-${var.service_instance}-vpc"
  cidr = "${var.vpc_cidr}"

  azs = ["${var.availability_zones}"]

  private_subnets  = ["${var.vpc_private_subnets}"]
  public_subnets   = ["${var.vpc_public_subnets}"]
  database_subnets = ["${var.vpc_database_subnets}"]

  enable_nat_gateway           = true
  enable_vpn_gateway           = false
  enable_dns_hostnames         = true
  create_database_subnet_group = true

  private_subnet_tags = {
    Layer = "private"
  }

  public_subnet_tags = {
    Layer = "public"
  }

  tags = "${merge(var.global_tags, map("Name","${var.service}-${var.service_instance}-vpc"))}"
}

resource "aws_security_group" "rds_open" {
  name        = "${var.service}-${var.service_instance}-mysql-sg"
  description = "inbound MySQL traffic"
  vpc_id      = "${module.vpc.vpc_id}"

  ingress {
    from_port   = 3306
    to_port     = 3306
    protocol    = "TCP"
    description = "Port for mysql traffic"
    cidr_blocks = ["${var.service_ip_whitelist}"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}
