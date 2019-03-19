#--------------------------------------------------------------
# Routing table for private subnets
#--------------------------------------------------------------
resource "aws_route_table" "private_route_table" {
  count            = "${length(split(",", var.private_subnets))}"
  vpc_id           = "${aws_vpc.main.id}"
  propagating_vgws = ["${compact(concat(split(",", var.vpc_propagating_vgws), list(aws_vpn_gateway.main_vgw.id)))}"]

  tags {
    Name          = "${var.environment}.rt.private.${element(split(",", var.availability_zones), count.index)}"
    Environment   = "${var.environment}"
    Description   = "private.${element(split(",", var.availability_zones), count.index)}"
    Contact       = "${var.vpc_contact}"
    Orchestration = "${var.global_orchestration}"
  }

  lifecycle {
    create_before_destroy = true
  }
}

#--------------------------------------------------------------
# Route for private routing table
#--------------------------------------------------------------
resource "aws_route" "private_route" {
  count                  = "${var.nat_gateway_enabled > 0 ? (length(split(",", var.private_subnets))): 0}"
  route_table_id         = "${element(aws_route_table.private_route_table.*.id, count.index)}"
  destination_cidr_block = "0.0.0.0/0"
  nat_gateway_id         = "${element(aws_nat_gateway.nat.*.id, count.index)}"
}

#--------------------------------------------------------------
# Association between private subnets and route tables
#--------------------------------------------------------------
resource "aws_route_table_association" "private_rt_assoc" {
  count          = "${length(split(",", var.private_subnets))}"
  subnet_id      = "${element(aws_subnet.private_subnets.*.id, count.index)}"
  route_table_id = "${element(aws_route_table.private_route_table.*.id, count.index)}"
}

#--------------------------------------------------------------
# Routing table for Secondary private subnets
#--------------------------------------------------------------
resource "aws_route_table" "secondary_private_route_table" {
  count            = "${length(split(",", var.secondary_private_subnets))}"
  vpc_id           = "${aws_vpc.main.id}"
  propagating_vgws = ["${compact(concat(split(",", var.vpc_propagating_vgws), list(aws_vpn_gateway.main_vgw.id)))}"]

  tags {
    Name          = "${var.environment}.rt.secondary.private.${element(split(",", var.availability_zones), count.index)}"
    Environment   = "${var.environment}"
    Description   = "secondary.private.${element(split(",", var.availability_zones), count.index)}"
    Contact       = "${var.vpc_contact}"
    Orchestration = "${var.global_orchestration}"
  }

  lifecycle {
    create_before_destroy = true
  }
}

#--------------------------------------------------------------
# Route for private routing table
#--------------------------------------------------------------
resource "aws_route" "secondary_private_route" {
  count                  = "${var.nat_gateway_enabled > 0 ? (length(split(",", var.secondary_private_subnets))): 0}"
  route_table_id         = "${element(aws_route_table.secondary_private_route_table.*.id, count.index)}"
  destination_cidr_block = "0.0.0.0/0"
  nat_gateway_id         = "${element(aws_nat_gateway.nat.*.id, count.index)}"
}

#--------------------------------------------------------------
# Association between private subnets and route tables
#--------------------------------------------------------------
resource "aws_route_table_association" "secondary_private_rt_assoc" {
  count          = "${length(split(",", var.secondary_private_subnets))}"
  subnet_id      = "${element(aws_subnet.secondary_private_subnets.*.id, count.index)}"
  route_table_id = "${element(aws_route_table.secondary_private_route_table.*.id, count.index)}"
}

#--------------------------------------------------------------
# Routing table for public subnets
#--------------------------------------------------------------
resource "aws_route_table" "public_route_table" {
  count  = "${length(split(",", var.public_subnets))}"
  vpc_id = "${aws_vpc.main.id}"

  tags {
    Name          = "${var.environment}.rt.public.${element(split(",", var.availability_zones), count.index)}"
    Environment   = "${var.environment}"
    Description   = "public.${element(split(",", var.availability_zones), count.index)}"
    Contact       = "${var.vpc_contact}"
    Orchestration = "${var.global_orchestration}"
  }
}

#--------------------------------------------------------------
# Route for public routing table
#--------------------------------------------------------------
resource "aws_route" "public_route" {
  count                  = "${length(split(",", var.public_subnets))}"
  route_table_id         = "${element(aws_route_table.public_route_table.*.id, count.index)}"
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = "${aws_internet_gateway.gw.id}"
}

#--------------------------------------------------------------
# Association between public subnets and route tables
#--------------------------------------------------------------
resource "aws_route_table_association" "public_rt_assoc" {
  count          = "${length(split(",", var.public_subnets))}"
  subnet_id      = "${element(aws_subnet.public_subnets.*.id, count.index)}"
  route_table_id = "${element(aws_route_table.public_route_table.*.id, count.index)}"
}

#--------------------------------------------------------------
# Routing table for data subnets
#--------------------------------------------------------------
resource "aws_route_table" "data_route_table" {
  count  = "${length(split(",", var.data_subnets))}"
  vpc_id = "${aws_vpc.main.id}"

  tags {
    Name          = "${var.environment}.rt.data.${element(split(",", var.availability_zones), count.index)}"
    Environment   = "${var.environment}"
    Description   = "data.${element(split(",", var.availability_zones), count.index)}"
    Contact       = "${var.vpc_contact}"
    Orchestration = "${var.global_orchestration}"
  }
}

#--------------------------------------------------------------
# Route for data routing table
#--------------------------------------------------------------
resource "aws_route" "data_route" {
  count          = "${length(split(",", var.data_subnets))}"
  route_table_id = "${element(aws_route_table.data_route_table.*.id, count.index)}"

  # Default route, mapping the VPC's CIDR block to "local", is created implicitly and does not need to be specified.
}
