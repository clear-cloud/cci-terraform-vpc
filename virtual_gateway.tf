resource "aws_vpn_gateway" "main_vgw" {
  vpc_id = "${aws_vpc.main.id}"

  tags {
    Name          = "${var.environment}.vgw"
    Environment   = "${var.environment}"
    Description   = "vgw"
    Contact       = "${var.vpc_contact}"
    Orchestration = "${var.global_orchestration}"
  }
}
