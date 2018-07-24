# ------------------------------------------------------------------------------
# Resources
# ------------------------------------------------------------------------------
resource "aws_customer_gateway" "customer-gateway" {
  bgp_asn    = "${var.customer_gateway_bgp_asn}"
  ip_address = "${var.customer_gateway_ip}"
  type       = "ipsec.1"
}

resource "aws_vpn_gateway" "vpn-gateway" {
  vpc_id          = "${var.vpc_id}"
  tags            = "${var.tags}"
  amazon_side_asn = "${var.amazon_side_asn}"
}

resource "aws_vpn_gateway_route_propagation" "public_out" {
  route_table_id = "${var.public_subnets_route_table_id}"
  vpn_gateway_id = "${aws_vpn_gateway.vpn-gateway.id}"
}

resource "aws_vpn_gateway_route_propagation" "private_out" {
  count          = "${var.private_subnet_count}"
  route_table_id = "${element(var.private_subnets_route_table_ids,count.index)}"
  vpn_gateway_id = "${aws_vpn_gateway.vpn-gateway.id}"
}

resource "aws_vpn_connection" "main" {
  customer_gateway_id = "${aws_customer_gateway.customer-gateway.id}"
  type                = "ipsec.1"
  vpn_gateway_id      = "${aws_vpn_gateway.vpn-gateway.id}"
  tags                = "${var.tags}"
}
