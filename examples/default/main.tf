terraform {
  required_version = "0.11.11"

  backend "s3" {
    key            = "terraform-modules/development/terraform-aws-vpn/default.tfstate"
    bucket         = "<test-account-id>-terraform-state"
    dynamodb_table = "<test-account-id>-terraform-state"
    acl            = "bucket-owner-full-control"
    encrypt        = "true"
    kms_key_id     = "<kms-key-id>"
    region         = "eu-west-1"
  }
}

provider "aws" {
  version             = "1.52.0"
  region              = "eu-west-1"
  allowed_account_ids = ["<test-account-id>"]
}

locals {
  name_prefix    = "vpn-example"
  vpc_cidr_block = "10.10.0.0/16"

  tags = {
    terraform   = "True"
    environment = "example"
  }
}

module "vpc" {
  source               = "telia-oss/vpc/aws"
  version              = "0.2.0"
  name_prefix          = "${local.name_prefix}"
  cidr_block           = "${local.vpc_cidr_block}"
  private_subnet_count = "0"
  create_nat_gateways  = "false"
  enable_dns_hostnames = "true"
  tags                 = "${local.tags}"
}

module "vpn" {
  source                          = "../../"
  customer_gateway_bgp_asn        = "64952"
  customer_gateway_ip             = "203.0.113.10"                                  //Valid IP address needed for test. A TEST-NET-3 address used (https://tools.ietf.org/html/rfc5737)
  name_prefix                     = "${local.name_prefix}"
  private_subnet_count            = "0"
  private_subnets_route_table_ids = "${module.vpc.private_subnets_route_table_ids}"
  public_subnets_route_table_id   = "${module.vpc.public_subnets_route_table_id}"
  vpc_id                          = "${module.vpc.vpc_id}"
  amazon_side_asn                 = "64951"
}
