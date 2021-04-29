provider "aws" {
  region = "eu-west-1"
}

locals {
  name_prefix    = "vpn-test-default"
  vpc_cidr_block = "10.10.0.0/16"

  public_subnet_cidrs = [
    "10.10.0.0/20",
    "10.10.16.0/20",
    "10.10.32.0/20",
  ]

  private_subnet_cidrs = [
    "10.10.48.0/20",
    "10.10.64.0/20",
  ]

  tags = {
    terraform   = "True"
    environment = "example"
  }
}

module "vpc" {
  source               = "telia-oss/vpc/aws"
  version              = "4.1.0"
  name_prefix          = local.name_prefix
  cidr_block           = local.vpc_cidr_block
  public_subnet_cidrs  = local.public_subnet_cidrs
  private_subnet_cidrs = local.private_subnet_cidrs
  create_nat_gateways  = "false"
  enable_dns_hostnames = "true"
  tags                 = local.tags
}

module "vpn" {
  source                          = "../../"
  customer_gateway_bgp_asn        = "64952"
  customer_gateway_ip             = "203.0.113.10" //Valid IP address needed for test. A TEST-NET-3 address used (https://tools.ietf.org/html/rfc5737)
  name_prefix                     = local.name_prefix
  private_subnet_count            = "0"
  private_subnets_route_table_ids = module.vpc.private_subnets_route_table_ids
  public_subnets_route_table_id   = module.vpc.public_subnets_route_table_id
  vpc_id                          = module.vpc.vpc_id
  amazon_side_asn                 = "64951"
}
