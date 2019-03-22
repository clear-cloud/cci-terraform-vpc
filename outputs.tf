output "dns_zone_id" {
  value = "${aws_route53_zone.route53_zone.zone_id}"
}

output "vpc_sg" {
  value = "${aws_security_group.vpc_sg.id}"
}

output "nat_eips" {
  value = "${join(",", aws_eip.nat.*.public_ip)}"
}

output "private_route_table" {
  value = "${join(",", aws_route_table.private_route_table.*.id)}"
}

output "public_route_table" {
  value = "${join(",", aws_route_table.public_route_table.*.id)}"
}

output "all_route_tables" {
  value = "${join(",", aws_route_table.data_route_table.*.id, aws_route_table.private_route_table.*.id, aws_route_table.public_route_table.*.id, aws_route_table.secondary_private_route_table.*.id)}"
}

output "subnets_public" {
  value = "${join(",", aws_subnet.public_subnets.*.id)}"
}

output "subnets_private" {
  value = "${join(",", aws_subnet.private_subnets.*.id)}"
}

output "subnets_all" {
  value = "${join(",", aws_subnet.public_subnets.*.id, aws_subnet.private_subnets.*.id, aws_subnet.secondary_private_subnets.*.id, aws_subnet.data_subnets.*.id)}"
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
  value = "${aws_route53_zone.route53_zone.zone_id}"
}
