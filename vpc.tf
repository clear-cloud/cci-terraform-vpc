#--------------------------------------------------------------
# VPC
#--------------------------------------------------------------

resource "aws_vpc" "main" {
  cidr_block           = var.vpc_subnet
  enable_dns_hostnames = true

  tags = {
    Name          = "${var.environment}.vpc"
    Environment   = var.environment
    Description   = "vpc"
    Contact       = var.vpc_contact
    Orchestration = var.global_orchestration
  }
}

