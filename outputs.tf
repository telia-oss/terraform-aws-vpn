# ------------------------------------------------------------------------------
# Output
# ------------------------------------------------------------------------------

output "tunnel1_address" {
  value = "${aws_vpn_connection.main.tunnel1_address}"
}
output "tunnel2_address" {
  value = "${aws_vpn_connection.main.tunnel1_address}"
}