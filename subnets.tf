#--------------------------------------------------------------
# Public subnets resource definition
#--------------------------------------------------------------

resource "aws_subnet" "public_subnets" {
  count                   = length(split(",", var.public_subnets))
  vpc_id                  = aws_vpc.main.id
  cidr_block              = element(split(",", var.public_subnets), count.index)
  availability_zone       = element(split(",", var.availability_zones), count.index)
  map_public_ip_on_launch = true

  tags = {
    Name          = "${var.environment}.sn.public.${element(split(",", var.availability_zones), count.index)}"
    Environment   = var.environment
    Description   = "public.${element(split(",", var.availability_zones), count.index)}"
    Contact       = var.vpc_contact
    Orchestration = var.global_orchestration
    Visibility    = "public"
  }
}

#--------------------------------------------------------------
# Private subnets resource definition
#--------------------------------------------------------------

resource "aws_subnet" "private_subnets" {
  count                   = length(split(",", var.private_subnets))
  vpc_id                  = aws_vpc.main.id
  cidr_block              = element(split(",", var.private_subnets), count.index)
  availability_zone       = element(split(",", var.availability_zones), count.index)
  map_public_ip_on_launch = false

  tags = {
    Name          = "${var.environment}.sn.private.${element(split(",", var.availability_zones), count.index)}"
    Environment   = var.environment
    Description   = "private.${element(split(",", var.availability_zones), count.index)}"
    Contact       = var.vpc_contact
    Orchestration = var.global_orchestration
    Visibility    = "private"
  }
}

#--------------------------------------------------------------
# Data subnets resource definition
#--------------------------------------------------------------

resource "aws_subnet" "data_subnets" {
  count                   = length(split(",", var.data_subnets))
  vpc_id                  = aws_vpc.main.id
  cidr_block              = element(split(",", var.data_subnets), count.index)
  availability_zone       = element(split(",", var.availability_zones), count.index)
  map_public_ip_on_launch = false

  tags = {
    Name          = "${var.environment}.sn.data.${element(split(",", var.availability_zones), count.index)}"
    Environment   = var.environment
    Description   = "data.${element(split(",", var.availability_zones), count.index)}"
    Contact       = var.vpc_contact
    Orchestration = var.global_orchestration
    Visibility    = "private"
  }
}

