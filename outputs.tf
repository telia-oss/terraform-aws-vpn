# ------------------------------------------------------------------------------
# Output
# ------------------------------------------------------------------------------

output "tunnel1_address" {
  description = "The public IP address of the first VPN tunnel."
  value       = "${aws_vpn_connection.main.tunnel1_address}"
}

output "tunnel2_address" {
  description = "The public IP address of the second VPN tunnel."
  value       = "${aws_vpn_connection.main.tunnel2_address}"
}
