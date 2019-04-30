## Standard VPC build.

Upon launching the stack the following resources will be created:

 * VPC infrastructure
 * Public, private & data subnets as defined in input variables.
 * Route tables for subnets
 * Generic security groups
 * Route53 Hosted Zone
 * Elastic IPs and Managed NAT gateway devices for each Availability Zone
 * A virtual private gateway for use with Direct Connect and/or IPsec VPNs

## Dependencies and Prerequisites
 * Terraform v0.11.11 or higher
 * AWS account

## Variables
| Variable | Meaning |
| :------- | :----- |
| `all_cidr_blocks`| Default: 0.0.0.0/0 |
| `domain_name_servers` | Comma separated list of domain name servers to use in DHCP options|
| `key_name` | ssh key name to use |
| `vpc_subnet` | VPC CIDR block to use for the VPC |
| `vpc_name` | Name of the VPC |
| `availability_zones` | Availability Zones to use |
| `public_subnets` | CIDR blocks for the public subnets |
| `private_subnets` | CIDR blocks for the private subnets |
| `data_subnets` | CIDR blocks for the data subnets |
| `environment` |Environment to deploy for|
| `vpc_propagating_vgws` |Comma separated list of Virtual Gateways that propagate routes to the private routing tables in addition to the one created. Optional. |
| `vpc_enable_flow_logs` |Set to "1" to enable flow logs for the VPC, logging to Cloudwatch group `/aws/vpc/`. Defaults to "0"|

## Outputs
 * ssh\_sg\_from\_cci
 * nat\_eips
 * dns\_zone\_id
 * public\_subnets
 * private\_subnets
 * vgw\_id
 * vpc\_id
 * dns\_zone\_id
 * private\_route\_table
 * public\_route\_table

## Usage

To import the module add the following to the environment TF file:
```
module "vpc" {
  source = "git::https://github.com/clear-cloud/cci-terraform-vpc.git"

  availability_zones        = "${var.availability_zones}"
  environment               = "${var.environment}"
  dns_domain                = "${var.dns_domain}"
  private_subnets           = "${var.private_subnets}"
  data_subnets              = "${var.data_subnets}"
  public_subnets            = "${var.public_subnets}"
  vpc_subnet                = "${var.vpc_subnet_cidr}"
  vpc_contact               = "${var.contact}"
  cci_cidr_blocks           = "${var.cci_cidr_blocks}"
  global_orchestration      = "${var.orchestration}"
}
```
* To initialise the module run: terraform init
* To update the module run    : terraform get --update
* To see a plan of changes    : terraform plan
* To apply                    : terraform apply 

## Current DEV branches

EnableDisableNATs - DEV branch where NAT gateways are not available by default and there is a secondary set of private subnets.

