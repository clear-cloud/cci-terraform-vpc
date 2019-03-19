variable "all_cidr_blocks" {
  default = "0.0.0.0/0"
}

variable "cci_cidr_blocks" {}
variable "vpc_subnet" {}
variable "dns_domain" {}
variable "availability_zones" {}
variable "public_subnets" {}
variable "private_subnets" {}
variable "secondary_private_subnets" {
  description = "Secondary private CIDR range"
  default = ""
}
variable "data_subnets" {}
variable "environment" {}
variable "vpc_contact" {}
variable "global_orchestration" {}

variable "domain_name_servers" {
  description = "Comma separated list of domain name servers to use in DHCP options"
  default     = "AmazonProvidedDNS"
}

variable "vpc_propagating_vgws" {
  description = "Comma separated list of Virtual Gateways that propagate routes to the private routing tables in addition to the one created."
  default     = ""
}

variable "vpc_enable_flow_logs" {
  description = "Set to 1 to enable flow logs for the VPC"
  default     = "0"
}
variable "nat_gateway_enabled" {
  description = "Allows enabling or disabling NAT gateway(s)"
  default     = "1"
}
