resource "aws_route53_zone" "route53_zone" {
  
  name = "${var.dns_domain}"
  vpc  {
     vpc_id = "${aws_vpc.main.id}"
  }

  tags {
    Name          = "${var.environment}.R53_Zone"
    Environment   = "${var.environment}"
    Description   = "Route53Zone"
    Contact       = "${var.vpc_contact}"
    Orchestration = "${var.global_orchestration}"
  }
}

resource "aws_vpc_dhcp_options" "dhcp_options" {
  domain_name         = "${var.dns_domain}"
  domain_name_servers = ["${split(",",var.domain_name_servers)}"]

  tags {
    Name          = "${var.environment}.dhcp_options"
    Environment   = "${var.environment}"
    Description   = "dhcp_options"
    Contact       = "${var.vpc_contact}"
    Orchestration = "${var.global_orchestration}"
  }
}

resource "aws_vpc_dhcp_options_association" "local_resolver" {
  vpc_id          = "${aws_vpc.main.id}"
  dhcp_options_id = "${aws_vpc_dhcp_options.dhcp_options.id}"
}
