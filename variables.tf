# ------------------------------------------------------------------------------
# Variables
# ------------------------------------------------------------------------------
variable "customer_gateway_bgp_asn" {
  description = "The customer (remote) gateway's Border Gateway Protocol (BGP) Autonomous System Number (ASN)."
}

variable "customer_gateway_ip" {
  description = "The IP address of the customer (remote) gateway's Internet-routable external interface."
}

variable "name_prefix" {
  description = "A prefix used for naming resources."
}

variable "private_subnet_count" {
  description = "The number of private subnets the VPC has"
}

variable "private_subnets_route_table_ids" {
  description = "The id(s) of the private aws_route_table(s) to propagate routes into."
  type        = "list"
}

variable "public_subnets_route_table_id" {
  description = "The id of the public aws_route_table to propagate routes into."
}

variable "tags" {
  description = "A map of tags (key-value pairs) passed to resources."
  type        = "map"
  default     = {}
}

variable "vpc_id" {
  description = "The VPC ID."
}

variable "amazon_side_asn" {
  description = "The Autonomous System Number (ASN) for the Amazon side of the specific VPN Gateway to retrieve. Default provided is a valid private ASN"
  default     = "64951"
}
