output "ssh_sg_from_cci" {
  value = "${aws_security_group.ssh_from_cci.id}"
}

output "nat_eips" {
  value = "${join(",", aws_eip.nat.*.public_ip)}"
}

output "dns_zone_id" {
  value = "${aws_route53_zone.vpc_public_zone.zone_id}"
}

output "private_route_table" {
  value = "${join(",", aws_route_table.private_route_table.*.id)}"
}

output "public_route_table" {
  value = "${join(",", aws_route_table.public_route_table.*.id)}"
}

output "subnets_public" {
  value = "${join(",", aws_subnet.public_subnets.*.id)}"
}

output "subnets_private" {
  value = "${join(",", aws_subnet.private_subnets.*.id)}"
}

output "subnets_data" {
  value = "${join(",", aws_subnet.data_subnets.*.id)}"
}

output "vgw_id" {
  value = "${aws_vpn_gateway.main_vgw.id}"
}

output "vpc_id" {
  value = "${aws_vpc.main.id}"
}

output "vpc_cidr" {
  value = "${aws_vpc.main.cidr_block}"
}

output "zone_id" {
  value = "${aws_route53_zone.vpc_public_zone.zone_id}"
}
